import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/classes/notification.dart';
import 'package:hng_events_app/riverpod/notifications_provider.dart';
import 'package:hng_events_app/screens/settings_screens/notifications_screens/notification_view_screen.dart';



class NotificationListScreen extends StatelessWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          List<UserNotification> nlist = ref.watch(notificationProvider).notifications;
          return ListView(
            children: List.generate(
              nlist.length, 
              (index) => notificationTile(nlist[index], context, ref)
            )
          );
        }
      ),
    );
  }

  
}


Widget notificationTile(UserNotification notification, BuildContext context, WidgetRef ref){
  return ListTile(
    onTap: () {
      ref.read(notificationProvider.notifier).onread(notification);
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context) => NotificationViewScreen(notification: notification)
        )
      );
      
    },
    title: Text(
      notification.title, 
      style: TextStyle(
        color: (notification.read == false)? null : Colors.grey ,
        fontSize: 20
      ),),
    subtitle: Text(
      notification.content,
      style: TextStyle(
        color: (notification.read == false)? null : Colors.grey
      ),
      ),
    isThreeLine: true,
  );
}