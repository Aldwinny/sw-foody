import 'package:flutter/material.dart';
import 'package:foody_app/shared/colors.dart';
import 'package:foody_app/utils/helper.dart';
import 'package:foody_app/widgets/appbar.dart';

const inboxList = [
  {
    "title": "MealMonkey Promotions",
    "description":
        "Lorem Ipsum dolor sit amet,consectetur adipiscing elit, sed do eiusmod tempor.",
    "time": "6th July"
  },
  {
    "title": "MealMonkey Promotions",
    "description":
        "Lorem Ipsum dolor sit amet,consectetur adipiscing elit, sed do eiusmod tempor.",
    "time": "6th July"
  },
  {
    "title": "MealMonkey Promotions",
    "description":
        "Lorem Ipsum dolor sit amet,consectetur adipiscing elit, sed do eiusmod tempor.",
    "time": "6th July"
  },
  {
    "title": "MealMonkey Promotions",
    "description":
        "Lorem Ipsum dolor sit amet,consectetur adipiscing elit, sed do eiusmod tempor.",
    "time": "6th July"
  },
  {
    "title": "MealMonkey Promotions",
    "description":
        "Lorem Ipsum dolor sit amet,consectetur adipiscing elit, sed do eiusmod tempor.",
    "time": "6th July"
  },
  {
    "title": "MealMonkey Promotions",
    "description":
        "Lorem Ipsum dolor sit amet,consectetur adipiscing elit, sed do eiusmod tempor.",
    "time": "6th July"
  },
  {
    "title": "MealMonkey Promotions",
    "description":
        "Lorem Ipsum dolor sit amet,consectetur adipiscing elit, sed do eiusmod tempor.",
    "time": "6th July"
  },
  {
    "title": "MealMonkey Promotions",
    "description":
        "Lorem Ipsum dolor sit amet,consectetur adipiscing elit, sed do eiusmod tempor.",
    "time": "6th July"
  },
];

class InboxScreen extends StatelessWidget {
  static const routeName = "/inboxScreen";

  const InboxScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            FoodyAppBar(label: "Inbox"),
            Expanded(
              child: MailCardBuilder(builder: inboxList),
            )
          ],
        ),
      ),
    );
  }
}

class MailCardBuilder extends StatelessWidget {
  const MailCardBuilder({super.key, required this.builder});

  final List<Map<String, String>> builder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: builder.length,
      itemBuilder: (context, index) {
        final item = builder[index];

        return MailCard(
          title: item['title']!,
          description: item['description']!,
          time: item['time']!,
          color: index % 2 != 0 ? AppColor.placeholderBg : Colors.white,
        );
      },
    );
  }
}

class MailCard extends StatelessWidget {
  const MailCard({
    super.key,
    required this.time,
    required this.title,
    required this.description,
    this.color = Colors.white,
  });

  final String time;
  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: const Border(
          bottom: BorderSide(
            color: AppColor.placeholder,
            width: 0.5,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundColor: AppColor.red,
            radius: 5,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColor.primary,
                  ),
                ),
                const SizedBox(height: 5),
                Text(description),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
