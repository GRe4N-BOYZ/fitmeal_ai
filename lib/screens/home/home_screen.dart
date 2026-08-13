import '../../widgets/stat_card.dart';
import '../../widgets/meal_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("FitMeal AI"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              //キャラクター
              const CircleAvatar(
                radius: 45,
                child: Text(
                  "🐣",
                  style: TextStyle(fontSize: 40),
                ),
              ),

              const SizedBox(height: 12),

              //レベル
              const Text(
                "Lv.1",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),
              //メッセージ
              const Text("今日も健康を育てよ！"),

              const SizedBox(height: 24),
              //今日の食事
              const MealCard(),

              const SizedBox(height: 16),
              //体重
              const StatCard(
                title: "今日の体重",
                value: "68.4 kg",
              ),

              const SizedBox(height: 12),

              // 歩数
              const StatCard(
                title: "今日の歩数",
                value: "8,120 歩",
              ),

              const SizedBox(height: 12),

              // 睡眠
              const StatCard(
                title: "睡眠",
                value: "7時間15分",
              ),
            ],
          ),
        )
      )
    );
  }
}