import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 🔹 Customized list of coupons
  final List<Map<String, dynamic>> coupons = const [
    {
      "title": "50% OFF on Electronics",
      "subtitle": "Valid till 30th Sep 2025",
      "color": Colors.orange,
      "details": ["Laptops", "Mobiles", "Headphones"]
    },
    {
      "title": "Buy 1 Get 1 Free - Pizza",
      "subtitle": "Valid till 20th Sep 2025",
      "color": Colors.green,
      "details": ["Veg Pizza", "Cheese Pizza", "Paneer Pizza"]
    },
    {
      "title": "₹200 Cashback on Groceries",
      "subtitle": "Valid till 25th Sep 2025",
      "color": Colors.blue,
      "details": ["Rice", "Vegetables", "Cooking Oil"]
    },
    {
      "title": "Flat 30% OFF on Fashion",
      "subtitle": "Valid till 15th Sep 2025",
      "color": Colors.red,
      "details": ["Shirts", "Jeans", "Shoes"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Discount Coupons",
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.purple,
        ),

        // 🔹 ListView with ExpansionTile for dropdown
        body: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: coupons.length,
          itemBuilder: (context, index) {
            final coupon = coupons[index];
            return couponCard(
              coupon["title"],
              coupon["subtitle"],
              coupon["color"],
              List<String>.from(coupon["details"]),
            );
          },
        ),
      ),
    );
  }

  // 🔹 Reusable coupon card with dropdown
  static Widget couponCard(
      String title, String subtitle, Color color, List<String> details) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: const Icon(Icons.local_offer, color: Colors.white),
        ),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(subtitle),

        // 🔽 Dropdown content
        children: [
          ListView.builder(
            shrinkWrap: true, // Needed inside ExpansionTile
            physics: const NeverScrollableScrollPhysics(),
            itemCount: details.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: const Icon(Icons.check, color: Colors.black54),
                title: Text(details[i]),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: color),
              child: const Text("Claim"),
            ),
          )
        ],
      ),
    );
  }
}
