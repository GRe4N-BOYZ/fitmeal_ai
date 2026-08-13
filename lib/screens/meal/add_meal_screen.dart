import 'package:flutter/material.dart';
import '../../models/meal.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final TextEditingController foodController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  String selectedMeal = "朝食";

  @override
  void dispose() {
    foodController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("食事を追加"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "食事の種類",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              initialValue: selectedMeal,

              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),

              items: const [
                DropdownMenuItem(
                  value: "朝食",
                  child: Text("🍳 朝食"),
                ),
                DropdownMenuItem(
                  value: "昼食",
                  child: Text("🍱 昼食"),
                ),
                DropdownMenuItem(
                  value: "夕食",
                  child: Text("🌙 夕食"),
                ),
                DropdownMenuItem(
                  value: "間食",
                  child: Text("🍪 間食"),
                ),
              ],

              onChanged: (value) {
                if (value == null) {
                  return;
                }

                setState(() {
                  selectedMeal = value;
                });
              },
            ),

            const SizedBox(height: 24),

            const Text(
              "食品名",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: foodController,

              decoration: const InputDecoration(
                hintText: "例：鶏むね肉",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "数量",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: quantityController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(
                hintText: "例：150",
                suffixText: "g",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,

              child: FilledButton.icon(
                onPressed: () {
                  final food = foodController.text;
                  final quantity = double.tryParse(
                    quantityController.text,
                  );

                  if (food.isEmpty || quantity == null) {
                    return;
                  }

                  final meal = Meal(
                    type: selectedMeal,
                    foodName: food,
                    quantity: quantity,
                    calories: 250,
                    protein: 20,
                    fat: 5,
                    carbs: 30,
                  );

                  Navigator.pop(
                    context,
                    meal,
                  );
                },

                icon: const Icon(Icons.check),

                label: const Text("保存"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}