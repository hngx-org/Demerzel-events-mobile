import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/riverpod/notifications_provider.dart';

class NotificationSettings extends ConsumerStatefulWidget {
  const NotificationSettings({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<NotificationSettings> {


  @override
  Widget build(BuildContext context) {
    // final settings = ref.watch(notificationProvider);

    bool eventUpdates =
        ref.read(NotificationSettingsPrefsNotifier.provider).event;
    bool reminders =
        ref.read(NotificationSettingsPrefsNotifier.provider).reminders;
    bool emailNotifications =
        ref.read(NotificationSettingsPrefsNotifier.provider).email;
    bool groupUpdates =
        ref.read(NotificationSettingsPrefsNotifier.provider).group;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text(
              'Event Updates',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: const Text(
                'Be the first to know about event changes, updates, and important announcements.'),
            trailing: Switch(
                value: eventUpdates,
                onChanged: (value) {
                  setState(() {
                    //eventUpdates = value;
                    ref.read(NotificationSettingsPrefsNotifier.provider).event =
                        value;

                    ref
                        .read(
                            NotificationSettingsPrefsNotifier.provider.notifier)
                        .updatePrefs({'event': value});
                  });
                }),
          ),
          ListTile(
            title: const Text(
              'Group Updates',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: const Text(
                'Be the first to know about group changes, updates, and important announcements.'),
            trailing: Switch(
                value: groupUpdates,
                onChanged: (value) {
                  setState(() {
                    groupUpdates = value;
                    ref.read(NotificationSettingsPrefsNotifier.provider).group =
                        value;

                    ref
                        .read(
                            NotificationSettingsPrefsNotifier.provider.notifier)
                        .updatePrefs({'group': value});
                  });
                  // onChanged(value, 'group');
                }),
          ),
          ListTile(
            title: const Text(
              'Reminders',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: const Text(
                'Set up reminders for upcoming events to make sure you never miss out.'),
            trailing: Switch(
                value: reminders,
                onChanged: (value) {
                  setState(() {
                    reminders = value;
                    ref
                        .read(NotificationSettingsPrefsNotifier.provider)
                        .reminders = value;

                    ref
                        .read(
                            NotificationSettingsPrefsNotifier.provider.notifier)
                        .updatePrefs({'reminder': value});
                  });
                  // onChanged(value, 'reminder');
                }),
          ),
          ListTile(
            title: const Text(
              'Email Notifications',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: const Text(
                'Set up reminders for upcoming events to make sure you never miss out.'),
            trailing: Switch(
                value: emailNotifications,
                onChanged: (value) {
                  setState(() {
                    emailNotifications = value;
                    ref.read(NotificationSettingsPrefsNotifier.provider).email =
                        value;

                    ref
                        .read(
                            NotificationSettingsPrefsNotifier.provider.notifier)
                        .updatePrefs({'email': value});
                  });
                  // onChanged(value, 'email');
                }),
          ),
        ],
      ),
    );
  }
}
