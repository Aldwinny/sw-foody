import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/shared/colors.dart';
import 'package:foody_app/shared/items.dart';
import 'package:foody_app/utils/helper.dart';
import 'package:foody_app/widgets/appbar.dart';

import 'checkout_screen.dart';

class MyOrderScreen extends StatefulWidget {
  static const routeName = "/myOrderScreen";

  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  List<Map<String, dynamic>>? _items;
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final cartRef = FirebaseFirestore.instance.collection('cart');
      final newDocRef = cartRef.doc(user.uid).collection("cart_items");

      final findItem = newDocRef.get().then((value) {
        setState(() {
          _items = value.docs.map((doc) => doc.data()).toList();
        });
      });
    }
  }

  void updateCart() {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final cartRef = FirebaseFirestore.instance.collection('cart');
      final newDocRef = cartRef.doc(user.uid).collection("cart_items");

      // Delete all items in the collection
      final findItem = newDocRef.get().then((value) {
        value.docs.forEach((doc) {
          doc.reference.delete();
        });
      }).then((value) {
        _items!.forEach((element) {
          newDocRef.add(element);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_items == null) {
      return Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
                  child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            FoodyAppBar(label: "My Order"),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ))));
    }

    List<String> restaurants;
    cartItems = [];

    // Resolve missing information to cart items
    for (var element in _items!) {
      cartItems.add({
        ...items.where((e) => e['id'] == element['itemid']).first,
        ...element
      });
    }

    // Get all unique restaurants
    restaurants =
        cartItems.map<String>((e) => e['restaurant']).toSet().toList();

    // Create a card for each restaurant

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: _items!.isEmpty
                ? Column(children: const <Widget>[
                    FoodyAppBar(label: "My Order"),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                          "Your cart is empty. Add items by clicking add to cart button on the item of your choice.",
                          textAlign: TextAlign.center),
                    ),
                  ])
                : Column(
                    children: [
                      const FoodyAppBar(label: "My Order"),
                      ...restaurants.expand((e) {
                        // Get all items from each restaurant
                        List<Map<String, dynamic>> restaurantItems;

                        restaurantItems = cartItems
                            .where((element) => element['restaurant'] == e)
                            .toList();

                        // Build a widget from them
                        return [
                          RestaurantTitleCard(
                              bundle: restaurantItems.first['bundle'],
                              title: e,
                              restaurantType:
                                  restaurantItems.first['restaurant_type'],
                              rating: restaurantItems.first['rating'],
                              ratingCount:
                                  restaurantItems.first['rating_count'],
                              onTap: () {
                                setState(() {
                                  _items!.removeWhere((element) =>
                                      restaurantItems.any((re) =>
                                          re['id'] == element['itemid']));
                                  updateCart();
                                });
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: double.infinity,
                            color: AppColor.placeholderBg,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                children: restaurantItems
                                    .map((e) => BurgerCard(
                                        name: '${e['title']} - ${e['portion']}',
                                        quantity: e['quantity'],
                                        price: e['price'].toString()))
                                    .toList(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ];
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color:
                                        AppColor.placeholder.withOpacity(0.25),
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Delivery Instruction",
                                      style: Helper.getTheme(context).headline3,
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.add,
                                            color: AppColor.red,
                                          ),
                                          Text(
                                            "Add Notes",
                                            style: TextStyle(
                                              color: AppColor.red,
                                            ),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Sub Total",
                                    style: Helper.getTheme(context).headline3,
                                  ),
                                ),
                                Text(
                                  "PHP ${cartItems.fold<double>(0, (previousValue, element) => previousValue + element['price'])}",
                                  style: Helper.getTheme(context)
                                      .headline3!
                                      .copyWith(
                                        color: AppColor.red,
                                      ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Delivery Cost",
                                    style: Helper.getTheme(context).headline3,
                                  ),
                                ),
                                Text(
                                  "PHP 100",
                                  style: Helper.getTheme(context)
                                      .headline3!
                                      .copyWith(
                                        color: AppColor.red,
                                      ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: AppColor.placeholder.withOpacity(0.25),
                              thickness: 1.5,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Total",
                                    style: Helper.getTheme(context).headline3,
                                  ),
                                ),
                                Text(
                                  "PHP ${100 + cartItems.fold<double>(0, (previousValue, element) => previousValue + element['price'])}",
                                  style: Helper.getTheme(context)
                                      .headline3!
                                      .copyWith(
                                        color: AppColor.red,
                                        fontSize: 22,
                                      ),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      CheckoutScreen.routeName,
                                      arguments: _items);
                                },
                                child: const Text("Checkout"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class RestaurantTitleCard extends StatelessWidget {
  const RestaurantTitleCard(
      {Key? key,
      required this.bundle,
      required this.title,
      required this.restaurantType,
      required this.rating,
      required this.ratingCount,
      this.onTap})
      : super(key: key);

  final List<String> bundle;
  final String title;
  final String restaurantType;
  final double rating;
  final int ratingCount;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: 80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 80,
                width: 80,
                child: Image.asset(
                  Helper.getAssetName(bundle[1], bundle[0]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  title,
                  style: Helper.getTheme(context).headline3,
                ),
                Row(
                  children: [
                    Image.asset(
                      Helper.getAssetName(
                        "star_filled.png",
                        "virtual",
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        color: AppColor.red,
                      ),
                    ),
                    Text("($ratingCount ratings)"),
                  ],
                ),
                Row(
                  children: const [
                    Text("Burger"),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 5,
                      ),
                      child: Text(
                        ".",
                        style: TextStyle(
                          color: AppColor.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text("Western Food"),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 15,
                      child: Image.asset(
                        Helper.getAssetName(
                          "loc.png",
                          "virtual",
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text("Manila, Philippines")
                  ],
                )
              ],
            ),
            const SizedBox(
              width: 50,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: onTap,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Remove All Items',
                          style: TextStyle(color: AppColor.red)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BurgerCard extends StatelessWidget {
  const BurgerCard({
    super.key,
    required this.name,
    required this.price,
    required this.quantity,
    this.isLast = false,
  });

  final String name;
  final String price;
  final int quantity;
  final bool isLast;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : BorderSide(
                  color: AppColor.placeholder.withOpacity(0.25),
                ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "$name x$quantity",
              style: const TextStyle(
                color: AppColor.primary,
                fontSize: 16,
              ),
            ),
          ),
          Text(
            "PHP $price",
            style: const TextStyle(
              color: AppColor.primary,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          )
        ],
      ),
    );
  }
}
