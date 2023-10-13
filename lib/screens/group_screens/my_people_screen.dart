import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/riverpod/group_provider.dart';
import 'package:hng_events_app/screens/create_group.dart';
import 'package:hng_events_app/screens/group_event_list_screen.dart';
import 'package:hng_events_app/screens/group_screens/group_search_delegate.dart';
import 'package:hng_events_app/screens/group_screens/edit_group.dart';
import 'package:hng_events_app/widgets/my_people_card.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';
import 'package:hng_events_app/models/group.dart';

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
                    itemBuilder: (BuildContext context, int index) {
                      final currentGroup = groupsNotifier.groups[index];
                      return MyPeopleCard(
                          onDelete: (groupId) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Delete group"),
                                    content: const Text(
                                        "Are you sure you want to delete group?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          await groupsNotifier
                                              .deleteGroup(groupId)
                                              .then((value) => ref.refresh(
                                                  GroupProvider.groupProvider));
                                        },
                                        child: const Text("Yes"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("No"),
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
                                  builder: (context) => EventsScreen(
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
