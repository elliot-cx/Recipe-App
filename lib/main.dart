import 'package:flutter/material.dart';
import 'package:recipe_app/screens/home_screen.dart';
import 'package:slide_to_act/slide_to_act.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<SlideActionState> sliderKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter recipe UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: const Color.fromARGB(255, 209, 241, 209),
              primary: const Color.fromARGB(255, 69, 178, 72)),
          scaffoldBackgroundColor: Colors.grey.shade200),
      home: Scaffold(
        body: Builder(builder: (context) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/foods2.jpg"),
                      fit: BoxFit.cover),
                ),
                foregroundDecoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color.fromARGB(121, 0, 0, 0)],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Cooking Experience\nLike a Chef",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    const Text(
                      "Let's make a delicious dish with\nthe best recipe for the family",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 60.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Builder(builder: (context) {
                        return SlideAction(
                          key: sliderKey,
                          text: "         Get Started",
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                          innerColor: Colors.white,
                          outerColor: Theme.of(context).colorScheme.primary,
                          onSubmit: (() {
                            Future.delayed(
                              const Duration(seconds: 1),
                              () => sliderKey.currentState!.reset(),
                            );
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const HomeScreen()));
                          }),
                        );
                      }),
                    ),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
