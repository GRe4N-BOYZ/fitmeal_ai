import 'package:flutter/material.dart';

import '../../models/workout_menu.dart';
import '../../models/workout_menu_exercise.dart';

class CreateWorkoutMenuScreen extends StatefulWidget {
  const CreateWorkoutMenuScreen({super.key});

  @override
  State<CreateWorkoutMenuScreen> createState() {
    return _CreateWorkoutMenuScreenState();
  }
}

class _CreateWorkoutMenuScreenState extends State<CreateWorkoutMenuScreen> {
  final TextEditingController nameController = TextEditingController();

  // These controllers are kept alive for the lifetime of this screen. A dialog
  // route can still be removing its TextFields when showDialog completes, so
  // disposing them immediately after Navigator.pop can break that teardown.
  final TextEditingController exerciseNameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController repsController = TextEditingController();
  final TextEditingController setsController = TextEditingController();
  final TextEditingController rirController = TextEditingController();

  final List<WorkoutMenuExercise> exercises = [];

  @override
  void dispose() {
    nameController.dispose();
    exerciseNameController.dispose();
    weightController.dispose();
    repsController.dispose();
    setsController.dispose();
    rirController.dispose();

    super.dispose();
  }

  Future<void> _addExercise() async {
    exerciseNameController.clear();
    weightController.clear();
    repsController.clear();
    setsController.clear();
    rirController.clear();

    final WorkoutMenuExercise? exercise = await showDialog<WorkoutMenuExercise>(
      context: context,

      builder: (dialogContext) {
        String? nameError;
        String? weightError;
        String? repsError;
        String? setsError;
        String? rirError;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("種目を追加"),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    TextField(
                      controller: exerciseNameController,

                      decoration: InputDecoration(
                        labelText: "種目名",
                        hintText: "例：ベンチプレス",
                        errorText: nameError,
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: weightController,

                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),

                      decoration: InputDecoration(
                        labelText: "重量",
                        suffixText: "kg",
                        errorText: weightError,
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: repsController,

                      keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        labelText: "回数",
                        suffixText: "回",
                        errorText: repsError,
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: setsController,

                      keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        labelText: "セット数",
                        suffixText: "セット",
                        errorText: setsError,
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: rirController,

                      keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        labelText: "RIR",
                        hintText: "例：2",
                        errorText: rirError,
                      ),
                    ),
                  ],
                ),
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },

                  child: const Text("キャンセル"),
                ),

                FilledButton(
                  onPressed: () {
                    final name = exerciseNameController.text.trim();

                    final weight = double.tryParse(weightController.text);

                    final reps = int.tryParse(repsController.text);

                    final sets = int.tryParse(setsController.text);

                    final rir = int.tryParse(rirController.text);

                    setDialogState(() {
                      nameError = name.isEmpty ? "種目名を入力してください" : null;

                      weightError = weight == null || weight <= 0
                          ? "正しい重量を入力してください"
                          : null;

                      repsError = reps == null || reps <= 0
                          ? "1回以上を入力してください"
                          : null;

                      setsError = sets == null || sets <= 0
                          ? "1セット以上を入力してください"
                          : null;

                      rirError = rir == null || rir < 0
                          ? "0以上のRIRを入力してください"
                          : null;
                    });

                    if (name.isEmpty ||
                        weight == null ||
                        weight <= 0 ||
                        reps == null ||
                        reps <= 0 ||
                        sets == null ||
                        sets <= 0 ||
                        rir == null ||
                        rir < 0) {
                      return;
                    }

                    final exercise = WorkoutMenuExercise(
                      exerciseName: name,
                      weight: weight,
                      reps: reps,
                      sets: sets,
                      rir: rir,
                    );

                    Navigator.pop(dialogContext, exercise);
                  },

                  child: const Text("追加"),
                ),
              ],
            );
          },
        );
      },
    );

    if (!mounted || exercise == null) {
      return;
    }

    setState(() {
      exercises.add(exercise);
    });
  }

  void _removeExercise(int index) {
    setState(() {
      exercises.removeAt(index);
    });
  }

  void _reorderExercise(int oldIndex, int newIndex) {
    setState(() {
      final exercise = exercises.removeAt(oldIndex);

      exercises.insert(newIndex, exercise);
    });
  }

  void _saveMenu() {
    final String name = nameController.text.trim();

    if (name.isEmpty || exercises.isEmpty) {
      return;
    }

    final WorkoutMenu menu = WorkoutMenu(
      name: name,
      exercises: List<WorkoutMenuExercise>.from(exercises),
    );

    Navigator.pop(context, menu);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("メニューを作成")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "メニュー名",

              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: nameController,

              decoration: const InputDecoration(
                hintText: "例：胸・肩",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "種目",

              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),

            const Text(
              "長押しして並び替え・左にスワイプして削除",

              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: exercises.isEmpty
                  ? const Center(child: Text("まだ種目がありません"))
                  : ReorderableListView.builder(
                      itemCount: exercises.length,

                      onReorderItem: _reorderExercise,

                      itemBuilder: (context, index) {
                        final exercise = exercises[index];

                        return Dismissible(
                          key: ValueKey("${exercise.exerciseName}-$index"),

                          direction: DismissDirection.endToStart,

                          background: Container(
                            margin: const EdgeInsets.only(bottom: 8),

                            alignment: Alignment.centerRight,

                            padding: const EdgeInsets.symmetric(horizontal: 20),

                            child: const Icon(Icons.delete),
                          ),

                          onDismissed: (direction) {
                            _removeExercise(index);
                          },

                          child: Card(
                            child: ListTile(
                              leading: const Icon(Icons.fitness_center),

                              title: Text(exercise.exerciseName),

                              subtitle: Text(
                                "${exercise.weight} kg × "
                                "${exercise.reps}回 × "
                                "${exercise.sets}セット / "
                                "RIR ${exercise.rir}",
                              ),

                              trailing: const Icon(Icons.drag_handle),
                            ),
                          ),
                        );
                      },
                    ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,

              child: OutlinedButton.icon(
                onPressed: _addExercise,

                icon: const Icon(Icons.add),

                label: const Text("種目を追加"),
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,

              child: FilledButton(
                onPressed: _saveMenu,

                child: const Text("保存"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
