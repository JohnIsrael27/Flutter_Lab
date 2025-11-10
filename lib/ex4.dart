import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CouponPage(),
    );
  }
}

/// ----------------------
///  Stateful Widget Page
/// ----------------------
class CouponPage extends StatefulWidget {
  const CouponPage({super.key});

  @override
  State<CouponPage> createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _promoController = TextEditingController();

  // coupons list stays here so state can be updated later if needed
  final List<Map<String, dynamic>> coupons = [
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
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  void _submitPromo() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Promo Code Applied: ${_promoController.text}")),
      );
      _promoController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Discount Coupons", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          // -----------------------------
          //   Promo Form Section
          // -----------------------------
          Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: _promoController,
                decoration: InputDecoration(
                  labelText: "Enter Promo Code",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: _submitPromo,
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter a code" : null,
              ),
            ),
          ),

          // -----------------------------
          //  Coupons List Section
          // -----------------------------
          Expanded(
            child: ListView.builder(
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
                    title: Text(coupon["title"],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(coupon["subtitle"]),
                    children: [
                      // Each item -> tap for popup
                      ...coupon["details"].map<Widget>((item) {
                        return ListTile(
                          title: Text(item),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Selected Product"),
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

                      // Claim button
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: coupon["color"]),
                          onPressed: () {
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
                          child: const Text("Claim"),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
