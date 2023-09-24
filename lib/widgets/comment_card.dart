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
  const CommentPageCard({
    super.key,
    required this.event,
    required this.joined,
    this.onSubscribe,
  });

  @override
  ConsumerState<CommentPageCard> createState() => _CommentPageCardState();
}

class _CommentPageCardState extends ConsumerState<CommentPageCard> {
  @override
  Widget build(BuildContext context) {

    bool? isChecked = false;
    return Container(
      decoration: ProjectConstants.appBoxDecoration.copyWith(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Image.asset(
                    ProjectConstants.profileImage,
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.02,
                  ),
                  Text(
                    widget.event.title,
                    style: mediumTextStyle,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.25,
                  ),
                  Container(
                    decoration: ProjectConstants.appBoxDecoration.copyWith(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        DateFormatter.formatDateDayAndMonth(
                            widget.event.startDate),
                        style: normalTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  SvgPicture.asset(ProjectConstants.locationIcon),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.02,
                  ),
                  Text(
                    widget.event.location,
                    style: greyTextStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  SvgPicture.asset(ProjectConstants.clockIcon),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.02,
                  ),
                  Text(
                    '${widget.event.startTime} - ${widget.event.endTime}',
                    style: greyTextStyle,
                  ),
                ],
              ),
              // Row(
              //   children: [
              //     Checkbox(
              //         value: isChecked,
              //         onChanged: (value) {
              //           setState(() {
              //             isChecked = value;
              //           });
              //         }),
              //     const Text('Check box to invite to Techies'),
              //   ],
              // ),
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
                    child: const Center(
                      child: Text(
                        'I will join',
                        style: TextStyle(
                          //fontFamily: 'NotoSans',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: ProjectColors.black,
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
