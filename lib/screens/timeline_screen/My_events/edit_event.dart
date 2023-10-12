import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/event_model.dart';
import 'package:hng_events_app/riverpod/event_provider.dart';


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

  @override
  void initState() {
    super.initState();
    _eventNameController.text = widget.currentEvent.title;
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = ref.read(EventProvider.provider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Event Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _eventNameController,
              decoration: const InputDecoration(labelText: 'New EventName'),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final newEventName = _eventNameController.text;
                  await eventProvider.updateEventName(
                      newEventName: newEventName,
                      eventID: widget.currentEvent.id);
                  Navigator.pop(context);
                },
                child: ref.watch(EventProvider.provider).isBusyEditingEvent? const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Saving '),
                    CircularProgressIndicator(),
                  ],
                ): const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
