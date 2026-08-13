import 'package:flutter/material.dart';
import 'add_meal_screen.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("今日の食事"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 朝食
            _buildMealCard(
              context,
              "🍳 朝食",
              "未登録",
            ),

            const SizedBox(height: 16),

            // 昼食
            _buildMealCard(
              context,
              "🍱 昼食",
              "未登録",
            ),

            const SizedBox(height: 16),

            // 夕食
            _buildMealCard(
              context,
              "🌙 夕食",
              "未登録",
            ),

            const SizedBox(height: 16),

            // 間食
            _buildMealCard(
              context,
              "🍪 間食",
              "未登録",
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddMealScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text("食事を追加"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealCard(
    BuildContext context,
    String title,
    String value,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}