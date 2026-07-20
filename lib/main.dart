import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';
import 'core/theme.dart';

void main()
{
  runApp(const FitmealAI());
}

class FitmealAI extends StatelessWidget
{
  const FitmealAI({super.key});

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,

      title:"FitMeal AI",

      theme: AppTheme.lightTheme,

      home: const HomeScreen(),
    );
  }
}