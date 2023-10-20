// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/riverpod/group_provider.dart';
import 'package:hng_events_app/riverpod/pagination_state.dart';
import 'package:hng_events_app/riverpod/user_provider.dart';
import 'package:hng_events_app/features/groups/create_group.dart';
import 'package:hng_events_app/features/groups/search_group.dart';
import 'package:hng_events_app/features/groups/edit_group.dart';
import 'package:hng_events_app/widgets/my_people_card.dart';
import 'package:hng_events_app/widgets/ongoing_bottom_widget.dart';
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
   // final groupsNotifier = ref.watch(GroupProvider.groupProvider);
    final groups = ref.watch(groupsProvider);
    final ScrollController controller = ScrollController();
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
               // ref.refresh(groupsProvider);
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
            return IconButton(
                onPressed: () => showSearch(
                    context: context,
                    delegate: GroupSearchDelegate()),
                icon: const Icon(Icons.search));
          })
        ],
      ),
      body: CustomScrollView(
        controller: controller,
        slivers: [
          MyPeopleGrid(
            groups: groups,
          ),
          OngoingBottomWidget(
            state: ref.watch(groupsProvider),
          )
        ],
      ),
    );
  }
}

class MyPeopleGridBuilder extends ConsumerWidget {
  const MyPeopleGridBuilder({
    super.key,
    required this.groups,
  });

  final List<Group> groups;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
      itemCount: groups.length,
      itemBuilder: (BuildContext ctx, int index) {
        final currentGroup = groups[index];
        return MyPeopleCard(
            showVert: currentGroup.creatorId == ref.read(appUserProvider)?.id,
            onDelete: (groupId) {
              showDialog(
                  context: ctx,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text("Delete group"),
                      content:
                          const Text("Are you sure you want to delete group?"),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            try {
                              Navigator.of(ctx).pop();

                              final result = await ref
                                  .read(GroupProvider.groupProvider)
                                  .deleteGroup(currentGroup.id);
                              if (result) {
                                ref.refresh(groupsProvider);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text("Group deleted successfully"),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(ref
                                            .read(GroupProvider.groupProvider)
                                            .error)));
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Group could not be deleted ")));
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
    );
  }
}

class MyPeopleGrid extends ConsumerWidget {
  const MyPeopleGrid({
    super.key,
    required this.groups,
  });
  final PaginationState<Group> groups;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return groups.when(
      data: (groups) => MyPeopleGridBuilder(
        groups: groups,
      ),
      loading: () {
        return SliverToBoxAdapter(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.3,
                ),
                const CircularProgressIndicator(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Loading Groups...'),
                ),
              ],
            ),
          ),
        );
      },
      onGoingError: (List<Group> groups, Object? e, StackTrace? stk) {
        return MyPeopleGridBuilder(
          groups: groups,
        );
      },
      onGoingLoading: (groups) {
        return MyPeopleGridBuilder(
          groups: groups,
        );
      },
      error: (error, stackTrace) {
        return SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.35,
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 35.0),
                  child: Text(
                    'Failed to Retrieve Groups',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
          //),
        );
      },
    );
  }
}
