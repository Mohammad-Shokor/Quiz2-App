import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeItem extends StatelessWidget {
  final Recipe recipe;
  final int index;
  final void Function(int, String) onSelectRating;

  const RecipeItem({
    super.key,
    required this.recipe,
    required this.index,
    required this.onSelectRating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${index + 1}.${recipe.recipeName}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 8),
          Row(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...recipe.emojiRatings.map((emoji) {
                return ElevatedButton(
                  onPressed: () {
                    onSelectRating(index, emoji);
                  },
                  child: Text(emoji),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
