import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/notification.dart';
import 'package:hng_events_app/riverpod/notifications_provider.dart';
// import 'package:hng_events_app/screens/settings_screens/notifications_screens/notification_view_screen.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class NotificationListScreen extends ConsumerWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Consumer(builder: (context, ref, child) {
        List<UserNotification> nlist =
            ref.watch(notificationProvider).notifications;
        return (nlist.isEmpty)
            ? const Center(child: Text('No Notifications'))
            : Padding(
                padding: const EdgeInsets.all(24),
                child: ListView.separated(
                  // itemBuilder: (context, index) {
                  //   final notificationIds = <String>[];
                  //   Future.delayed(const Duration(seconds: 5)).then((value) {
                  //     if (nlist[index].read == false) {
                  //       notificationIds.add(nlist[index].id);
                  //       return ref.read(notificationProvider.notifier).onread(
                  //             notification: nlist[index],
                  //             notificationIds: notificationIds,
                  //           );
                  //     } else {
                  //       return null;
                  //     }
                  //   });
                  itemBuilder: (context, index) {
                    Future.delayed(const Duration(seconds: 5)).then((value) {
                      return nlist[index].read == false
                          ? ref
                              .read(notificationProvider.notifier)
                              .onread(nlist[index])
                          : null;
                    });
                    return notificationTile(nlist[index], context, ref);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 16,
                  ),
                  itemCount: nlist.length,
                  // children: List.generate(
                  //   nlist.length,
                  //   (index) => notificationTile(nlist[index], context, ref)
                  // )
                ),
              );
      }),
    );
  }
}

Widget notificationTile(
    UserNotification notification, BuildContext context, WidgetRef ref) {
  return ListTile(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), side: const BorderSide()),
    // onTap: () {
    //   ref.read(notificationProvider.notifier).onread(notification);
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => NotificationViewScreen(notification: notification)
    //     )
    //   );

    // },
    title: Text(
      toBeginningOfSentenceCase(notification.title) as String,
      style: TextStyle(
          color: (notification.read == false) ? null : Colors.grey,
          fontSize: 20),
    ),
    trailing: (notification.read == false)
        ? const Text('Unread')
        : const Text(
            'Read',
            style: TextStyle(color: Colors.grey),
          ),
    subtitle: Text(
      notification.content,
      style:
          TextStyle(color: (notification.read == false) ? null : Colors.grey),
    ),
    isThreeLine: true,
  );
}
