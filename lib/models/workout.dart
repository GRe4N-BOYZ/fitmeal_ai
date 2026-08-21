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
}