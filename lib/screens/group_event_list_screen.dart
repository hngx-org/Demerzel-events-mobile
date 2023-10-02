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
    getGroupEvents();
 
    });
     
    super.initState();
  }



  Future getGroupEvents() async => await ref
          .read(EventProvider.provider.notifier)
          .getAllGroupEvent(widget.group.id);

  @override
  Widget build(BuildContext context) {
     final eventNotifier = ref.watch(EventProvider.provider);
    return Scaffold(
      //backgroundColor: ProjectColors.bgColor,
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
           Row(
            children: [
              const Icon(Icons.person),
              
              Text(
                "${widget.group.membersCount}",
                style: const TextStyle(fontSize: 16),
              )
            ],
          ),
          TextButton(onPressed: ()=> ref.read(GroupProvider.groupProvider).subscribeToGroup(widget.group.id) , child: const Text('Join', style: TextStyle(fontSize: 16),)),
        ],
      ),
      body: 
     eventNotifier.isBusy ? const Center(child: CircularProgressIndicator(),)
     :
      Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              // flex: 6,
              child: SizedBox(
                height: 400,
                child: (eventNotifier.allGroupEvents!.data.events).isEmpty
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('No Event yet'),
                        ],
                      )
                    : ListView.builder(
                        itemCount: eventNotifier.allGroupEvents!.data.events.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => EventsCard(
                          event: eventNotifier.allGroupEvents!.data.events[index],
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
