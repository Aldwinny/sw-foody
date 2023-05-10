import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/shared/colors.dart';
import 'package:foody_app/widgets/appbar.dart';

class TransactionHistoryScreen extends StatefulWidget {
  static const routeName = "/transactScreen";

  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  List<Map<String, dynamic>>? _transactions;

  @override
  void initState() {
    super.initState();
    print("init state");

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final transactionRef =
          FirebaseFirestore.instance.collection("transactions");
      final docRef =
          transactionRef.doc(user.uid).collection("transaction_items");

      docRef.get().then((value) {
        setState(() {
          print("Setting state");
          _transactions = value.docs
              .map((doc) => {"id": int.parse(doc.id), ...doc.data()})
              .toList();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_transactions == null) {
      return Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
                  child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            FoodyAppBar(label: "Transaction History"),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ))));
    }

    List<Map<String, dynamic>> fullTransaction = _transactions!
        .map((e) => {
              'date': DateTime.fromMillisecondsSinceEpoch(e["id"])
                  .toIso8601String()
                  .split("T")[0],
              ...e
            })
        .toList();

    print(_transactions!
        .map((e) => {
              'date': DateTime.fromMillisecondsSinceEpoch(e["id"])
                  .toIso8601String()
                  .split("T")[0],
              ...e
            })
        .toList());

    // Remove potentially unwanted transactions
    fullTransaction.removeWhere((e) => e['total'] == 0);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const FoodyAppBar(label: "Transaction History"),
            Flexible(
                fit: FlexFit.tight,
                child: fullTransaction.isEmpty
                    ? const Center(
                        child: Text(
                            "This is where your recent transctions will be recorded.",
                            textAlign: TextAlign.center),
                      )
                    : TransactionCardBuilder(builder: fullTransaction))
          ],
        ),
      ),
    );
  }
}

class TransactionCardBuilder extends StatelessWidget {
  const TransactionCardBuilder({
    super.key,
    required this.builder,
  });

  final List<Map<String, dynamic>> builder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: builder.length,
        itemBuilder: (context, index) {
          final item = builder[index];

          return TransactionCard(
              id: item['id'].toString(),
              time: item['date']!,
              title:
                  'Purchased ${item["quantities"].fold(0, (prev, now) => prev + now)} item(s) worth PHP ${item["total"]}',
              color: index % 2 != 0 ? AppColor.placeholderBg : Colors.white);
        });
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.id,
    required this.time,
    required this.title,
    this.color = Colors.white,
  });

  final String id;
  final String time;
  final String title;
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Transaction ID: $id'),
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
