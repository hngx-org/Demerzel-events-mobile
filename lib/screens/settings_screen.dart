import 'package:flutter/material.dart';
import 'package:hng_events_app/constants/constants.dart';
import 'package:hng_events_app/constants/styles.dart';
import 'package:svg_flutter/svg.dart';

import '../constants/colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.bgColor,
      appBar: AppBar(
        centerTitle: false,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              height: 1,
              color: Colors.black,
            )),
        title: const Text('Settings'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Padding(
        padding: ProjectConstants.bodyPadding,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                
              },
              child: Container(
                height: 72,
                decoration: ProjectConstants.appBoxDecoration,
                child: ListTile(
                  tileColor: Colors.white,
                  leading: CircleAvatar(
                      child: Image.asset(ProjectConstants.profileImage)),
                  // TODO: change this to name of current user
                  title: const Text(
                    'Salome',
                    style: largeTextStyle,
                  ),
                  subtitle: Text(
                    'salome357@gmail.com',
                    style: greyTextStyle.copyWith(
                        fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  trailing: SvgPicture.asset(ProjectConstants.rightChevron),
                ),
              ),
            ),
            ProjectConstants.sizedBox,
            Container(
              decoration: ProjectConstants.appBoxDecoration,
              child: Column(
                children: [
                  SettingItem(
                    title: 'Notificatons',
                    leading: ProjectConstants.notificationsIcon,
                    onPressed: () {},
                  ),
                  SettingItem(
                    title: 'Privacy',
                    leading: ProjectConstants.privacyIcon,
                    onPressed: () {},
                  ),
                  SettingItem(
                    title: 'Appearance',
                    leading: ProjectConstants.appearanceIcon,
                    onPressed: () {},
                  ),
                  SettingItem(
                    title: 'Language and Region',
                    leading: ProjectConstants.languageIcon,
                    shape: const Border(),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            ProjectConstants.sizedBox,
            Container(
              decoration: ProjectConstants.appBoxDecoration,
              child: Column(
                children: [
                  SettingItem(
                    title: 'Help and Support',
                    leading: ProjectConstants.helpIcon,
                    onPressed: () {},
                  ),
                  SettingItem(
                    title: 'About',
                    leading: ProjectConstants.aboutIcon,
                    shape: const Border(),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            ProjectConstants.sizedBox,
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  SvgPicture.asset(ProjectConstants.logoutIcon),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Logout',
                    style:
                        mediumTextStyle.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
             
          ],
        ),
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final String title;
  final String leading;
  final Border shape;
  final VoidCallback onPressed;
  const SettingItem({
    super.key,
    required this.title,
    required this.leading,
    this.shape = const Border(
      bottom: BorderSide(color: ProjectColors.lightBoxBorderColor, width: 0.5),
    ),
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile( 
        tileColor: Colors.white,
        leading: SvgPicture.asset(leading),
        title: Text(
          title,
          style: settingsItemTextStyle,
        ),
        trailing: SvgPicture.asset(ProjectConstants.rightChevron),
        shape: shape,
        onTap: onPressed,
      ),
    );
  }
}
