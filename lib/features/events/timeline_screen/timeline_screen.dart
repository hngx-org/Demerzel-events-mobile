import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/event_model.dart';
import 'package:hng_events_app/riverpod/event_provider.dart';
import 'package:hng_events_app/riverpod/group_provider.dart';
import 'package:hng_events_app/riverpod/notifications_provider.dart';
import 'package:hng_events_app/features/events/timeline_screen/my_events_screen.dart';
import 'package:hng_events_app/features/events/timeline_screen/all_event_screen.dart';
import 'package:hng_events_app/features/events/search_event.dart';
import 'package:hng_events_app/features/events/timeline_screen/upcoming_screen.dart';

class TimelineScreen extends ConsumerStatefulWidget {
  const TimelineScreen({super.key});

  @override
  ConsumerState<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends ConsumerState<TimelineScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.read(notificationProvider.notifier).getNotifications.call();

    List<Event> events = ref.watch(eventSearchProvider);
    
    ref.read(NotificationSettingsPrefsNotifier.provider);
    ref.watch(groupTagProvider);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 35,
                child: GestureDetector(
                  onTap: ()=> showSearch(
                      context: context, 
                      delegate: EventSearchDelegate(events: events)
                    ),
                  child: const TextField(
                    enabled: false,
                    expands: false,
                    decoration: InputDecoration(
                      label: Text('Search'),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey
                        )
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              const Tab(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Upcoming",
                    style: TextStyle(
                    ),
                  ),
                ),
              ),
              Tab(
                key: UniqueKey(),
                child: const Text(
                  "My Events",
                  style: TextStyle(
                  ),
                ),
              ),
              Tab(
                key: UniqueKey(),
                child: const Text(
                  "All Events",
                  style: TextStyle(
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
             UpcomingEventScreen(),
            MyEventScreen(
              key: UniqueKey(),
            ),
            AllEventsScreen(
              key: UniqueKey(),
            ),
          ],
        ),
      ),
    );
  }
}
