import 'package:flutter/material.dart';

// final  kAppBoxDecoration = BoxDecoration(
//                   border: Border.all(),
//                   borderRadius: BorderRadius.circular(10));

// const kSizedBox = SizedBox(height: 24,);

// const kBodyPadding = EdgeInsets.all(24.0);

class ProjectConstants {
  static  BoxDecoration appBoxDecoration = BoxDecoration(
    //color: Colors.white,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10));
  static const SizedBox sizedBox = SizedBox(height: 24,);
  static const SizedBox smallHorizontalSpace = SizedBox(width: 10,);
   static const SizedBox largeHorizontalSpace = SizedBox(width: 80,);
  static const EdgeInsets bodyPadding = EdgeInsets.all(24.0); 

  static const String profileImage = 'assets/illustrations/smiley_face.png'; 
  static const String profilePicture = 'assets/images/img1.png'; 
static const String chatPicture = 'assets/images/img5.png'; 
static const String chatPicture2 = 'assets/images/img6.png'; 

static const String notificationsIcon = 'assets/icons/Frame.svg';
static const String helpIcon = 'assets/icons/Vectorhelper_Icon.svg';
static const String privacyIcon = 'assets/icons/mdi_security-account.svg';
static const String appearanceIcon = 'assets/icons/pajamas_appearance.svg';
static const String languageIcon = 'assets/icons/material-symbols_language.svg';
static const String aboutIcon = 'assets/icons/mdi_about-circle-outline.svg';
static const String logoutIcon = 'assets/icons/logout.svg';
static const String rightChevron = 'assets/icons/forwardCaret.svg';
static const String locationIcon = 'assets/icons/Framelocation.svg';
static const String clockIcon = 'assets/icons/Frameclock.svg';
static const String imagePicker = 'assets/icons/FrameimageSelector.svg';
static const String microphone = 'assets/icons/Framemicrophone.svg';



}