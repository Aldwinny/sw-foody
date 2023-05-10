import 'package:flutter/material.dart';
import 'package:foody_app/shared/colors.dart';
import 'package:foody_app/utils/helper.dart';
import 'package:foody_app/widgets/appbar.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 70),
          child: Column(
            children: [
              const FoodyAppBar(
                label: "Latest Offers",
                useCart: true,
                useBackButton: false,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Find discounts, Offer special",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: Helper.getScreenWidth(context) * 0.4,
                          child: ElevatedButton(
                              onPressed: () {},
                              child: const Text("Check Offers")),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              OfferCard(
                image: Image.asset(
                  Helper.getAssetName("breakfast.jpg", "real"),
                  fit: BoxFit.cover,
                ),
                name: "Cafe de Noires",
              ),
              OfferCard(
                image: Image.asset(
                  Helper.getAssetName("western2.jpg", "real"),
                  fit: BoxFit.cover,
                ),
                name: "Isso",
              ),
              OfferCard(
                image: Image.asset(
                  Helper.getAssetName("coffee3.jpg", "real"),
                  fit: BoxFit.cover,
                ),
                name: "Cafe Beans",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  const OfferCard({
    super.key,
    required this.name,
    required this.image,
  });

  final String name;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 200, width: double.infinity, child: image),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Text(
                  name,
                  style: Helper.getTheme(context)
                      .headline4!
                      .copyWith(color: AppColor.primary),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
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
                const Text("(124 ratings) Cafe"),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  "·",
                  style: TextStyle(
                      color: AppColor.red, fontWeight: FontWeight.bold),
                ),
                const Text(" Manila · 20% OFF"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
