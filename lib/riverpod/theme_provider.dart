import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system);
  bool calledThemeLocal = false;

  initCall(){
    if (!calledThemeLocal) {
      getThemeLocal();
    }
  }  

  switchMode(ThemeMode mode) async {
    switch (mode) {
      case ThemeMode.light:{
        await setThemeLocal('light');
      }        
        break;
      case ThemeMode.system:{
        await setThemeLocal('system');
      }        
        break;
      case ThemeMode.dark:{
        await setThemeLocal('dark');
      }        
        break;
      default:
    }
    return state = mode;
  } 

  Future getThemeLocal() async{
    calledThemeLocal = true;
    SharedPreferences pref = await SharedPreferences.getInstance();  
    
    final mode = pref.getString('theme');
    switch (mode) {
      case 'system':{
        log(mode.toString());
        state = ThemeMode.system;
      }        
        break;
      case 'dark':{
        state = ThemeMode.dark;
      }        
        break;
      case 'light':{
        state = ThemeMode.light;
      }        
        break;
      default: 
    }
  }

  Future setThemeLocal(String modeString) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', modeString);
  }
}
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) => ThemeNotifier());
final themeLocal = FutureProvider((ref) async{
  return await ref.read(themeProvider.notifier).getThemeLocal.call();
});