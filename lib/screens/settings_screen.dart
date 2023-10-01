

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/constants.dart';
import 'package:hng_events_app/constants/styles.dart';
import 'package:hng_events_app/repositories/auth_repository.dart';
import 'package:hng_events_app/riverpod/user_provider.dart';

import 'package:svg_flutter/svg.dart';

import '../constants/colors.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRef = ref.watch(UserProvider.notifier);
      final authRef = ref.read(AuthRepository.provider);
    return Scaffold(
      backgroundColor: ProjectColors.bgColor,
      appBar: AppBar(
        backgroundColor: ProjectColors.white,
        centerTitle: false,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              height: 1,
              color: Colors.black,
            )),
        title: const Text(
          'Settings',
          style: appBarTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: ProjectColors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: ProjectConstants.bodyPadding,
        child: Column(
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                height: 72,
                decoration: ProjectConstants.appBoxDecoration,
                child: Consumer(
                  builder: (context, ref, child) {
                    return ListTile(
                      tileColor: Colors.white,
                      leading: CircleAvatar(
                          child: Image.asset(ProjectConstants.profileImage)),
                      title: Text(
                       userRef.user?.displayName?? 'salome',
                        style: largeTextStyle,
                      ),
                      subtitle: Text(
                         userRef.user?.email ?? 'salome357@gmail.com',
                        style: greyTextStyle.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      trailing: SvgPicture.asset(ProjectConstants.rightChevron),
                    );
                  }
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
              onTap:authRef.signOut,
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
