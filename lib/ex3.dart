import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 🔹 Customized list of coupons with details
  final List<Map<String, dynamic>> coupons = const [
    {
      "title": "50% OFF on Electronics",
      "subtitle": "Valid till 30th Sep 2025",
      "details": ["Mobiles", "Laptops", "Headphones"],
      "color": Colors.orange
    },
    {
      "title": "Buy 1 Get 1 Free - Pizza",
      "subtitle": "Valid till 20th Sep 2025",
      "details": ["Margherita", "Farmhouse", "Pepperoni"],
      "color": Colors.green
    },
    {
      "title": "₹200 Cashback on Groceries",
      "subtitle": "Valid till 25th Sep 2025",
      "details": ["Rice", "Vegetables", "Milk"],
      "color": Colors.blue
    },
    {
      "title": "Flat 30% OFF on Fashion",
      "subtitle": "Valid till 15th Sep 2025",
      "details": ["Shirts", "Jeans", "Shoes"],
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

        // 🔹 Dynamic ListView with Dropdown + Popup
        body: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: coupons.length,
          itemBuilder: (context, index) {
            final coupon = coupons[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ExpansionTile(
                leading: CircleAvatar(
                  backgroundColor: coupon["color"],
                  child: const Icon(Icons.local_offer, color: Colors.white),
                ),
                title: Text(coupon["title"], style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(coupon["subtitle"]),
                children: [
                  // 🔹 Dropdown product list
                  ...coupon["details"].map<Widget>((item) {
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        // 🔹 Show popup when tapping product
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Selected Product"),
                            content: Text("You selected: $item\n\nFrom: ${coupon['title']}"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Close"),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),

                  // 🔹 Claim button at bottom
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ElevatedButton(
                      onPressed: () {
                        // 🔹 Popup for coupon claim
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Coupon Claimed!"),
                            content: Text("You claimed:\n${coupon['title']}"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: coupon["color"]),
                      child: const Text("Claim"),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
