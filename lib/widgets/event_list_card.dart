import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/constants/constants.dart';
import 'package:hng_events_app/models/event_model.dart';
import 'package:hng_events_app/riverpod/comment_provider.dart';
import 'package:hng_events_app/riverpod/event_provider.dart';
import 'package:hng_events_app/screens/comment_screen.dart';
import 'package:hng_events_app/util/date_formatter.dart';
import 'package:hng_events_app/widgets/comment_stack.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';
import 'package:svg_flutter/svg.dart';

class EventsCard extends ConsumerWidget {
  const EventsCard({super.key, required this.event});

  final Event? event;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventNotifier = ref.watch(EventProvider.provider);
    return SafeArea(
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: NeuContainer(
            shadowColor: Theme.of(context).colorScheme.onBackground,
            borderColor:  Theme.of(context).colorScheme.onBackground,
            color: Theme.of(context).cardColor,
            width: double.infinity,
            borderRadius: BorderRadius.circular(10),
            borderWidth: 1.0,
            child: Column(
              children: [
                //football game listile
                ListTile(
                  leading: event!.thumbnail.isEmpty
                      ? const CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/illustrations/smiley_face.png"),
                          radius: 15,
                        )
                      : CircleAvatar(
                          backgroundImage:
                              NetworkImage(event!.thumbnail),
                          radius: 15,
                        ),
                  title: Text(
                    event!.title,
                    style: const TextStyle(
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w800,
                        fontSize: 24),
                  ),
                  trailing: Container(
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                     // color: Theme.of(context).colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Theme.of(context).colorScheme.onBackground,),
                      boxShadow:  <BoxShadow>[
                        BoxShadow(
                            color: Theme.of(context).colorScheme.onPrimary, offset: Offset(2, 2))
                      ],
                    ),
                    child: Center(
                      child: Text(
                        DateFormatter.formatDateDayAndMonth(event!.startDate),
                        style:  TextStyle(
                          fontFamily: 'inter',
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                  children: [
                    SvgPicture.asset(ProjectConstants.locationIcon, color: Theme.of(context).colorScheme.onBackground,),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.02,
                    ),
                    Text(
                      event!.location,
                     style: const TextStyle(
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w600,),
                    ),
                  ],
                              ),
                ),
                const SizedBox(
                  height: 5,
                ),
                //time
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: 
                  Row(
                children: [
                  SvgPicture.asset(ProjectConstants.clockIcon,color: Theme.of(context).colorScheme.onBackground,),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.02,
                  ),
                  Text(
                    '${event!.startTime} - ${event!.endTime}',
                    style: const TextStyle(
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w600,),
                  ),
                ],
              ),
  
                ),
                const SizedBox(
                  height: 8,
                ),
                //button widget
                Visibility(
                  visible: eventNotifier.userEvents
                      .any((element) => element.id == event!.id),
                  replacement: JoinButton(
                    onPressed: () => eventNotifier.subscribeToEvent(event!.id),
                  ),
                  child: const Text('Already Subscribed 👍🏼'),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Divider(height: 0, thickness: 2, color: ProjectColors.grey),
                    
                //inpuField widget
                InputField(
                  event: event!,
                )
              ],
            ),
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
          color: Theme.of(context).colorScheme.onPrimary,
          border: Border.all(
            color: Theme.of(context).colorScheme.onBackground,
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
class InputField extends ConsumerStatefulWidget {
  final Event event;
  const InputField({super.key, required this.event});

  @override
  ConsumerState<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends ConsumerState<InputField> {
  @override
   void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref
          .read(CommentProvider.provider.notifier)
          .getEventComments(widget.event.id);
    });
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  //   final commentNotifier = ref.watch(CommentProvider.provider);
  // print(commentNotifier.comments.length);
    return InkWell(
         onTap: () =>  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentScreen(
                          event: widget.event,
                        ),
                      ),
                    ),
      child: SizedBox(height: 40,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child:ref.read(CommentProvider.provider).comments.isEmpty? 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            SvgPicture.asset('assets/icons/chat.svg',color: Theme.of(context).colorScheme.onBackground,),
             const Text('Leave a comment'),
             SvgPicture.asset(ProjectConstants.rightChevron,color: Theme.of(context).colorScheme.onBackground,),
      
          ],):
          InkWell(
             onTap: () =>  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentScreen(
                          event: widget.event,
                        ),
                      ),
                    ),
            child: SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                     const CommentStack(numberOfAvatars: 3),
                        Text('${ref.read(CommentProvider.provider).comments.length} comments'),
                      
                      
                    ],),
                  ),
                   SvgPicture.asset(ProjectConstants.rightChevron),
                ],
              ),
            ),
          )
          
        ),
      ),
    );
  }
}
