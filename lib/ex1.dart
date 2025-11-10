import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 🔹 Customized list of coupons
  final List<Map<String, dynamic>> coupons = const [
    {
      "title": "50% OFF on Electronics",
      "subtitle": "Valid till 30th Sep 2025",
      "color": Colors.orange
    },
    {
      "title": "Buy 1 Get 1 Free - Pizza",
      "subtitle": "Valid till 20th Sep 2025",
      "color": Colors.green
    },
    {
      "title": "₹200 Cashback on Groceries",
      "subtitle": "Valid till 25th Sep 2025",
      "color": Colors.blue
    },
    {
      "title": "Flat 30% OFF on Fashion",
      "subtitle": "Valid till 15th Sep 2025",
      "color": Colors.red
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Discount Coupons", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.purple,
        ),

        // 🔹 Customized ListView using builder
        body: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: coupons.length,
          itemBuilder: (context, index) {
            final coupon = coupons[index];
            return couponCard(
              coupon["title"],
              coupon["subtitle"],
              coupon["color"],
            );
          },
        ),
      ),
    );
  }

  // 🔹 Reusable coupon card widget
  static Widget couponCard(String title, String subtitle, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: const Icon(Icons.local_offer, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: color),
          child: const Text("Claim"),
        ),
      ),
    );
  }
}
