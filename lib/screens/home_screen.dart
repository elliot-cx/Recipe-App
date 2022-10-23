import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_app/widgets/recipe_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _currentTab = 0;
  String _countryFilter = '';

  List<String> filters = ["All", "Sushi", "Burger", "Pizza", "Pasta"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                "Find Best Recipe\nFor Cooking",
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _countryFilter = value;
                      });
                    },
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        hintText: "Search Destination",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                            width: 0.0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: GestureDetector(
                    onTap: (() {}),
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Icon(
                        Icons.filter_list_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              height: 60.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (BuildContext context, int index) {
                    String filterName = filters[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: InkWell(
                        customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 90.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                              color: _selectedIndex == index
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Text(
                            filterName,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: _selectedIndex == index
                                    ? Colors.white
                                    : Colors.grey),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 30.0,
            ),
            RecipeCarousel(
              filters[_selectedIndex],
              _countryFilter,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentTab,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        onTap: ((int value) {
          setState(() {
            _currentTab = value;
          });
        }),
        items: const [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(FontAwesomeIcons.house),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              FontAwesomeIcons.solidBookmark,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              FontAwesomeIcons.bagShopping,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              FontAwesomeIcons.solidUser,
            ),
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
