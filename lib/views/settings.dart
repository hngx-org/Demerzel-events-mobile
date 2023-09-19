import 'package:flutter/material.dart';
import 'package:hng_events_app/shared/constants.dart';

import '../shared/colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.bgColor,
      appBar: AppBar(
       centerTitle: false,
       bottom: PreferredSize(preferredSize: const Size.fromHeight(4.0), child: Container(height: 1, color: Colors.black,)),
        title: const Text('Settings'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))],
      ),
      body: Padding(
        padding: kBodyPadding,
        child: Column(
          children: [
            Container(
              height: 82,
              decoration: kAppBoxDecoration,
              child: ListTile(
                leading: const CircleAvatar(),
                // TODO: change this to name of current user
                title: const Text('Salome'),
                subtitle: const Text('salome357@gmail.com'),
                trailing: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.chevron_right)),
              ),
            ),
            kSizedBox,
            Container(
              decoration: kAppBoxDecoration,
              child: const Column(
                children: [
                  SettingItem(
                    title: 'Notificatons',
                    leading: Icons.notifications,
                  ),
                  SettingItem(
                    title: 'Privacy',
                    leading: Icons.notifications,
                  ),
                  SettingItem(
                    title: 'Appearance',
                    leading: Icons.notifications,
                  ),
                  SettingItem(
                    title: 'Language and Region',
                    leading: Icons.notifications,
                    shape: Border(),
                  ),
                ],
              ),
            ),
            kSizedBox,
            Container(
              decoration: kAppBoxDecoration,
              child: const Column(
                children: [
                  SettingItem(title: 'Help and Support', leading: Icons.help),
                  SettingItem(
                    title: 'About',
                    leading: Icons.info,
                    shape: Border(),
                  )
                ],
              ),
            ),
            kSizedBox,
            const InkWell(
              child: Row(
                children: [
                  Icon(Icons.logout),
                  Text('Logout'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final String title;
  final IconData leading;
  final Border shape;
  const SettingItem({
    super.key,
    required this.title,
    required this.leading,
    this.shape = const Border(
        bottom: BorderSide(color: ProjectColors.lightBoxBorderColor, width: 0.5)),
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leading),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      shape: shape,
    );
  }
}
