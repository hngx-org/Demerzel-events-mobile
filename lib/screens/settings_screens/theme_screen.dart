import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/riverpod/theme_provider.dart';

class ThemeSettingScreen extends ConsumerStatefulWidget {
  const ThemeSettingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ThemeSettingScreenState();
}

enum ThemeValue {system, dark, light}

class _ThemeSettingScreenState extends ConsumerState<ThemeSettingScreen> {
  ThemeValue? groupValue;
  @override
 

  @override
  Widget build(BuildContext context) {
    groupValue = switch (ref.watch(themeProvider)) {
      ThemeMode.dark => ThemeValue.dark,
      ThemeMode.system => ThemeValue.system,
      ThemeMode.light => ThemeValue.light,
    };
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appearance'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return ListView(
            children: [
              RadioListTile<ThemeValue>(
                title: const Text('System default'),
                value: ThemeValue.system, 
                groupValue: groupValue, 
                onChanged: (ThemeValue? value){
                  ref.read(themeProvider.notifier).switchMode(ThemeMode.system);
                  ref.read(themeProvider.notifier).getThemeLocal();
                  setState(() {
                    groupValue = value;
                  });
                }
              ),
              RadioListTile<ThemeValue>(
                title: const Text('Light'),
                value: ThemeValue.light, 
                groupValue: groupValue, 
                onChanged: (ThemeValue? value){
                  ref.read(themeProvider.notifier).switchMode(ThemeMode.light);
                  setState(() {
                    groupValue = value;
                  });
                }
              ),
              RadioListTile<ThemeValue>(
                title: const Text('Dark'),
                value: ThemeValue.dark, 
                groupValue: groupValue, 
                onChanged: (ThemeValue? value){
                  ref.read(themeProvider.notifier).switchMode(ThemeMode.dark);
                  setState(() {
                    groupValue = value;
                  });
                }
              )
            ],
          );
        }
      ),
    );
  }
}