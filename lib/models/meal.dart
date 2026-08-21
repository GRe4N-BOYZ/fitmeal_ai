class Meal {
  final String type;
  final String foodName;
  final double quantity;

  //100gあたりの栄養素
  final double caloriesPer100g;
  final double proteinPer100g;
  final double fatPer100g;
  final double carbsPer100g;

  const Meal({
    required this.type,
    required this.foodName,
    required this.quantity,
    required this.caloriesPer100g,
    required this.proteinPer100g,
    required this.fatPer100g,
    required this.carbsPer100g,
  });

  // 実際に食べた量から計算
  double get calories {
    return caloriesPer100g * quantity / 100;
  }

  double get protein {
    return proteinPer100g * quantity / 100;
  }

  double get fat {
    return fatPer100g * quantity / 100;
  }

  double get carbs {
    return carbsPer100g * quantity / 100;
  }
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