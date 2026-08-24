import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/workout.dart';

class WorkoutStorage {
  static const String _key = 'workouts';

  Future<void> saveWorkouts(List<Workout> workouts) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> workoutList = workouts
        .map((workout) => jsonEncode(workout.toMap()))
        .toList();

    await prefs.setStringList(
      _key,
      workoutList,
    );
  }

  Future<List<Workout>> loadWorkouts() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String>? workoutList =
        prefs.getStringList(_key);

    if (workoutList == null) {
      return [];
    }

    return workoutList
        .map(
          (workout) => Workout.fromMap(
            jsonDecode(workout) as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  Future<void> clearWorkouts() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_key);
  }
}