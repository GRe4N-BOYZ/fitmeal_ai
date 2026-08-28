class WorkoutMenu {
  final String name;
  final List<String> exercises;

  const WorkoutMenu({
    required this.name,
    required this.exercises,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'exercises': exercises,
    };
  }

  factory WorkoutMenu.fromMap(Map<String, dynamic> map) {
    return WorkoutMenu(
      name: map['name'] as String,
      exercises: List<String>.from(
        map['exercises'] as List,
      ),
    );
  }
}