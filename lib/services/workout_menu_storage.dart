import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/workout_menu.dart';

class WorkoutMenuStorage {
  static const String _key = 'workout_menus';

  Future<void> saveMenus(
    List<WorkoutMenu> menus,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();

    final List<String> menuList = menus
        .map(
          (menu) => jsonEncode(menu.toMap()),
        )
        .toList();

    await prefs.setStringList(
      _key,
      menuList,
    );
  }

  Future<List<WorkoutMenu>> loadMenus() async {
    final prefs =
        await SharedPreferences.getInstance();

    final List<String>? menuList =
        prefs.getStringList(_key);

    if (menuList == null) {
      return [];
    }

    return menuList
        .map(
          (menu) => WorkoutMenu.fromMap(
            jsonDecode(menu)
                as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}