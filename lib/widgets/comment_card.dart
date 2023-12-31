import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/constants/constants.dart';
import 'package:hng_events_app/constants/styles.dart';
import 'package:hng_events_app/models/event_model.dart';
import 'package:hng_events_app/util/date_formatter.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';
import 'package:svg_flutter/svg.dart';

class CommentPageCard extends ConsumerStatefulWidget {
  final Event event;
  final bool joined;
  final void Function()? onSubscribe;
  final bool isSubscribing;
  const CommentPageCard({
    super.key,
    required this.event,
    required this.joined,
    this.onSubscribe,
    required this.isSubscribing,
  });

  @override
  ConsumerState<CommentPageCard> createState() => _CommentPageCardState();
}

class _CommentPageCardState extends ConsumerState<CommentPageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ProjectConstants.appBoxDecoration.copyWith(
          border:
              Border.all(color: Theme.of(context).colorScheme.onBackground)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                leading: widget.event.thumbnail.isEmpty
                    ? const CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/illustrations/smiley_face.png"),
                        radius: 15,
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(widget.event.thumbnail),
                        radius: 15,
                      ),
                title: Text(
                  widget.event.title,
                  style: mediumTextStyle,
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                    // color: Theme.of(context).colorScheme.onBackground,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      DateFormatter.formatDateDayAndMonth(
                          widget.event.startDate),
                      style: normalTextStyle,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      widget.event.location,
                      style: greyTextStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      '${widget.event.startTime} - ${widget.event.endTime}',
                      style: greyTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Visibility(
                  visible: widget.joined,
                  replacement: const Center(child: Text('Already Joined 👍🏼')),
                  child: NeuTextButton(
                    onPressed: widget.onSubscribe,
                    buttonColor: ProjectColors.purple,
                    buttonHeight: 40,
                    borderRadius: BorderRadius.circular(5),
                    child: Center(
                      child: widget.isSubscribing
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SizedBox(
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )),
                            )
                          : Text(
                              'I will join',
                              style: TextStyle(
                                //fontFamily: 'NotoSans',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
