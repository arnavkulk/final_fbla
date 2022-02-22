import 'package:final_fbla/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Category {
  final String name;
  final int numOfCourses;
  final String image;

  Category(this.name, this.numOfCourses, this.image);
}

class Activities extends StatefulWidget {
  static const String route = '/activities';
  const Activities({Key? key}) : super(key: key);

  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  static const kTextColor = Color(0xFF0D1333);
  static const kBlueColor = Color(0xFF6E8AFA);
  static const kBestSellerColor = Color(0xFFFFD073);
  static const kGreenColor = Color(0xFF49CC96);

// My Text Styles
  static const kHeadingextStyle = TextStyle(
    fontSize: 28,
    color: kTextColor,
    fontWeight: FontWeight.bold,
  );
  static const kSubheadingextStyle = TextStyle(
    fontSize: 24,
    color: Color(0xFF61688B),
    height: 2,
  );

  static const kTitleTextStyle = TextStyle(
    fontSize: 20,
    color: kTextColor,
    fontWeight: FontWeight.bold,
  );

  static const kSubtitleTextSyule = TextStyle(
    fontSize: 18,
    color: kTextColor,
    // fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    List<Map> categoriesData = [
      {"name": "Marketing", 'courses': 17, 'image': "assets/marketing.png"},
      {"name": "UX Design", 'courses': 25, 'image': "assets/ux_design.png"},
      {"name": "Photography", 'courses': 13, 'image': "assets/photography.png"},
      {"name": "Business", 'courses': 17, 'image': "assets/business.png"},
    ];

    List<Category> categories = categoriesData
        .map((item) => Category(item['name'], item['courses'], item['image']))
        .toList();
    return Screen(
      child: Padding(
        padding: EdgeInsets.only(left: 20, top: 50, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Activities", style: kHeadingextStyle),
            Text("Find a club you want to join!", style: kSubheadingextStyle),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F7),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: <Widget>[
                  Icon(Icons.search),
                  SizedBox(width: 16),
                  Text(
                    "Search for anything",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFA0A5BD),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Category", style: kTitleTextStyle),
                Text(
                  "See All",
                  style: kSubtitleTextSyule.copyWith(color: kBlueColor),
                ),
              ],
            ),
            SizedBox(height: 30),
            Expanded(
              child: MasonryGridView.count(
                padding: EdgeInsets.all(0),
                crossAxisCount: 2,
                itemCount: categories.length,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(20),
                    height: index.isEven ? 200 : 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(categories[index].image),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          categories[index].name,
                          style: kTitleTextStyle,
                        ),
                        Text(
                          '${categories[index].numOfCourses} Courses',
                          style: TextStyle(
                            color: kTextColor.withOpacity(.5),
                          ),
                        )
                      ],
                    ),
                  );
                },

                // staggeredTileBuilder: (index) => StaggeredGridTile.fit(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
