import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/models/group.dart';
import 'package:hng_events_app/riverpod/event_provider.dart';
import 'package:hng_events_app/screens/create_event_screen.dart';
import 'package:hng_events_app/widgets/event_list_card.dart';
import 'package:hng_events_app/widgets/app_header.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen( {
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
      ref.read(EventProvider.provider.notifier).getAllGroupEvent(widget.group.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final eventNotifier = ref.watch(EventProvider.provider);
    return Scaffold(
      // backgroundColor: ProjectColors.bgColor,
      appBar: AppHeader(title: widget.group.name),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   margin: const EdgeInsets.all(20),
            //   width: 60,
            //   height: 30,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(5),
            //       border: Border.all(),
            //       color: ProjectColors.purple),
            //   child: const Center(
            //     child: Text(
            //       "Today",
            //     ),
            //   ),
            // ),
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
                        itemCount:
                            widget.group.events.length ,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => EventsCard(
                          event:
                              widget.group.events[index],
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