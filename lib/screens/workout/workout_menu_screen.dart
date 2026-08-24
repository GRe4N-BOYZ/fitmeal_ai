import 'package:flutter/material.dart';

import '../../models/workout_menu.dart';
import 'create_workout_menu_screen.dart';

class WorkoutMenuScreen extends StatefulWidget {
  const WorkoutMenuScreen({super.key});

  @override
  State<WorkoutMenuScreen> createState() {
    return _WorkoutMenuScreenState();
  }
}

class _WorkoutMenuScreenState extends State<WorkoutMenuScreen> {
  final List<WorkoutMenu> menus = [];

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
                padding: const EdgeInsets.only(bottom: 4),

                child: Text("・$exercise"),
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
  }
}
