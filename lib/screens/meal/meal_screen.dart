import 'package:flutter/material.dart';

import '../../models/meal.dart';
import 'add_meal_screen.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  final List<Meal> meals = [];

  NutritionSummary get nutritionSummary {
    var summary = const NutritionSummary();

    for (final meal in meals) {
      summary = summary.add(meal);
    }

    return summary;
  }

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
             _buildNutritionCard(),

            const SizedBox(height: 16),
            
            _buildMealSection(
              "🍳 朝食",
              "朝食",
            ),

            const SizedBox(height: 16),

            _buildMealSection(
              "🍱 昼食",
              "昼食",
            ),

            const SizedBox(height: 16),

            _buildMealSection(
              "🌙 夕食",
              "夕食",
            ),

            const SizedBox(height: 16),

            _buildMealSection(
              "🍪 間食",
              "間食",
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,

              child: FilledButton.icon(
                onPressed: _addMeal,

                icon: const Icon(Icons.add),

                label: const Text("食事を追加"),
              ),
            ),
          ],
        ),
      ),
    );
  }

    Widget _buildNutritionCard() {
    final summary = nutritionSummary;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "今日の栄養",

              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              "カロリー  ${summary.calories.toStringAsFixed(0)} kcal",
            ),

            const SizedBox(height: 8),

            Text(
              "P  ${summary.protein.toStringAsFixed(1)} g",
            ),

            Text(
              "F  ${summary.fat.toStringAsFixed(1)} g",
            ),

            Text(
              "C  ${summary.carbs.toStringAsFixed(1)} g",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealSection(
    String title,
    String mealType,
  ) {
    final typeMeals = meals
        .where((meal) => meal.type == mealType)
        .toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              title,

              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            if (typeMeals.isEmpty)
              const Text("未登録")

            else
              ...typeMeals.map(
                (meal) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),

                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          meal.foodName,
                        ),
                      ),

                      Text(
                        "${meal.quantity.toStringAsFixed(0)} g",
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _addMeal() async {
    final Meal? meal = await Navigator.push<Meal>(
      context,

      MaterialPageRoute(
        builder: (context) => const AddMealScreen(),
      ),
    );

    if (meal == null) {
      return;
    }

    setState(() {
      meals.add(meal);
    });
  }
}