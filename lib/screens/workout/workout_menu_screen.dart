import 'package:flutter/material.dart';

import '../../models/workout_menu.dart';
import 'create_workout_menu_screen.dart';
import '../../services/workout_menu_storage.dart';
import 'workout_screen.dart';

class WorkoutMenuScreen extends StatefulWidget {
  const WorkoutMenuScreen({super.key});

  @override
  State<WorkoutMenuScreen> createState() {
    return _WorkoutMenuScreenState();
  }
}

class _WorkoutMenuScreenState extends State<WorkoutMenuScreen> {
  final List<WorkoutMenu> menus = [];

  final WorkoutMenuStorage menuStorage =
      WorkoutMenuStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("トレーニングメニュー")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            Expanded(
              child: menus.isEmpty
                  ? const Center(child: Text("まだメニューがありません"))
                  : ListView.builder(
                      itemCount: menus.length,

                      itemBuilder: (context, index) {
                        final menu = menus[index];

                        return _buildMenuCard(menu);
                      },
                    ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,

              child: FilledButton.icon(
                onPressed: _createMenu,

                icon: const Icon(Icons.add),

                label: const Text("メニューを作成"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(WorkoutMenu menu) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              menu.name,

              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            for (final exercise in menu.exercises)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),

                child: Text(
                  "・${exercise.exerciseName}\n"
                  "  ${exercise.weight} kg × "
                  "${exercise.reps}回 × "
                  "${exercise.sets}セット / "
                  "RIR ${exercise.rir}",
                ),
              ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,

              child: FilledButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (context) => WorkoutScreen(
                        selectedExercises: menu.exercises,
                      ),
                    ),
                  );
                },

                icon: const Icon(Icons.play_arrow),

                label: const Text("このメニューで開始"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createMenu() async {
    final WorkoutMenu? menu = await Navigator.push<WorkoutMenu>(
      context,

      MaterialPageRoute(builder: (context) => const CreateWorkoutMenuScreen()),
    );

    if (!mounted || menu == null) {
      return;
    }

    setState(() {
      menus.add(menu);
    });

    await menuStorage.saveMenus(menus);
  }

  @override
void initState() {
  super.initState();

  _loadMenus();
}

  Future<void> _loadMenus() async {
    final savedMenus =
        await menuStorage.loadMenus();

    if (!mounted) {
        return;
    }

  setState(() {
      menus.addAll(savedMenus);
    });
  }
}
