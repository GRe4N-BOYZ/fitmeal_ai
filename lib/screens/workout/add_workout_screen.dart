import 'package:flutter/material.dart';

import '../../models/workout.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({super.key});

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final TextEditingController exerciseController =
      TextEditingController();

  final TextEditingController weightController =
      TextEditingController();

  final TextEditingController repsController =
      TextEditingController();

  final TextEditingController setsController =
      TextEditingController();

  final TextEditingController rirController =
      TextEditingController();

  @override
  void dispose() {
    exerciseController.dispose();
    weightController.dispose();
    repsController.dispose();
    setsController.dispose();
    rirController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("筋トレを追加"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "種目名",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: exerciseController,

              decoration: const InputDecoration(
                hintText: "例：ベンチプレス",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "重量",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: weightController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(
                hintText: "例：60",
                suffixText: "kg",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "回数",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: repsController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(
                hintText: "例：8",
                suffixText: "回",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "セット数",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: setsController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(
                hintText: "例：3",
                suffixText: "セット",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "余裕（RIR）",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: rirController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(
                hintText: "例：2",
                suffixText: "回余裕",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,

              child: FilledButton.icon(
                onPressed: _saveWorkout,

                icon: const Icon(Icons.check),

                label: const Text("保存"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveWorkout() {
    final exerciseName = exerciseController.text.trim();

    final weight = double.tryParse(
      weightController.text,
    );

    final reps = int.tryParse(
      repsController.text,
    );

    final sets = int.tryParse(
      setsController.text,
    );

    final rir = int.tryParse(
      rirController.text,
    );

    if (
      exerciseName.isEmpty ||
      weight == null ||
      reps == null ||
      sets == null ||
      rir == null
    ) {
      return;
    }

    final workout = Workout(
      exerciseName: exerciseName,
      weight: weight,
      reps: reps,
      sets: sets,
      rir: rir,
      date: DateTime.now(),
    );

    Navigator.pop(
      context,
      workout,
    );
  }
}