import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/constants/constants.dart';
import 'package:hng_events_app/models/event_model.dart';
import 'package:hng_events_app/riverpod/event_provider.dart';
import 'package:hng_events_app/features/groups/comment_screen.dart';
import 'package:hng_events_app/util/date_formatter.dart';
import 'package:hng_events_app/widgets/comment_stack.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';
import 'package:svg_flutter/svg.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventsCard extends ConsumerWidget {
  const EventsCard({
    super.key,
    required this.event,
    this.firstComments,
    this.isSubscribing = false,
    required this.onSubscribe,
    required this.onUnSubscribe,
  });

  final Event? event;
  final List? firstComments;
  final bool isSubscribing;

  final Function() onSubscribe;
  final Function() onUnSubscribe;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventNotifier = ref.watch(EventProvider.provider);
    return SafeArea(
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: NeuContainer(
            shadowColor: Theme.of(context).colorScheme.onBackground,
            borderColor: Theme.of(context).colorScheme.onBackground,
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
                          backgroundImage: AssetImage(
                              "assets/illustrations/smiley_face.png"),
                          radius: 15,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(event!.thumbnail),
                          radius: 15,
                        ),
                  title: Text(
                    event!.title,
                    style:  TextStyle(
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w800,
                        fontSize: 16.sp),
                  ),
                  trailing: Container(
                    width: 60.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      // color: Theme.of(context).colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Theme.of(context).colorScheme.onPrimary,
                            offset: const Offset(2, 2))
                      ],
                    ),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          DateFormatter.formatDateDayAndMonth(event!.startDate),
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        ProjectConstants.locationIcon,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.02,
                      ),
                      Text(
                        event!.location,
                        style: const TextStyle(
                          fontFamily: 'inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                 SizedBox(
                  height: 5.h,
                ),
                //time
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        ProjectConstants.clockIcon,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.02,
                      ),
                      Text(
                        '${event!.startTime} - ${event!.endTime}',
                        style: const TextStyle(
                          fontFamily: 'inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                //button widget
(DateFormatter.timeLeft(event!.startDate, event!.endTime) == 'Expired')?
               Text('Event Expired')
               : Visibility(
                  visible: eventNotifier.userEvents
                      .any((element) => element.id == event!.id),
                  replacement: JoinButton(
                    title: 'Suscribe To Event',
                    isBusy: isSubscribing,
                    onPressed: onSubscribe,
                  ),
                  child: JoinButton(
                      title: 'Unsusbcribe From Event',
                      isBusy: isSubscribing,
                      onPressed: onUnSubscribe),
                  //const Text('Already Subscribed 👍🏼'),
                ),
                 SizedBox(
                  height: 16.h,
                ),
                const Divider(
                    height: 0, thickness: 2, color: ProjectColors.grey),
                const SizedBox(
                  height: 2,
                ),
                //inpuField widget
                InputField(
                  event: event!,
                  firstComments: firstComments!,
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
  const JoinButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.isBusy = false});
  final VoidCallback onPressed;
  final String title;
  final bool isBusy;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
        final width = MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width * 0.6,
        height: height * 0.065,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).colorScheme.primary,
          border: Border.all(
            color: Theme.of(context).colorScheme.onBackground,
            width: 2,
          ),
          boxShadow: const <BoxShadow>[
            BoxShadow(color: ProjectColors.black, offset: Offset(2, 2))
          ],
        ),
        child: Center(
          child: isBusy
              ?  SizedBox(
                  width: 30.w,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(
                textScaleFactor: 1.0,
                  title,
                  style:  TextStyle(
                      fontFamily: 'NotoSans',
                      
                      // fontWeight: FontWeight.w600,
                      fontSize: 16.sp),
                ),
        ),
      ),
    );
  }
}

//inutfield widget
class InputField extends ConsumerStatefulWidget {
  final Event event;
  final List? firstComments;

  const InputField({
    super.key,
    required this.event,
    this.firstComments,
  });

  @override
  ConsumerState<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends ConsumerState<InputField> {
  @override
  Widget build(BuildContext context) {
    //   final commentNotifier = ref.watch(CommentProvider.provider);
    // print(commentNotifier.comments.length);
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommentScreen(
            event: widget.event,
          ),
        ),
      ),
      child: SizedBox(
        height: 40,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: widget.firstComments!.isEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/chat.svg',
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      const Text('Leave a comment'),
                      SvgPicture.asset(
                        ProjectConstants.rightChevron,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ],
                  )
                : InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentScreen(
                          event: widget.event,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      height: 40.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.6,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommentStack(
                                  numberOfAvatars: widget.firstComments!.length,
                                  firstComments: widget.firstComments,
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                      '  ${widget.firstComments!.length} ${(widget.firstComments!.length > 1 ? 'comments' : 'comment')}'),
                                ),
                              ],
                            ),
                          ),
                          SvgPicture.asset(
                            ProjectConstants.rightChevron,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ],
                      ),
                    ),
                  )),
      ),
    );
  }
}
