import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/recipe_carousel_item.dart';

import '../models/recipe_model.dart';

class RecipeCarousel extends StatefulWidget {
  final List<Recipe> _recipes = [];

  RecipeCarousel(String filter, String destination, {Key? key})
      : super(key: key) {
    _recipes.clear();
    destination = destination.toLowerCase();
    for (Recipe recipe in recipes) {
      if (filter == 'All' || recipe.categoryName.contains(filter)) {
        if (recipe.country.toLowerCase().contains(destination)) {
          _recipes.add(recipe);
        }
      }
    }
  }

  @override
  State<RecipeCarousel> createState() => _RecipeCarouselState();
}

class _RecipeCarouselState extends State<RecipeCarousel> {
  @override
  Widget build(BuildContext context) {
    if (widget._recipes.isNotEmpty) {
      return ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: widget._recipes.length,
          itemBuilder: (BuildContext context, int index) {
            Recipe currentRecipe = widget._recipes[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: RecipeCarouselItem(
                recipe: currentRecipe,
              ),
            );
          });
    } else {
      return const Center(
        child: Text(
          "No recipes found",
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
      );
    }
  }
}
