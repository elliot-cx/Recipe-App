import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

import '../models/ingridient_model.dart';
import '../models/recipe_model.dart';

class RecipeScreen extends StatefulWidget {
  final Recipe recipe;
  const RecipeScreen({required this.recipe, Key? key}) : super(key: key);

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  late Recipe _currentRecipe;
  late VideoPlayerController _vController;
  int _servingValue = 1;
  bool _isCookVisible = true;

  @override
  void initState() {
    _currentRecipe = widget.recipe;
    _vController = VideoPlayerController.network(
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
      ..addListener(() => setState(() {}))
      ..setLooping(false)
      ..initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      _vController.pause().whenComplete((() {
                        _vController
                            .dispose()
                            .whenComplete(() => Navigator.pop(context));
                      }));
                    },
                    icon: const Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    _currentRecipe.name,
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w900,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              _currentRecipe.imageUrl,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: VideoPlayer(_vController),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: InkWell(
                              onTap: (() {
                                setState(() {
                                  _vController.play();
                                });
                              }),
                              child: Visibility(
                                visible: !_vController.value.isPlaying,
                                child: Container(
                                  color: const Color.fromARGB(60, 0, 0, 0),
                                  width: 60.0,
                                  height: 60.0,
                                  child: Icon(
                                    _vController.value.isPlaying
                                        ? Icons.pause_rounded
                                        : Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 40.0,
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 30.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ingridients (${_currentRecipe.ingridients.length})",
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: DropdownButton(
                        underline: Container(),
                        value: _servingValue,
                        dropdownColor: Theme.of(context).colorScheme.primary,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                        items: <int>[1, 2, 3, 4]
                            .map<DropdownMenuItem>((int value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              "$value Serving",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (dynamic value) {
                          setState(() {
                            _servingValue = value;
                          });
                        }),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  NotificationListener<ScrollUpdateNotification>(
                    onNotification: ((notification) {
                      if (notification.scrollDelta!.isNegative) {
                        setState(() {
                          _isCookVisible = true;
                        });
                      } else {
                        setState(() {
                          _isCookVisible = false;
                        });
                      }
                      return true;
                    }),
                    child: ListView.builder(
                      itemCount: _currentRecipe.ingridients.length,
                      itemBuilder: (BuildContext context, int index) {
                        Ingridient currentIngridient =
                            _currentRecipe.ingridients[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 0.0,
                            color: Colors.transparent,
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  20.0,
                                ),
                              ),
                              tileColor:
                                  const Color.fromARGB(255, 234, 234, 234),
                              contentPadding: const EdgeInsets.all(10.0),
                              leading: Container(
                                alignment: Alignment.center,
                                width: 60.0,
                                height: 60.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Text(
                                  currentIngridient.logo,
                                  style: const TextStyle(
                                    fontSize: 30.0,
                                  ),
                                ),
                              ),
                              title: Text(
                                currentIngridient.name,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700),
                              ),
                              trailing: Text(
                                _currentRecipe.qty[index],
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: _isCookVisible,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: InkWell(
                          onTap: (() {}),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 30.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.black,
                            ),
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Start Cook!",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Icon(
                                      Icons.arrow_forward_outlined,
                                      color: Colors.white,
                                    ),
                                  )
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
