import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/main.dart';
import 'package:foody_app/screens/home/all_items_screen.dart';
import 'package:foody_app/screens/home/item_screen.dart';
import 'package:foody_app/shared/colors.dart';
import 'package:foody_app/shared/items.dart';
import 'package:foody_app/utils/helper.dart';
import 'package:foody_app/widgets/appbar.dart';
import 'package:foody_app/widgets/foody_searchbar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List<Map<String, dynamic>> itemSet;
  late final List<String> countries;
  late final List<Map<String, dynamic>> famous3;
  late final List<Map<String, dynamic>> randomRecommends;

  @override
  void initState() {
    itemSet = items;

    // Get region list for later
    countries = items.map<String>((e) => e['region']).toSet().toList();

    // Get top 3
    var famous3temp = List<Map<String, dynamic>>.from(items);
    famous3temp.sort((a, b) => b["rating"].compareTo(a['rating']));
    famous3 = famous3temp.sublist(0, 3);

    // Get random items
    List<Map<String, dynamic>> randomTemp = [];

    while (randomTemp.length < 5) {
      int randomIndex = Random().nextInt(items.length);
      if (!randomTemp.contains(items[randomIndex])) {
        randomTemp.add(items[randomIndex]);
      }
    }

    randomRecommends = randomTemp;

    print(countries);
    // Get list of countries

    // Store them
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context, listen: false).user ??
        FirebaseAuth.instance.currentUser;
    final hour = DateFormat('H').format(DateTime.now()).toString();
    final intHour = int.parse(hour);
    final String greeting;

    if (intHour >= 6 && intHour < 12) {
      greeting = 'Good morning';
    } else if (intHour >= 12 && intHour < 18) {
      greeting = 'Good afternoon';
    } else {
      greeting = 'Good evening';
    }

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: FoodyAppBar(
                  label: '$greeting, ${user?.displayName ?? "User"}!',
                  useCart: true,
                  useBackButton: false),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text("Deilivering to"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: DropdownButtonHideUnderline(
                child: SizedBox(
                  width: 250,
                  child: DropdownButton(
                    value: "current location",
                    items: const [
                      DropdownMenuItem(
                        value: "current location",
                        child: Text("Current Location"),
                      ),
                    ],
                    icon: Image.asset(
                      Helper.getAssetName("dropdown_filled.png", "virtual"),
                    ),
                    style: Helper.getTheme(context).headline4,
                    onChanged: (_) {},
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const FoodySearchBar(
              title: "Search Food",
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...countries.map<Widget>((e) {
                      Map<String, dynamic> regionItem = itemSet
                          .firstWhere((element) => element['region'] == e);

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              AllItemsScreen.routeName,
                              arguments: {"region": regionItem["region"]});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: CategoryCard(
                              image: Image.asset(
                                  Helper.getAssetName(regionItem['bundle'][1],
                                      regionItem['bundle'][0]),
                                  fit: BoxFit.cover),
                              name: regionItem['region']),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Restaurants",
                    style: Helper.getTheme(context).headline5,
                  ),
                  TextButton(onPressed: () {}, child: const Text("View all"))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            RestaurantCard(
              image: Image.asset(
                Helper.getAssetName("pizza2.jpg", "real"),
                fit: BoxFit.cover,
              ),
              name: "Da Vinci Pizza",
            ),
            RestaurantCard(
              image: Image.asset(
                Helper.getAssetName("breakfast.jpg", "real"),
                fit: BoxFit.cover,
              ),
              name: "Kapihan ni Aling Amihan",
            ),
            RestaurantCard(
              image: Image.asset(
                Helper.getAssetName("bakery.jpg", "real"),
                fit: BoxFit.cover,
              ),
              name: "Tinapay ni Tella",
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Most Popular",
                    style: Helper.getTheme(context).headline5,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("View all"),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 250,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    MostPopularCard(
                      image: Image.asset(
                        Helper.getAssetName("pizza4.jpg", "real"),
                        fit: BoxFit.cover,
                      ),
                      name: "Kapihan sa Bambang",
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    MostPopularCard(
                      name: "Burger ni Aling Bella",
                      image: Image.asset(
                        Helper.getAssetName("dessert3.jpg", "real"),
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Random finds",
                    style: Helper.getTheme(context).headline5,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AllItemsScreen.routeName);
                    },
                    child: const Text("View all"),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  ...randomRecommends.map<Widget>((e) {
                    return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(ItemScreen.routeName,
                              arguments: e['id']);
                        },
                        child: RecentItemCard(
                            name: e['title'],
                            rating: e['rating'],
                            region: e['region'],
                            ratingCount: e['rating_count'],
                            restaurantType: e['restaurant_type'],
                            image: Image.asset(
                                Helper.getAssetName(
                                    e['bundle'][1], e['bundle'][0]),
                                fit: BoxFit.cover)));
                  }).toList(),
                  const SizedBox(height: 75)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RecentItemCard extends StatelessWidget {
  const RecentItemCard({
    super.key,
    required this.name,
    required this.image,
    required this.restaurantType,
    required this.region,
    required this.rating,
    required this.ratingCount,
  });

  final String name;
  final String restaurantType;
  final String region;
  final int ratingCount;
  final double rating;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 80,
              height: 80,
              child: image,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Helper.getTheme(context)
                      .headline4!
                      .copyWith(color: AppColor.primary),
                ),
                Row(
                  children: [
                    Text(restaurantType),
                    const SizedBox(
                      width: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        ".",
                        style: TextStyle(
                          color: AppColor.red,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(region),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      Helper.getAssetName("star_filled.png", "virtual"),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "$rating",
                      style: const TextStyle(
                        color: AppColor.red,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text('($ratingCount) Ratings')
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MostPopularCard extends StatelessWidget {
  const MostPopularCard({
    super.key,
    required this.name,
    required this.image,
  });

  final String name;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 300,
            height: 200,
            child: image,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: Helper.getTheme(context)
              .headline4!
              .copyWith(color: AppColor.primary),
        ),
        Row(
          children: [
            const Text("fine dining"),
            const SizedBox(
              width: 5,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Text(
                ".",
                style: TextStyle(
                  color: AppColor.red,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text("Manila"),
            const SizedBox(
              width: 20,
            ),
            Image.asset(
              Helper.getAssetName("star_filled.png", "virtual"),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "4.9",
              style: TextStyle(
                color: AppColor.red,
              ),
            )
          ],
        )
      ],
    );
  }
}

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    super.key,
    required this.name,
    required this.image,
  });

  final String name;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 200, width: double.infinity, child: image),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: Helper.getTheme(context).headline3,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Image.asset(
                      Helper.getAssetName("star_filled.png", "virtual"),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "4.9",
                      style: TextStyle(
                        color: AppColor.red,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text("(124 ratings)"),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text("fine dining"),
                    const SizedBox(
                      width: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        ".",
                        style: TextStyle(
                          color: AppColor.red,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text("Manila"),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.image,
    required this.name,
  });

  final String name;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 100,
            height: 100,
            child: image,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: Helper.getTheme(context)
              .headline4!
              .copyWith(color: AppColor.primary, fontSize: 16),
        ),
      ],
    );
  }
}
