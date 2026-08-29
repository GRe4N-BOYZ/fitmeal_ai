class WorkoutMenuExercise {
  final String exerciseName;
  final double weight;
  final int reps;
  final int sets;
  final int rir;

  const WorkoutMenuExercise({
    required this.exerciseName,
    required this.weight,
    required this.reps,
    required this.sets,
    required this.rir,
  });

  Map<String, dynamic> toMap() {
    return {
      'exerciseName': exerciseName,
      'weight': weight,
      'reps': reps,
      'sets': sets,
      'rir': rir,
    };
  }

  factory WorkoutMenuExercise.fromMap(
    Map<String, dynamic> map,
  ) {
    return WorkoutMenuExercise(
      exerciseName: map['exerciseName'] as String,
      weight: (map['weight'] as num).toDouble(),
      reps: map['reps'] as int,
      sets: map['sets'] as int,
      rir: map['rir'] as int,
    );
  }
}