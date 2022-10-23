import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/screens/recipe_screen.dart';

class RecipeCarouselItem extends StatefulWidget {
  final Recipe recipe;
  const RecipeCarouselItem({required this.recipe, Key? key}) : super(key: key);

  @override
  State<RecipeCarouselItem> createState() => _RecipeCarouselItemState();
}

class _RecipeCarouselItemState extends State<RecipeCarouselItem> {
  bool _isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      Recipe currentRecipe = widget.recipe;
      return GestureDetector(
        onTap: () {
          //TODO Different unfocs approch
          FocusScope.of(context).unfocus();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => RecipeScreen(
                        recipe: currentRecipe,
                      )));
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 500,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(currentRecipe.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                foregroundDecoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color.fromARGB(200, 0, 0, 0)],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20.0,
              right: 20.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: InkWell(
                      onTap: (() {
                        setState(() {
                          _isBookmarked = !_isBookmarked;
                        });
                      }),
                      child: Container(
                        color: const Color.fromARGB(60, 0, 0, 0),
                        width: 60.0,
                        height: 60.0,
                        child: Icon(
                          Icons.bookmark,
                          color: _isBookmarked
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white,
                          size: 40.0,
                        ),
                      ),
                    )),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    bottom: 30.0,
                    right: 20.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.6,
                            child: Text(
                              currentRecipe.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.0),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "${currentRecipe.ingridients.length} ingridients | ${currentRecipe.time} min",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons.locationPin,
                                color: Colors.white,
                                size: 20.0,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                currentRecipe.country,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "${currentRecipe.kCal} Kcal",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
