import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/constants.dart';
import 'package:hng_events_app/constants/styles.dart';
import 'package:hng_events_app/models/notification.dart';
import 'package:hng_events_app/riverpod/notifications_provider.dart';
import 'package:hng_events_app/riverpod/user_provider.dart';
import 'package:hng_events_app/features/settings/about/about_us.dart';
import 'package:hng_events_app/features/settings/profile/edit_profile_screen.dart';
import 'package:hng_events_app/features/notifications/notification_list_screen.dart';
import 'package:hng_events_app/features/settings/notifications_settings/notificaton_settings.dart';
import 'package:hng_events_app/features/settings/theme_settings/theme_screen.dart';
import 'package:badges/badges.dart' as badges;
import 'package:svg_flutter/svg.dart';

import '../../../constants/colors.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.read(notificationProvider.notifier).getNotifications();
    ref.watch(NotificationSettingsPrefsNotifier.provider);
    final userRef = ref.watch(appUserProvider);
    List<UserNotification> unreadNotifications =
        ref.watch(notificationProvider).unreadNotifications;

    return Scaffold(
      // backgroundColor: ProjectColors.bgColor,
      appBar: AppBar(
        // backgroundColor: ProjectColors.white,
        centerTitle: false,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              height: 1,
              color: Colors.black,
            )),
        title: Text(
          'Settings',
          style: appBarTextStyle.copyWith(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NotificationListScreen()));
              },
              child: badges.Badge(
                position: badges.BadgePosition.topEnd(top: -7, end: -7),
                badgeContent: Text("${unreadNotifications.length}"),
                child: const Icon(
                  Icons.notifications,
                  size: 35,
                  // color: ProjectColors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: ProjectConstants.bodyPadding,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfileScreen(
                              name: userRef?.name ?? 'salome',
                              ref: ref,
                              image: userRef?.avatar ?? '',
                              email: userRef?.email ?? 'salome357@gmail.com',
                            )));
              },
              child: Container(
                height: 72,
                decoration: ProjectConstants.appBoxDecoration.copyWith(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.onBackground)),
                child: Consumer(builder: (context, ref, child) {
                  return ListTile(
                    tileColor: Theme.of(context).cardColor,
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(userRef?.avatar ?? ''),
                    ),
                    title: Text(
                      userRef?.name ?? 'salome',
                      style: largeTextStyle,
                    ),
                    subtitle: Text(
                      userRef?.email ?? 'salome357@gmail.com',
                      style: greyTextStyle.copyWith(
                          fontSize: 17,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w700),
                    ),
                    trailing: SvgPicture.asset(
                      ProjectConstants.rightChevron,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  );
                }),
              ),
            ),
            ProjectConstants.sizedBox,
            Container(
              decoration: ProjectConstants.appBoxDecoration.copyWith(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onBackground)),
              child: Column(
                children: [
                  SettingItem(
                    title: 'Notificatons',
                    leading: ProjectConstants.notificationsIcon,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotificationSettings()
                              // NotificationListScreen()
                              ));
                    },
                  ),
                  // SettingItem(
                  //   title: 'Privacy',
                  //   leading: ProjectConstants.privacyIcon,
                  //   onPressed: () {},
                  // ),
                  SettingItem(
                    title: 'Appearance',
                    leading: ProjectConstants.appearanceIcon,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ThemeSettingScreen()));
                    },
                  ),
                  // SettingItem(
                  //   title: 'Language and Region',
                  //   leading: ProjectConstants.languageIcon,
                  //   shape: const Border(),
                  //   onPressed: () {},
                  // ),
                ],
              ),
            ),
            ProjectConstants.sizedBox,
            Container(
              decoration: ProjectConstants.appBoxDecoration.copyWith(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onBackground)),
              child: Column(
                children: [
                  // SettingItem(
                  //   title: 'Help and Support',
                  //   leading: ProjectConstants.helpIcon,
                  //   onPressed: () {},
                  // ),
                  SettingItem(
                    title: 'About',
                    leading: ProjectConstants.aboutIcon,
                    shape: const Border(),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutUs()));
                    },
                  )
                ],
              ),
            ),
            ProjectConstants.sizedBox,
            InkWell(
              onTap: ref.read(appUserProvider.notifier).signOut,
              child: Row(
                children: [
                  SvgPicture.asset(
                    ProjectConstants.logoutIcon,
                    color: Theme.of(context).colorScheme.primary,
                  ),
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
        // tileColor: Colors.white,
        leading: SvgPicture.asset(
          leading,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          title,
          style: settingsItemTextStyle,
        ),
        trailing: const Icon(Icons.chevron_right),
        shape: shape,
        onTap: onPressed,
      ),
    );
  }
}
