import 'package:flutter/material.dart';
import 'package:foody_app/shared/colors.dart';
import 'package:foody_app/widgets/appbar.dart';

const notificationsList = [
  {"title": "Your order has been picked up", "time": "Now"},
  {"title": "Your order has been delivered", "time": "1hr ago"},
  {"title": "Your order is on the way", "time": "3hr ago"},
  {"title": "Your order is being made..", "time": "5hr ago"},
];

class NotificationScreen extends StatelessWidget {
  static const routeName = "/notiScreen";

  const NotificationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            FoodyAppBar(label: "Notifications"),
            Flexible(
                fit: FlexFit.tight,
                child: NotiCardBuilder(builder: notificationsList))
          ],
        ),
      ),
    );
  }
}

class NotiCardBuilder extends StatelessWidget {
  const NotiCardBuilder({
    super.key,
    required this.builder,
  });

  final List<Map<String, String>> builder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: builder.length,
        itemBuilder: (context, index) {
          final item = builder[index];

          return NotiCard(
              time: item['time']!,
              title: item['title']!,
              color: index % 2 != 0 ? AppColor.placeholderBg : Colors.white);
        });
  }
}

class NotiCard extends StatelessWidget {
  const NotiCard({
    super.key,
    required this.time,
    required this.title,
    this.color = Colors.white,
  });

  final String time;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColor.primary,
                ),
              ),
              Text(time),
            ],
          )
        ],
      ),
    );
  }
}
