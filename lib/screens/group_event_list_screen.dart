import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/models/group.dart';
import 'package:hng_events_app/riverpod/event_provider.dart';
import 'package:hng_events_app/riverpod/group_provider.dart';
import 'package:hng_events_app/screens/create_event_screen.dart';
import 'package:hng_events_app/widgets/event_list_card.dart';
import 'package:hng_events_app/widgets/app_header.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({
    super.key,
    required this.group,
  });
  final Group group;

  @override
  ConsumerState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref
          .read(EventProvider.provider.notifier)
          .getAllGroupEvent(widget.group.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final eventNotifier = ref.watch(EventProvider.provider);
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
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onBackground),
        ),
        actions: [
          const Row(
            children: [
              Icon(Icons.person),
              //TODO change from hardcoded data
              Text(
                '12',
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
          TextButton(onPressed: ()=> ref.read(GroupProvider.groupProvider).subscribeToGroup(widget.group.id) , child: const Text('Join', style: TextStyle(fontSize: 16),)),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              // flex: 6,
              child: SizedBox(
                height: 400,
                child: (widget.group.events).isEmpty
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('No Event yet'),
                        ],
                      )
                    : ListView.builder(
                        itemCount: widget.group.events.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => EventsCard(
                          event: widget.group.events[index],
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
            builder: (context) => const CreateEvents(),
          ),
        ),
      ),
    );
  }
}
