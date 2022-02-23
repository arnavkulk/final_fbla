import 'package:final_fbla/widgets/widgets.dart';
import 'package:flutter/material.dart';

const Color kWhiteColor = Color(0xFFFFFFFF);
const Color kBlackColor = Color(0xFF000000);
const Color kTextColor = Color(0xFF1D150B);
Color kPrimaryColor = Colors.green.shade600;
const Color kSecondaryColor = Color(0xFFF5E1CB);
const Color kBorderColor = Color(0xFFDDDDDD);

class Food extends StatefulWidget {
  static const String route = '/food';
  const Food({Key? key}) : super(key: key);

  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {
  Widget buildSection(String title, Map<String, dynamic> foods) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              ...foods.entries.map(
                (e) => FoodCard(
                  title: e.key,
                  image: e.value,
                  type: title,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> brunches = {
      "Cinnamon Roll": "assets/food/cinnamonroll.png",
      "Muffin": "assets/food/muffin.png",
      "Bagel": "assets/food/bagel.png",
      "Waffles": "assets/food/waffle.png",
      "Parfait": "assets/food/parfait.png",
    };
    Map<String, String> lunches = {
      "Burger": "assets/food/burger.png",
      "Pizza": "assets/food/pizza.png",
      "Sandwich": "assets/food/sandwich.png",
      "Salad": "assets/food/salad.png",
      "French Fries": "assets/food/frenchfries.png",
      "Pasta": "assets/food/pasta.png",
    };
    Map<String, String> snacks = {
      "Apple": "assets/food/apple.png",
      "Orange": "assets/food/orange.png",
      "Banana": "assets/food/banana.png",
    };
    Map<String, String> drinks = {
      "Water": "assets/food/water.png",
      "Milk": "assets/food/milk.png"
    };
    return Screen(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Text(
                "Today's Menu",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSection("Brunches", brunches),
                buildSection("Lunches", lunches),
                buildSection("Snacks", snacks),
                buildSection("Drinks", drinks)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final String title;
  final String image;
  final String type;

  const FoodCard({
    Key? key,
    required this.title,
    required this.image,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      height: 300,
      width: 200,
      child: Container(
        height: 380,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(34),
          color: kPrimaryColor.withOpacity(.16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 181,
              width: 181,
              // decoration: BoxDecoration(
              //   shape: BoxShape.circle,
              //   color: kPrimaryColor.withOpacity(.15),
              // ),
              child: Center(
                child: Container(
                  // height: 120,
                  // width: 276,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(image),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              type,
            )
          ],
        ),
      ),
    );
  }
}

class CategoryTitle extends StatelessWidget {
  final String title;
  final bool active;
  const CategoryTitle({
    Key? key,
    this.active = false,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 30),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold).copyWith(
          color: active ? kPrimaryColor : kTextColor.withOpacity(.4),
        ),
      ),
    );
  }
}
