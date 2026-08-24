import 'package:flutter/material.dart';

import 'workout_menu_screen.dart';
import '../../models/workout.dart';
import 'add_workout_screen.dart';

class WorkoutScreen extends StatefulWidget {
  final List<String>? selectedExercises;

  const WorkoutScreen({super.key, this.selectedExercises});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  late final List<String> selectedExercises;
  final List<Workout> workouts = [];

  @override
  void initState() {
    super.initState();

    selectedExercises = widget.selectedExercises ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("今日のトレーニング"),

        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WorkoutMenuScreen(),
                ),
              );
            },

            icon: const Icon(Icons.menu),

            tooltip: "トレーニングメニュー",
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            if (selectedExercises.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text(
                        "今日のメニュー",

                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      for (final exercise in selectedExercises)
                        Text("・$exercise"),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 16),

            Expanded(
              child: workouts.isEmpty
                  ? const Center(child: Text("まだトレーニングがありません"))
                  : ListView.builder(
                      itemCount: workouts.length,

                      itemBuilder: (context, index) {
                        final workout = workouts[index];

                        return _buildWorkoutCard(workout, index);
                      },
                    ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,

              child: FilledButton.icon(
                onPressed: _addWorkout,

                icon: const Icon(Icons.add),

                label: const Text("トレーニングを追加"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutCard(Workout workout, int index) {
    final previousWorkout = _findPreviousWorkout(workout, index);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                const Icon(Icons.fitness_center),

                const SizedBox(width: 8),

                Text(
                  workout.exerciseName,

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            if (previousWorkout != null) ...[
              const Text(
                "前回の記録",

                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 4),

              Text(
                "${previousWorkout.weight} kg × "
                "${previousWorkout.reps}回 × "
                "${previousWorkout.sets}セット",
              ),

              Text("RIR ${previousWorkout.rir}"),

              const Divider(height: 24),
            ],

            const Text("今回", style: TextStyle(fontWeight: FontWeight.bold)),

            const SizedBox(height: 4),

            Text(
              "${workout.weight} kg × "
              "${workout.reps}回 × "
              "${workout.sets}セット",
            ),

            Text("RIR ${workout.rir}"),

            if (previousWorkout != null)
              _buildProgressMessage(previousWorkout, workout),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressMessage(Workout previous, Workout current) {
    if (current.weight > previous.weight) {
      return const Padding(
        padding: EdgeInsets.only(top: 12),

        child: Text(
          "🔥 前回より重量UP！",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }

    if (current.reps > previous.reps) {
      return const Padding(
        padding: EdgeInsets.only(top: 12),

        child: Text(
          "📈 前回より回数UP！",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Workout? _findPreviousWorkout(Workout current, int currentIndex) {
    for (int i = currentIndex - 1; i >= 0; i--) {
      final workout = workouts[i];

      if (workout.exerciseName == current.exerciseName) {
        return workout;
      }
    }

    return null;
  }

  Future<void> _addWorkout() async {
    final Workout? workout = await Navigator.push<Workout>(
      context,

      MaterialPageRoute(builder: (context) => const AddWorkoutScreen()),
    );

    if (workout == null) {
      return;
    }

    setState(() {
      workouts.add(workout);
    });
  }
}
