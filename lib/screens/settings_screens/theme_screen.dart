import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/riverpod/theme_provider.dart';

class ThemeSettingScreen extends StatefulWidget {
  const ThemeSettingScreen({super.key});

  @override
  State<ThemeSettingScreen> createState() => _ThemeSettingScreenState();
}

enum ThemeValue {system, dark, light}

class _ThemeSettingScreenState extends State<ThemeSettingScreen> {
  ThemeValue? groupValue = ThemeValue.system;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
      ),
    );
  }
}