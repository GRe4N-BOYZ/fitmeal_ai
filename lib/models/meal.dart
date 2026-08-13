class Meal {
  final String type;
  final String foodName;
  final double quantity;

  final double calories;
  final double protein;
  final double fat;
  final double carbs;

  const Meal({
    required this.type,
    required this.foodName,
    required this.quantity,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
  });
}

class NutritionSummary {
  final double calories;
  final double protein;
  final double fat;
  final double carbs;

  const NutritionSummary({
    this.calories = 0,
    this.protein = 0,
    this.fat = 0,
    this.carbs = 0,
  });

  NutritionSummary add(Meal meal) {
    return NutritionSummary(
      calories: calories + meal.calories,
      protein: protein + meal.protein,
      fat: fat + meal.fat,
      carbs: carbs + meal.carbs,
    );
  }
}