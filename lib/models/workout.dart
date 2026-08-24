class Workout {
  final String exerciseName;

  final double weight;
  final int reps;
  final int sets;
  final int rir;
  final DateTime date;

  const Workout({
    required this.exerciseName,
    required this.weight,
    required this.reps,
    required this.sets,
    required this.rir,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'exerciseName': exerciseName,
      'weight': weight,
      'reps': reps,
      'sets': sets,
      'rir': rir,
      'date': date.toIso8601String(),
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      exerciseName: map['exerciseName'] as String,
      weight: (map['weight'] as num).toDouble(),
      reps: map['reps'] as int,
      sets: map['sets'] as int,
      rir: map['rir'] as int,
      date: DateTime.parse(map['date'] as String),
    );
  }
}