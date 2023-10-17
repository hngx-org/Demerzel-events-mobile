// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/event_model.dart';
import 'package:hng_events_app/riverpod/event_provider.dart';
import 'package:hng_events_app/util/snackbar_util.dart';

class EditEventName extends ConsumerStatefulWidget {
  final Event currentEvent;

  const EditEventName({
    Key? key,
    required this.currentEvent,
  }) : super(key: key);

  @override
  _EditEventNameState createState() => _EditEventNameState();
}

class _EditEventNameState extends ConsumerState<EditEventName> {
  final TextEditingController _eventNameController = TextEditingController();
  TextEditingController? _eventLocationController;
  TextEditingController? _eventDescriptionController;
  @override
  void initState() {
    super.initState();
    _eventNameController.text = widget.currentEvent.title;
    _eventLocationController =
        TextEditingController(text: widget.currentEvent.location);
    _eventDescriptionController =
        TextEditingController(text: widget.currentEvent.description);
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = ref.watch(EventProvider.provider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Events details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextFormField(
            //   controller: _eventNameController,
            //   decoration: const InputDecoration(labelText: 'New EventName'),
            // ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _eventLocationController,
              //initialValue: widget.currentEvent.location,
              decoration: const InputDecoration(labelText: 'New Location'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              //initialValue: widget.currentEvent.description,
              controller: _eventDescriptionController,
              decoration: const InputDecoration(labelText: 'New Description'),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final newEventName = _eventNameController.text;
                  final newEventLocation = _eventLocationController!.text;
                  final newEventDescription = _eventDescriptionController!.text;
                  final result = await eventProvider.editEvent(
                      newEventName: newEventName,
                      newEventLocation: newEventLocation,
                      newEventDescription: newEventDescription,
                      eventID: widget.currentEvent.id);
                  if (result) {
                    Navigator.pop(context);
                    showSnackBar(
                        context, 'Event details updated', Colors.green);
                    ref.refresh(allEventsProvider);
                    ref.refresh(userEventsProvider);
                    ref.refresh(upcomingEventsProvider);
                  } else {
                    showSnackBar(context, eventProvider.error, Colors.red);
                  }
                },
                child: ref.watch(EventProvider.provider).isBusyEditingEvent
                    ? const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Saving '),
                          CircularProgressIndicator(),
                        ],
                      )
                    : const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
