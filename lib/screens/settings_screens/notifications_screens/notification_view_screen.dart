import 'package:flutter/material.dart';
import 'package:hng_events_app/models/notification.dart';
import 'package:hng_events_app/screens/settings_screens/notifications_screens/notification_list_screen.dart';

class NotificationViewScreen extends StatelessWidget {
  const NotificationViewScreen({super.key, required this.notification});
  final UserNotification notification;

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(notification.title),
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationListScreen()
              )
            );
          }, 
          icon: const Icon(Icons.arrow_back)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                child: SizedBox(
                  width: screensize.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      notification.content,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.left ,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: screensize.width*0.9,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(notification.time)))
            ],
          ),
        ),
      ),
    );
  }
}