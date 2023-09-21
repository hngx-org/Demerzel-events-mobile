import 'package:flutter/material.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/constants/constants.dart';
import 'package:hng_events_app/constants/styles.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';
import 'package:svg_flutter/svg.dart';

class CommentPageCard extends StatefulWidget {
  final String eventTitle, dateAndTime, location, day;
  const CommentPageCard({
    super.key,
    required this.eventTitle,
    required this.dateAndTime,
    required this.location,
    required this.day,
  });

  @override
  State<CommentPageCard> createState() => _CommentPageCardState();
}

class _CommentPageCardState extends State<CommentPageCard> {
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
                  SizedBox(width: MediaQuery.sizeOf(context).width * 0.02,),
                  Text(
                    widget.eventTitle,
                    style: mediumTextStyle,
                  ),
                  SizedBox(width: MediaQuery.sizeOf(context).width * 0.25,),
                  Container(
                    decoration: ProjectConstants.appBoxDecoration.copyWith(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        widget.day,
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
                  SizedBox(width: MediaQuery.sizeOf(context).width * 0.02,),
                  Text(
                    widget.location,
                    style: greyTextStyle,
                  ),
                ],
              ),const SizedBox(
                height: 5,
              ),

              Row(
                children: [
                  SvgPicture.asset(ProjectConstants.clockIcon),
                  SizedBox(width: MediaQuery.sizeOf(context).width * 0.02,),
                  Text(
                    widget.dateAndTime,
                    style: greyTextStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value;
                        });
                      }),
                  const Text('Check box to invite to Techies'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: NeuTextButton(
                  onPressed: () {},
                  buttonColor: ProjectColors.purple,
                  buttonHeight: 40,
                  borderRadius: BorderRadius.circular(5),
                  // style: ElevatedButton.styleFrom(
                  //     backgroundColor: ProjectColors.purple,
                  //     elevation: 5,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(5)),
                  //     padding: const EdgeInsets.symmetric(vertical: 9)),
                  child: const Center(
                    child: Text(
                      'Share',
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
            ]),
      ),
    );
  }
}