import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/shared/colors.dart';
import 'package:foody_app/shared/items.dart';
import 'package:foody_app/utils/helper.dart';
import 'package:foody_app/widgets/appbar.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key});

  static const routeName = "/individualItemScreen";

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  int qty = 1;
  String? selectedPortion;

  Future<bool> addToCart(int itemId, int qty, String portion, num price) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final cartRef = FirebaseFirestore.instance.collection("cart");
      final newDocRef = cartRef.doc(user.uid).collection("cart_items");

      final findItem = await newDocRef
          .where('itemid', isEqualTo: itemId)
          .where('portion', isEqualTo: portion)
          .get();

      if (findItem.size <= 0) {
        print('not found');
        await newDocRef.add({
          'itemid': itemId,
          'portion': portion,
          'quantity': qty,
          'price': price,
        });
      } else {
        print('found');
        await newDocRef.doc(findItem.docs.first.id).update({
          'quantity': qty,
          'price': price,
        });
      }

      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get arguments
    int? args =
        int.tryParse(ModalRoute.of(context)!.settings.arguments.toString());

    if (args == null) {
      Navigator.of(context).pop();
    }

    // Get item by index
    final representedItem =
        items.firstWhere((element) => element['id'] == args);

    final List<String> representedItemPortion = representedItem['portions'];

    selectedPortion =
        selectedPortion ?? representedItemPortion.map<String>((e) => e).first;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: Helper.getScreenHeight(context) * 0.5,
                      width: Helper.getScreenWidth(context),
                      child: Image.asset(
                        Helper.getAssetName(representedItem['bundle'][1],
                            representedItem['bundle'][0]),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: Helper.getScreenHeight(context) * 0.5,
                      width: Helper.getScreenWidth(context),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.0, 0.4],
                          colors: [
                            Colors.black.withOpacity(0.9),
                            Colors.black.withOpacity(0.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SafeArea(
                  child: Column(
                    children: [
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: FoodyAppBar(
                              label: "", useCart: true, inverted: true)),
                      SizedBox(
                        height: Helper.getScreenHeight(context) * 0.35,
                      ),
                      SizedBox(
                        height: 800,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Container(
                                height: 700,
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30),
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40),
                                    ),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        representedItem['title'],
                                        style:
                                            Helper.getTheme(context).headline5,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  ...getStarRating(
                                                      representedItem[
                                                          'rating']),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "${representedItem['rating']} Star Ratings",
                                                style: const TextStyle(
                                                  color: AppColor.red,
                                                  fontSize: 12,
                                                ),
                                              )
                                            ],
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "PHP ${representedItem['cost']}",
                                                  style: const TextStyle(
                                                    color: AppColor.primary,
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                const Text("/per Portion")
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        "Description",
                                        style: Helper.getTheme(context)
                                            .headline4!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child:
                                          Text(representedItem['description']),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Divider(
                                        color: AppColor.placeholder,
                                        thickness: 1.5,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        "Customize your Order",
                                        style: Helper.getTheme(context)
                                            .headline4!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Container(
                                        height: 50,
                                        width: double.infinity,
                                        padding: const EdgeInsets.only(
                                            left: 30, right: 10),
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          color: AppColor.placeholderBg,
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Row(
                                              children: [
                                                ...representedItemPortion.map<
                                                    Widget>((e) => Text(e)),
                                              ],
                                            ),
                                            value: selectedPortion,
                                            onChanged: (newPortion) {
                                              setState(() {
                                                selectedPortion = newPortion ??
                                                    selectedPortion;
                                              });
                                            },
                                            items: [
                                              ...representedItemPortion.map<
                                                      DropdownMenuItem<String>>(
                                                  (elem) {
                                                return DropdownMenuItem<String>(
                                                    value: elem.toString(),
                                                    child:
                                                        Text(elem.toString()));
                                              })
                                            ],
                                            icon: Image.asset(
                                              Helper.getAssetName(
                                                "dropdown.png",
                                                "virtual",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Number of Portions",
                                            style: Helper.getTheme(context)
                                                .headline4!
                                                .copyWith(
                                                  fontSize: 16,
                                                ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                      elevation:
                                                          MaterialStateProperty
                                                              .all(5.0)),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (qty - 1 > 0) {
                                                        qty = qty - 1;
                                                      }
                                                    });
                                                  },
                                                  child: const Text("-"),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  height: 35,
                                                  width: 55,
                                                  decoration:
                                                      const ShapeDecoration(
                                                    shape: StadiumBorder(
                                                      side: BorderSide(
                                                          color: AppColor.red),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        qty.toString(),
                                                        style: TextStyle(
                                                          color: AppColor.red,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                      elevation:
                                                          MaterialStateProperty
                                                              .all(5.0)),
                                                  onPressed: () {
                                                    setState(() {
                                                      qty = qty + 1;
                                                    });
                                                  },
                                                  child: const Text("+"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 200,
                                      width: double.infinity,
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 120,
                                            decoration: const ShapeDecoration(
                                              color: AppColor.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(40),
                                                  bottomRight:
                                                      Radius.circular(40),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20,
                                              ),
                                              child: Container(
                                                height: 160,
                                                width: double.infinity,
                                                margin: const EdgeInsets.only(
                                                  left: 50,
                                                  right: 40,
                                                ),
                                                decoration: ShapeDecoration(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(40),
                                                      bottomLeft:
                                                          Radius.circular(40),
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                  shadows: [
                                                    BoxShadow(
                                                      color: AppColor
                                                          .placeholder
                                                          .withOpacity(0.3),
                                                      offset:
                                                          const Offset(0, 5),
                                                      blurRadius: 5,
                                                    ),
                                                  ],
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "Total Price",
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      'PHP ${representedItem["cost"] * qty}',
                                                      style: TextStyle(
                                                        color: AppColor.primary,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    SizedBox(
                                                      width: 200,
                                                      child: ElevatedButton(
                                                          onPressed: () async {
                                                            if (await addToCart(
                                                                representedItem[
                                                                    'id'],
                                                                qty,
                                                                selectedPortion!,
                                                                representedItem[
                                                                        'cost'] *
                                                                    qty)) {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      ((BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      title: const Text(
                                                                          "Successfully added!"),
                                                                      content:
                                                                          SingleChildScrollView(
                                                                              child: ListBody(
                                                                        children: const <
                                                                            Widget>[
                                                                          Text(
                                                                              "The item has been successfully added!")
                                                                        ],
                                                                      )),
                                                                      actions: <
                                                                          Widget>[
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).popUntil((route) =>
                                                                                route.isFirst);
                                                                          },
                                                                          child:
                                                                              Text('OK'),
                                                                        )
                                                                      ],
                                                                    );
                                                                  }));
                                                            } else {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      ((BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      title: const Text(
                                                                          "Error"),
                                                                      content:
                                                                          SingleChildScrollView(
                                                                              child: ListBody(
                                                                        children: const <
                                                                            Widget>[
                                                                          Text(
                                                                              "Item was not added to cart!")
                                                                        ],
                                                                      )),
                                                                      actions: <
                                                                          Widget>[
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              Text('OK'),
                                                                        )
                                                                      ],
                                                                    );
                                                                  }));
                                                            }
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image.asset(
                                                                Helper.getAssetName(
                                                                    "add_to_cart.png",
                                                                    "virtual"),
                                                              ),
                                                              const Text(
                                                                "Add to Cart",
                                                              )
                                                            ],
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 20,
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                width: 60,
                                                height: 60,
                                                decoration: ShapeDecoration(
                                                  color: Colors.white,
                                                  shadows: [
                                                    BoxShadow(
                                                      color: AppColor
                                                          .placeholder
                                                          .withOpacity(0.3),
                                                      offset:
                                                          const Offset(0, 5),
                                                      blurRadius: 5,
                                                    ),
                                                  ],
                                                  shape: const CircleBorder(),
                                                ),
                                                child: Image.asset(
                                                  Helper.getAssetName(
                                                      "cart_filled.png",
                                                      "virtual"),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTriangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Offset controlpoint = Offset(size.width * 0, size.height * 0.5);
    Offset endpoint = Offset(size.width * 0.2, size.height * 0.85);
    Offset controlpoint2 = Offset(size.width * 0.33, size.height);
    Offset endpoint2 = Offset(size.width * 0.6, size.height * 0.9);
    Offset controlpoint3 = Offset(size.width * 1.4, size.height * 0.5);
    Offset endpoint3 = Offset(size.width * 0.6, size.height * 0.1);
    Offset controlpoint4 = Offset(size.width * 0.33, size.height * 0);
    Offset endpoint4 = Offset(size.width * 0.2, size.height * 0.15);

    Path path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.15)
      ..quadraticBezierTo(
        controlpoint.dx,
        controlpoint.dy,
        endpoint.dx,
        endpoint.dy,
      )
      ..quadraticBezierTo(
        controlpoint2.dx,
        controlpoint2.dy,
        endpoint2.dx,
        endpoint2.dy,
      )
      ..quadraticBezierTo(
        controlpoint3.dx,
        controlpoint3.dy,
        endpoint3.dx,
        endpoint3.dy,
      )
      ..quadraticBezierTo(
        controlpoint4.dx,
        controlpoint4.dy,
        endpoint4.dx,
        endpoint4.dy,
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

List<Widget> getStarRating(num rating) {
  List<Widget> stars = [];
  for (int i = 0; i < 5; i++) {
    if (rating >= 1.0) {
      stars.add(
        Image.asset(
          Helper.getAssetName("star_filled.png", "virtual"),
        ),
      );
      rating--;
    } else if (rating > 0) {
      stars.add(
        Image.asset(
          Helper.getAssetName("star_filled.png", "virtual"),
        ),
      );
      rating = 0;
    } else {
      stars.add(
        Image.asset(
          Helper.getAssetName("star.png", "virtual"),
        ),
      );
    }
  }
  return stars;
}
