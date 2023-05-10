import 'package:flutter/material.dart';
import 'package:foody_app/screens/home/item_screen.dart';
import 'package:foody_app/screens/home/pages/home_page.dart';
import 'package:foody_app/shared/items.dart';
import 'package:foody_app/utils/helper.dart';
import 'package:foody_app/widgets/appbar.dart';

class AllItemsScreen extends StatefulWidget {
  static const routeName = "/allItemsScreen";

  const AllItemsScreen({super.key});

  @override
  State<AllItemsScreen> createState() => _AllItemsScreenState();
}

class _AllItemsScreenState extends State<AllItemsScreen> {
  late final List<Map<String, dynamic>> _itemSet;

  @override
  void initState() {
    super.initState();

    _itemSet = items;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    String? region = args?['region'];

    List<Map<String, dynamic>> displayItems = _itemSet;

    if (region != null) {
      displayItems =
          _itemSet.where((element) => element['region'] == region).toList();
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                FoodyAppBar(
                    label:
                        region == null ? "Foody Foods" : "Foods from $region"),
                ...displayItems.map<Widget>((e) {
                  return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(ItemScreen.routeName,
                            arguments: e['id']);
                      },
                      child: RecentItemCard(
                        name: e['title'],
                        rating: e['rating'],
                        ratingCount: e['rating_count'],
                        restaurantType: e['restaurant_type'],
                        image: Image.asset(
                          Helper.getAssetName(e['bundle'][1], e['bundle'][0]),
                          fit: BoxFit.cover,
                        ),
                      ));
                }).toList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
