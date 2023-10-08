import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationSettings extends ConsumerWidget {
  const  NotificationSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool eventUpdates = false;
bool reminders = false;
bool emailNotifications = false;
bool pushNotifications = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
      ),
      body:  ListView(
        children: [
          ListTile(
            title: const Text('Event Updates', style: TextStyle(fontWeight: FontWeight.w700),),
            subtitle: const Text(
                'Be the first to know about event changes, updates, and important announcements.'),
                trailing: Switch(value: eventUpdates, onChanged: (value){
      
                }),
          ),
          ListTile(
            title: const Text('Reminders',style: TextStyle(fontWeight: FontWeight.w700),),
            subtitle: const Text(
                'Set up reminders for upcoming events to make sure you never miss out.'),
                trailing: Switch(value: reminders, onChanged: (value){
      
                }),
          ),
          ListTile(
            title: const Text('Email Notifications',style: TextStyle(fontWeight: FontWeight.w700),),
            subtitle: const Text(
                'Set up reminders for upcoming events to make sure you never miss out.'),
                trailing: Switch(value: emailNotifications, onChanged: (value){
      
                }),
          ),
          ListTile(
            title: const Text('Push notifications and In-app alerts',style: TextStyle(fontWeight: FontWeight.w700),),
            subtitle: const Text(
                'Set up reminders for upcoming events to make sure you never miss out.'),
                trailing: Switch(value: pushNotifications, onChanged: (value){
      
                }),
          ),
        ],
      ),
    );
  }
}
