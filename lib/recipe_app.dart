import 'dart:developer';

import 'package:flutter/material.dart';
import 'data/recipes.dart';
import 'models/recipe.dart';
import 'screens/recipes_screen.dart';
import 'screens/result_screen.dart';

class RecipeApp extends StatefulWidget {
  const RecipeApp({super.key});

  @override
  State<RecipeApp> createState() => _RecipeAppState();
}

class _RecipeAppState extends State<RecipeApp> {
  String currentScreen = "recipes-screen";

  // selectedRatings is initially filled with empty strings because the rating is not yet given.
  List<String> selectedRatings = List.filled(recipes.length, "");

  String topRecipeName() {
    int bestValue = -1;
    String bestName = "";

    for (int i = 0; i < recipes.length; i++) {
      if (selectedRatings[i].isNotEmpty) {
        int value = emojiToValue[selectedRatings[i]]!;
        if (value > bestValue) {
          bestValue = value;
          bestName = recipes[i].recipeName;
        }
      }
    }
    return bestName;
  }

  double get averageRating {
    double avg = 0;
    for (int i = 0; i < selectedRatings.length; i++) {
      if (!selectedRatings[i].isEmpty) {
        avg += emojiToValue[selectedRatings[i]]!;
      }
    }
    avg /= selectedRatings.length;
    return avg;
  }

  void _submit() {
    setState(() {
      currentScreen = "Result-Screen";
    });
  }

  void _selectRating(int index, String rating) {
    setState(() {
      selectedRatings[index] = rating;
    });
  }

  void _restart() {
    setState(() {
      selectedRatings = List.filled(recipes.length, "");
      currentScreen = "recipes-screen";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentScreen = "recipes-screen";
  }

  @override
  Widget build(BuildContext context) {
    Widget? screenWidget = currentScreen == "recipes-screen"
        ? RecipesScreen(onSelectRating: _selectRating, onSubmit: _submit)
        : ResultScreen(
            averageRating: averageRating,
            topRecipeName: topRecipeName(),
            onRestart: _restart,
          );

    return Scaffold(
      body: screenWidget,
      backgroundColor: const Color.fromARGB(255, 73, 168, 122),
    );
  }
}
