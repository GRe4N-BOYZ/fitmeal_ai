class Workout {
  final String exerciseName;

  final double weight;
  final int reps;
  final int sets;

  final bool hadRoom;

  const Workout({
    required this.exerciseName,
    required this.weight,
    required this.reps,
    required this.sets,
    required this.hadRoom,
  });
}