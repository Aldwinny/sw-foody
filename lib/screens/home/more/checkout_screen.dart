import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/screens/home/home_screen.dart';
import 'package:foody_app/screens/home/more/change_address_screen.dart';
import 'package:foody_app/shared/colors.dart';
import 'package:foody_app/utils/helper.dart';
import 'package:foody_app/widgets/foody_text_input.dart';

class CheckoutScreen extends StatefulWidget {
  static const routeName = "/checkoutScreen";

  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<Map<String, dynamic>>? _items;
  String? method = "cod";

  @override
  Widget build(BuildContext context) {
    _items = ModalRoute.of(context)!.settings.arguments
        as List<Map<String, dynamic>>?;

    print(_items);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Checkout",
                    style: Helper.getTheme(context).headline5,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Delivery Address"),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Helper.getScreenWidth(context) * 0.4,
                    child: Text(
                      "Barangka, Marikina, Philippines",
                      style: Helper.getTheme(context).headline3,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(ChangeAddressScreen.routeName);
                    },
                    child: const Text(
                      "Change",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 10,
              width: double.infinity,
              color: AppColor.placeholderBg,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Payment method"),
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          isScrollControlled: true,
                          isDismissible: false,
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: Helper.getScreenHeight(context) * 0.8,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 30),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            icon: const Icon(
                                              Icons.clear,
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Add Credit/Debit Card",
                                              style: Helper.getTheme(context)
                                                  .headline3,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Divider(
                                          color: AppColor.placeholder
                                              .withOpacity(0.5),
                                          thickness: 1.5,
                                          height: 40,
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: FoodyTextInput(
                                            hintText: "card Number"),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text("Expiry"),
                                            SizedBox(
                                              height: 50,
                                              width: 100,
                                              child: FoodyTextInput(
                                                hintText: "MM",
                                                padding:
                                                    EdgeInsets.only(left: 35),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 50,
                                              width: 100,
                                              child: FoodyTextInput(
                                                hintText: "YY",
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: FoodyTextInput(
                                            hintText: "Security Code"),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: FoodyTextInput(
                                            hintText: "First Name"),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: FoodyTextInput(
                                            hintText: "Last Name"),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: Helper.getScreenWidth(
                                                      context) *
                                                  0.4,
                                              child: const Text(
                                                  "You can remove this card at anytime"),
                                            ),
                                            Switch(
                                              value: false,
                                              onChanged: (_) {},
                                              thumbColor:
                                                  MaterialStateProperty.all(
                                                AppColor.secondary,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: SizedBox(
                                          height: 50,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(
                                                    Icons.add,
                                                  ),
                                                  SizedBox(width: 40),
                                                  Text("Add Card"),
                                                  SizedBox(width: 40),
                                                ],
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.add),
                        Text(
                          "Add Card",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            PaymentCard(
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Cash on delivery"),
                  Radio<String>(
                    groupValue: method,
                    activeColor: AppColor.red,
                    value: "cod",
                    onChanged: (val) {
                      setState(() {
                        method = val;
                      });
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            PaymentCard(
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Image.asset(
                          Helper.getAssetName(
                            "visa2.png",
                            "real",
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("**** **** **** 2187"),
                    ],
                  ),
                  Radio<String>(
                    groupValue: method,
                    activeColor: AppColor.red,
                    value: "visa",
                    onChanged: (val) {
                      setState(() {
                        method = val;
                      });
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            PaymentCard(
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 40,
                        height: 30,
                        child: Image.asset(
                          Helper.getAssetName(
                            "paypal.png",
                            "real",
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("johndoe@email.com"),
                    ],
                  ),
                  Radio<String>(
                    groupValue: method,
                    activeColor: AppColor.red,
                    value: "paypal",
                    onChanged: (val) {
                      setState(() {
                        method = val;
                      });
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 10,
              width: double.infinity,
              color: AppColor.placeholderBg,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Sub Total"),
                      Text(
                        "PHP ${_items?.fold<double>(0, (previousValue, element) => previousValue + element['price']) ?? 0}",
                        style: Helper.getTheme(context).headline3,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Delivery Cost"),
                      Text(
                        "PHP 100",
                        style: Helper.getTheme(context).headline3,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 40,
                    color: AppColor.placeholder.withOpacity(0.25),
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total"),
                      Text(
                        "PHP ${_items != null ? 100 + _items!.fold<double>(0, (previousValue, element) => previousValue + element['price']) : 100}",
                        style: Helper.getTheme(context).headline3,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Container(
              height: 10,
              width: double.infinity,
              color: AppColor.placeholderBg,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        isScrollControlled: true,
                        isDismissible: false,
                        context: context,
                        builder: (context) {
                          final user = FirebaseAuth.instance.currentUser;

                          if (user != null) {
                            final transactionRef = FirebaseFirestore.instance
                                .collection('transactions');
                            final docRef = transactionRef
                                .doc(user.uid)
                                .collection("transaction_items");

                            final addItem = docRef
                                .doc(DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString())
                                .set({
                              "items": _items?.map((e) => e["itemid"]) ?? [],
                              "quantities":
                                  _items?.map((e) => e["quantity"]) ?? [],
                              "portions":
                                  _items?.map((e) => e["quantity"]) ?? [],
                              "method": method,
                              "total": _items?.fold<double>(
                                      0,
                                      (previousValue, element) =>
                                          previousValue + element['price']) ??
                                  0
                            }).then((value) {
                              final cartRef =
                                  FirebaseFirestore.instance.collection('cart');
                              final newDocRef = cartRef
                                  .doc(user.uid)
                                  .collection("cart_items");

                              newDocRef.get().then((value) {
                                value.docs.forEach((doc) {
                                  doc.reference.delete();
                                });
                              });
                            });
                          }

                          return SizedBox(
                            height: Helper.getScreenHeight(context) * 0.8,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          icon: const Icon(Icons.clear),
                                        ),
                                      ],
                                    ),
                                    Image.asset(
                                      Helper.getAssetName(
                                        "vector4.png",
                                        "virtual",
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Thank You!",
                                      style: TextStyle(
                                        color: AppColor.primary,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 30,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "for your order",
                                      style: Helper.getTheme(context)
                                          .headline4!
                                          .copyWith(color: AppColor.primary),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Text(
                                          "Your order is now being processed. We will let you know once the order is picked from the outlet. Check the status of your order"),
                                    ),
                                    const SizedBox(
                                      height: 60,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: SizedBox(
                                        height: 50,
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).popUntil(
                                                (route) => route.isFirst);
                                          },
                                          child: const Text(
                                            "Back To Home",
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: const Text("Send Order"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
    required this.widget,
  });

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.only(
            left: 30,
            right: 20,
          ),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: AppColor.placeholder.withOpacity(0.25),
              ),
            ),
            color: AppColor.placeholderBg,
          ),
          child: widget),
    );
  }
}
