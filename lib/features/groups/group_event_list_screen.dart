import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/features/groups/group_members.dart';
import 'package:hng_events_app/models/group.dart';
import 'package:hng_events_app/riverpod/event_provider.dart';
import 'package:hng_events_app/riverpod/group_provider.dart';
import 'package:hng_events_app/riverpod/user_provider.dart';
import 'package:hng_events_app/features/events/create_event/create_event_screen.dart';
import 'package:hng_events_app/util/snackbar_util.dart';

import 'package:hng_events_app/widgets/event_list_card.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class GroupEventsScreen extends ConsumerStatefulWidget {
  const GroupEventsScreen({
    super.key,
    required this.group,
  });
  final Group group;

  @override
  ConsumerState<GroupEventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<GroupEventsScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getGroupEvents();
    });

    super.initState();
  }

  bool isLoading = false;

  Future getGroupEvents() async {
    final groupRef = ref.read(GroupProvider.groupProvider.notifier);

    groupRef.setIsFetchingGroupEvent(true);

    await ref
        .read(EventProvider.provider.notifier)
        .getAllGroupEvent(widget.group.id);

    groupRef.setIsFetchingGroupEvent(false);
  }

  @override
  Widget build(BuildContext context) {
    final eventNotifier = ref.watch(EventProvider.provider);
    final groupRef = ref.read(GroupProvider.groupProvider.notifier);
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
          widget.group.name,
          style: TextStyle(
              // fontSize: 24,
              // fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onBackground),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GroupMembersPage()));
              },
              child: Row(
                children: [
                  const Icon(Icons.person),
                  Text(
                    "${widget.group.membersCount}",
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final eventNotifier = ref.watch(EventProvider.provider);
              final userRef = ref.watch(appUserProvider);
              final members = eventNotifier.allGroupEvents?.data.members ?? [];
              // Check if userRef exists in members
              bool isUserInMembers =
                  members.any((element) => element == userRef);

              return isUserInMembers
                  ? TextButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        final result = await ref
                            .read(GroupProvider.groupProvider)
                            .unSubscribeFromGroup(widget.group.id);
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.pop(context);
                        if (result) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Succesfful'),
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                                ref.read(GroupProvider.groupProvider).error),
                          ));
                        }
                      },
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Leave',
                              style: TextStyle(fontSize: 16),
                            ),
                    )
                  : TextButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        final result = await ref
                            .read(GroupProvider.groupProvider)
                            .subscribeToGroup(widget.group.id);
                        setState(() {
                          isLoading = false;
                        });
                        if (result) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Group Joined'),
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                                ref.read(GroupProvider.groupProvider).error),
                          ));
                        }
                      },
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Join',
                              style: TextStyle(fontSize: 16),
                            ),
                    );
            },
          )
        ],
      ),
      body: ref.read(GroupProvider.groupProvider).isFetchingGroupEvent
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    // flex: 6,
                    child: SizedBox(
                      height: 400,
                      child: (eventNotifier.allGroupEvents?.data.events ?? [])
                              .isEmpty
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('No Event yet'),
                              ],
                            )
                          : ListView.builder(
                              itemCount: eventNotifier
                                  .allGroupEvents!.data.events.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => EventsCard(
                                isSubscribing: ref
                                        .read(GroupProvider.groupProvider)
                                        .isSubscribingToGroupEvent &&
                                    ref
                                            .read(GroupProvider.groupProvider)
                                            .currentlyClickedEvent ==
                                        eventNotifier.allGroupEvents!.data
                                            .events[index].id,
                                onSubscribe: () async {
                                  groupRef.setIsSubscribingToGroupEvent(true);
                                  groupRef.setCurrentlyClickedEvent(
                                      eventNotifier.allGroupEvents!.data
                                          .events[index].id);
                                  final result = await eventNotifier
                                      .subscribeToEvent(eventNotifier
                                          .allGroupEvents!
                                          .data
                                          .events[index]
                                          .id);

                                  if (result) {
                                    showSnackBar(
                                        context, 'Subcribed', Colors.green);
                                  } else {
                                    showSnackBar(context, 'Failed to subscribe',
                                        Colors.red);
                                  }
                                  groupRef.setIsSubscribingToGroupEvent(false);
                                },
                                onUnSubscribe: () async {
                                  groupRef.setIsSubscribingToGroupEvent(true);
                                  groupRef.setCurrentlyClickedEvent(
                                      eventNotifier.allGroupEvents!.data
                                          .events[index].id);
                                  final result = await eventNotifier
                                      .unSubscribeFromEvent(eventNotifier
                                          .allGroupEvents!
                                          .data
                                          .events[index]
                                          .id);
                                  if (result) {
                                    showSnackBar(
                                        context, 'Unsubscribed', Colors.green);
                                  } else {
                                    showSnackBar(context,
                                        'Fail to unsubscribed', Colors.red);
                                  }
                                  groupRef.setIsSubscribingToGroupEvent(false);
                                },
                                event: eventNotifier
                                    .allGroupEvents!.data.events[index],
                                firstComments: eventNotifier.allGroupEvents
                                    ?.data.events[index].firstComments,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: NeuIconButton(
        icon: const Icon(Icons.add),
        borderRadius: BorderRadius.circular(50),
        buttonColor: ProjectColors.purple,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateEvents(
              currentGroup: widget.group,
            ),
          ),
        ),
      ),
    );
  }
}
