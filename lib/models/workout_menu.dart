import 'workout_menu_exercise.dart';

class WorkoutMenu {
  final String name;
  final List<WorkoutMenuExercise> exercises;

  const WorkoutMenu({
    required this.name,
    required this.exercises,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'exercises': exercises
          .map((exercise) => exercise.toMap())
          .toList(),
    };
  }

  factory WorkoutMenu.fromMap(
    Map<String, dynamic> map,
  ) {
    return WorkoutMenu(
      name: map['name'] as String,

      exercises: (map['exercises'] as List)
          .map(
            (exercise) =>
                WorkoutMenuExercise.fromMap(
              exercise as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
}