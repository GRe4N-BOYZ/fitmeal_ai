import 'package:flutter/material.dart';

import '../../models/workout_menu.dart';

class CreateWorkoutMenuScreen extends StatefulWidget {
  const CreateWorkoutMenuScreen({super.key});

  @override
  State<CreateWorkoutMenuScreen> createState() =>
      _CreateWorkoutMenuScreenState();
}

class _CreateWorkoutMenuScreenState extends State<CreateWorkoutMenuScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController exerciseController = TextEditingController();

  final List<String> exercises = [];

  @override
  void dispose() {
    nameController.dispose();
    exerciseController.dispose();
    super.dispose();
  }

  Future<void> _addExercise() async {
    exerciseController.clear();

    final String? exerciseName = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("種目を追加"),

          content: TextField(
            controller: exerciseController,

            autofocus: true,

            decoration: const InputDecoration(hintText: "例：ベンチプレス"),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text("キャンセル"),
            ),

            FilledButton(
              onPressed: () {
                final String name = exerciseController.text.trim();

                if (name.isEmpty) {
                  return;
                }

                Navigator.pop(context, name);
              },

              child: const Text("追加"),
            ),
          ],
        );
      },
    );

    if (!mounted || exerciseName == null) {
      return;
    }

    setState(() {
      exercises.add(exerciseName);
    });
  }

  void _removeExercise(int index) {
    setState(() {
      exercises.removeAt(index);
    });
  }

  void _saveMenu() {
    final String name = nameController.text.trim();

    if (name.isEmpty || exercises.isEmpty) {
      return;
    }

    final WorkoutMenu menu = WorkoutMenu(name: name, exercises: exercises);

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

            const SizedBox(height: 8),

            Expanded(
              child: exercises.isEmpty
                  ? const Center(child: Text("まだ種目がありません"))
                  : ListView.builder(
                      itemCount: exercises.length,

                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.fitness_center),

                            title: Text(exercises[index]),

                            trailing: IconButton(
                              onPressed: () {
                                _removeExercise(index);
                              },

                              icon: const Icon(Icons.delete_outline),
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
