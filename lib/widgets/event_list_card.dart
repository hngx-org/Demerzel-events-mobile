import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/models/event_model.dart';
import 'package:hng_events_app/riverpod/event_provider.dart';
import 'package:hng_events_app/screens/comment_screen.dart';
import 'package:hng_events_app/util/date_formatter.dart';
import 'package:icon_decoration/icon_decoration.dart';

class EventsCard extends ConsumerWidget {
  const EventsCard({super.key, required this.event});

  final Event event;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventNotifier = ref.watch(EventProvider.provider);
    return SafeArea(
      child: Material(
        child: Container(
          margin: const EdgeInsets.all(20),
          width: double.infinity,
          //height: 245,
          decoration: BoxDecoration(
            border: Border.all(
              color: ProjectColors.black,
              width: 2,
            ),
            color: ProjectColors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: const <BoxShadow>[
              BoxShadow(color: ProjectColors.black, offset: Offset(2, 2))
            ],
          ),
          child: Column(
            children: [
              //football game listile
              ListTile(
                leading: event.thumbnail.isEmpty
                    ? const CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/illustrations/smiley_face.png"),
                        radius: 15,
                      )
                    : CircleAvatar(
                        backgroundImage:
                            NetworkImage(event.thumbnail),
                        radius: 15,
                      ),
                title: Text(
                  event.title,
                  style: const TextStyle(
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w800,
                      fontSize: 24),
                ),
                trailing: Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                    color: ProjectColors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: ProjectColors.black),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                          color: ProjectColors.black, offset: Offset(2, 2))
                    ],
                  ),
                  child: Center(
                    child: Text(
                      DateFormatter.formatDateDayAndMonth(event.startDate),
                      style: const TextStyle(
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              //location
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(children: [
                  const DecoratedIcon(
                    icon: Icon(Icons.location_pin, color: ProjectColors.white),
                    decoration: IconDecoration(
                      border: IconBorder(width: 1, color: ProjectColors.black),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    event.location,
                    style: const TextStyle(
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  )
                ]),
              ),
              const SizedBox(
                height: 5,
              ),
              //time
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(children: [
                  const DecoratedIcon(
                    icon: Icon(Icons.timer, color: ProjectColors.white),
                    decoration: IconDecoration(
                        border:
                            IconBorder(width: 1, color: ProjectColors.black)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${event.startTime} - ${event.endTime}',
                    style: const TextStyle(
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ]),
              ),
              const SizedBox(
                height: 8,
              ),
              //button widget
              Visibility(
                visible: eventNotifier.userEvents
                    .any((element) => element.id == event.id),
                replacement: JoinButton(
                  onPressed: () => eventNotifier.subscribeToEvent(event.id),
                ),
                child: const Text('Already Subscribed 👍🏼'),
              ),
              const SizedBox(
                height: 16,
              ),
              const Divider(height: 0, thickness: 2, color: ProjectColors.grey),

              //inpuField widget
              InputField(
                event: event,
              )
            ],
          ),
        ),
      ),
    );
  }
}

//button widget add gesture detector to add functionality
class JoinButton extends StatelessWidget {
  const JoinButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ProjectColors.white,
          border: Border.all(
            color: ProjectColors.black,
            width: 2,
          ),
          boxShadow: const <BoxShadow>[
            BoxShadow(color: ProjectColors.black, offset: Offset(2, 2))
          ],
        ),
        child: const Center(
          child: Text(
            'I will join',
            style: TextStyle(
                fontFamily: 'NotoSans',
                fontWeight: FontWeight.w700,
                fontSize: 18),
          ),
        ),
      ),
    );
  }
}

//inutfield widget
class InputField extends StatefulWidget {
  final Event event;
  const InputField({super.key, required this.event});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: ListTile(
          leading: const Icon(Icons.comment),
          onTap: () =>  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommentScreen(
                      event: widget.event,
                    ),
                  ),
                ),
          title: SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: const Text('Leave a comment')
          ),
          trailing: const Icon(Icons.chevron_right)),
    );
  }
}
