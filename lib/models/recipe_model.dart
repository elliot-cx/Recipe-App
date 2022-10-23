import 'package:recipe_app/models/ingridient_model.dart';

class Recipe {
  String name;
  String categoryName;
  String country;
  int time;
  List<Ingridient> ingridients;
  List<String> qty;
  String imageUrl;
  int kCal;

  Recipe(
      {required this.name,
      required this.categoryName,
      required this.country,
      required this.time,
      required this.ingridients,
      required this.qty,
      required this.imageUrl,
      required this.kCal});
}

List<Recipe> recipes = [
  Recipe(
      name: "Salmon Sushi Matcha",
      categoryName: "Sushi",
      country: "Japan",
      time: 40,
      ingridients: [
        matchaIngridient,
        riceIngridient,
        salmonIngridient,
        onionIngridient
      ],
      qty: ["1 tea spon", "200 g", "400 g", "20 g"],
      imageUrl: "assets/images/sushi1.jpg",
      kCal: 405),
  Recipe(
      name: "American Classic Burger",
      categoryName: "Burger",
      country: "U.S.A",
      time: 20,
      ingridients: [
        breadIngridient,
        baconIngridient,
        steakIngridient,
        onionIngridient,
        pickleIngridient,
        saladIngridient,
        tomatoIngridient,
        cheddarIngridient,
      ],
      qty: [
        "2 slices of bread",
        "200 g",
        "300 g",
        "20 g",
        "20 g",
        "20 g",
        "30 g",
        "100 g"
      ],
      imageUrl: "assets/images/burger.jpg",
      kCal: 510),
  Recipe(
      name: "Pasta Bolognese",
      categoryName: "Pasta",
      country: "Italy",
      time: 30,
      ingridients: [
        pastaIngridient,
        tomatoCoulisIngridient,
        onionIngridient,
        garlicIngridient,
        thymeIngridient,
        parmesanIngridient,
        groundMeatIngridient,
        oliveOilIngridient,
        granulatedSugarIngridient
      ],
      qty: [
        "250 g",
        "800 g",
        "1",
        "3",
        "2 branches",
        "50 g",
        "500 g",
        "2 tea spons",
        "1 tea spon"
      ],
      imageUrl: "assets/images/pasta.jpg",
      kCal: 320),
  Recipe(
      name: "Pizza Margerita",
      categoryName: "Pizza",
      country: "Italy",
      time: 60,
      ingridients: [
        flourIngridient,
        lukewarmWaterIngridient,
        oliveOilIngridient,
        saltIngridient,
        yeastIngridient,
        tomatoCoulisIngridient,
        mozzarellaIngridient,
        baslicIngridient
      ],
      qty: [
        "225 g",
        "125 ml",
        "35ml",
        "1 tea spon",
        "7 g",
        "100 ml",
        "150 g",
        "10"
      ],
      imageUrl: "assets/images/pizza.jpg",
      kCal: 753)
];
