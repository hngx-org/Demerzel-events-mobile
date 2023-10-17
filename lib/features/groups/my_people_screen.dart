// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/riverpod/group_provider.dart';
import 'package:hng_events_app/riverpod/user_provider.dart';
import 'package:hng_events_app/features/groups/create_group.dart';
import 'package:hng_events_app/features/groups/search_group.dart';
import 'package:hng_events_app/features/groups/edit_group.dart';
import 'package:hng_events_app/widgets/my_people_card.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';
import 'package:hng_events_app/models/group.dart';
import 'group_event_list_screen.dart';

class MyPeopleScreen extends ConsumerStatefulWidget {
  const MyPeopleScreen({super.key});

  @override
  ConsumerState<MyPeopleScreen> createState() => _CreateGroupState();
}

class _CreateGroupState extends ConsumerState<MyPeopleScreen> {
  @override
  Widget build(BuildContext context) {
    final groupsNotifier = ref.watch(GroupProvider.groupProvider);

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: Container(
                height: 1,
                color: Colors.black,
              )),
          title: Text(
            'My People',
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: NeuTextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateGroup(),
                    ),
                  );
                },
                buttonColor: Theme.of(context).primaryColor,
                shadowColor: Theme.of(context).colorScheme.onBackground,
                borderColor: Theme.of(context).colorScheme.onBackground,
                buttonHeight: 40,
                borderRadius: BorderRadius.circular(8),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          'Create',
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        const Icon(Icons.add),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Consumer(builder: (context, ref, child) {
              List<Group> groups = ref.watch(groupSearchprovider);
              return IconButton(
                  onPressed: () => showSearch(
                      context: context,
                      delegate: GroupSearchDelegate(groups: groups)),
                  icon: const Icon(Icons.search));
            })
          ],
        ),
        body: groupsNotifier.groups.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Visibility(
                  visible: !groupsNotifier.isBusy,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemCount: groupsNotifier.groups.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      final currentGroup = groupsNotifier.groups[index];
                      return MyPeopleCard(
                        showVert: currentGroup.creatorId == ref.read(appUserProvider)?.id,
                          onDelete: (groupId) {
                            showDialog(
                                context: ctx,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: const Text("Delete group"),
                                    content: const Text(
                                        "Are you sure you want to delete group?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          try {
                                            Navigator.of(ctx).pop();
                                            
                                            final result = await groupsNotifier
                                                .deleteGroup(currentGroup.id);
                                            if (result) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                      "Group deleted successfully"),
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                    backgroundColor: Colors.red,
                                                      content: Text(
                                                          "Group could not be Deleted ")));
                                            }
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Group could not be deleted ")));
                                            //return
                                            // showDialog(
                                            //     context: context,
                                            //     builder: (context) {
                                            //       return AlertDialog(
                                            //         title: const Text(
                                            //             "Cannot delete the event"),
                                            //         content: const Text(
                                            //             "You did not create the event"),
                                            //         actions: [
                                            //           TextButton(
                                            //               onPressed: () {
                                            //                 Navigator.of(
                                            //                         context)
                                            //                     .pop();
                                            //               },
                                            //               child: const Text("OK"))
                                            //         ],
                                            //       );
                                            //     });
                                          }
                                        },
                                        child: const Text("Yes"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("No"),
                                      ),
                                    ],
                                  );
                                });
                          },
                          onEdit: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditGroupName(
                                  currentGroup: currentGroup,
                                ),
                              ),
                            );
                          },
                          title: currentGroup.name,
                          image: currentGroup.image,
                          eventLength: currentGroup.eventCount,
                          bubbleVisible: true,
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GroupEventsScreen(
                                    group: currentGroup,
                                  ),
                                ));
                          });
                    },
                  ),
                ),
              )
            : groupsNotifier.isBusy
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("No group was found",
                            textAlign: TextAlign.center),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            ref.refresh(groupTagProvider);
                            groupsNotifier.getGroups();
                          },
                          child: const Text(
                            "Tap to Retry",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ));
  }
}
