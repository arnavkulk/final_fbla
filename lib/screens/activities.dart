import 'package:beamer/src/beamer.dart';
import 'package:final_fbla/models/activity.dart';
import 'package:final_fbla/providers/activity_provider.dart';
import 'package:final_fbla/providers/auth_provider.dart';
import 'package:final_fbla/providers/user_provider.dart';
import 'package:final_fbla/screens/screens.dart';
import 'package:final_fbla/services/user_service.dart';
import 'package:final_fbla/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const kBlackColor = Color(0xFF393939);
const kLightBlackColor = Color(0xFF8F8F8F);
const kIconColor = Color(0xFFF48A37);
const kProgressIndicator = Color(0xFFBE7066);

final kShadowColor = Color(0xFFD3D3D3).withOpacity(.84);

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
    var size = MediaQuery.of(context).size;
    ActivityProvider activityProvider = Provider.of<ActivityProvider>(context);
    Activity? activityOfTheDay = activityProvider.activities.length > 0
        ? activityProvider.activities[0]
        : null;
    List<Activity> activities = activityProvider.activities.skip(1).toList();
    return Screen(
      top: false,
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: size.height * .1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: RichText(
                      text: TextSpan(
                        // style: Theme.of(context).textTheme.display1,
                        children: [
                          TextSpan(
                            text: "Activities for You",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        ...activities.map(
                          (a) => ActivityCard(
                            activity: a,
                          ),
                        ),
                        SizedBox(width: 30),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            // style: Theme.of(context).textTheme.display1,
                            children: [
                              TextSpan(
                                text: "Club of the Month",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        bestOfTheDayCard(size, context, activityOfTheDay),
                      ],
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

  Container bestOfTheDayCard(
      Size size, BuildContext context, Activity? activity) {
    if (activity == null) return Container();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      height: 245,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: 24,
                top: 24,
                right: size.width * .35,
              ),
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFEAEAEA).withOpacity(.45),
                borderRadius: BorderRadius.circular(29),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  ),
                  Text(
                    activity.name,
                    style: TextStyle(
                        color: kBlackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50, bottom: 10.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: BookRating(score: 49),
                        ),
                        Expanded(
                          child: Text(
                            activity.description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10,
                              color: kLightBlackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Image.asset(
              activity.image,
              width: size.width * .6,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              height: 40,
              width: size.width * .3,
              child: TwoSideRoundedButton(
                radious: 24,
                text: Provider.of<UserProvider>(context)
                        .user!
                        .activityIds
                        .contains(activity.id)
                    ? "Leave"
                    : "Join",
                press: () {
                  String uid = Provider.of<AuthProvider>(context, listen: false)
                      .user!
                      .uid;
                  if (!Provider.of<UserProvider>(context, listen: false)
                      .user!
                      .activityIds
                      .contains(activity.id)) {
                    UserService.addActivity(uid, activity.id);
                  } else {
                    UserService.removeActivity(uid, activity.id);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TwoSideRoundedButton extends StatelessWidget {
  final String text;
  final double radious;
  final void Function() press;
  const TwoSideRoundedButton({
    Key? key,
    required this.text,
    this.radious = 29,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: kBlackColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radious),
            bottomRight: Radius.circular(radious),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final Activity activity;

  const ActivityCard({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24, bottom: 40),
      height: 245,
      width: 202,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 221,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(29),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 33,
                    color: kShadowColor,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 20,
            child: Image.asset(
              activity.image,
              width: 150,
            ),
          ),
          Positioned(
            top: 35,
            right: 10,
            child: Column(
              children: <Widget>[
                // IconButton(
                //   icon: Icon(
                //     Icons.favorite_border,
                //   ),
                //   onPressed: () {},
                // ),
                SizedBox(
                  height: 40,
                ),
                BookRating(score: activity.members),
              ],
            ),
          ),
          Positioned(
            top: 160,
            child: Container(
              height: 85,
              width: 202,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: RichText(
                      maxLines: 2,
                      text: TextSpan(
                        style: TextStyle(color: kBlackColor),
                        children: [
                          TextSpan(
                            text: "${activity.name}\n",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        // onTap: () => context.beamToNamed(
                        //   ActivityDetails.route,
                        //   data: {
                        //     activity,
                        //   },
                        // ),
                        child: Container(
                          width: 101,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text("Details"),
                        ),
                      ),
                      Expanded(
                        child: TwoSideRoundedButton(
                          text: Provider.of<UserProvider>(context)
                                  .user!
                                  .activityIds
                                  .contains(activity.id)
                              ? "Leave"
                              : "Join",
                          press: () {
                            String uid = Provider.of<AuthProvider>(context,
                                    listen: false)
                                .user!
                                .uid;
                            if (!Provider.of<UserProvider>(context,
                                    listen: false)
                                .user!
                                .activityIds
                                .contains(activity.id)) {
                              UserService.addActivity(uid, activity.id);
                            } else {
                              UserService.removeActivity(uid, activity.id);
                            }
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookRating extends StatelessWidget {
  final int score;
  const BookRating({
    Key? key,
    required this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: Offset(3, 7),
            blurRadius: 20,
            color: Color(0xFD3D3D3).withOpacity(.5),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.person,
            color: kIconColor,
            size: 15,
          ),
          SizedBox(height: 5),
          Text(
            "$score",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
