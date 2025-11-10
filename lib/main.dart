import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'database_helper.dart';
import 'product.dart';

void main() {
  // Initialize sqflite for web/desktop
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  } else {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(MaterialApp(home: ProductApp()));
}

class ProductApp extends StatefulWidget {
  const ProductApp({super.key});

  @override
  ProductAppState createState() => ProductAppState();
}

class ProductAppState extends State<ProductApp> {
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();

  final dbHelper = DatabaseHelper.instance;
  List<Product> products = [];
  double totalValue = 0;

  @override
  void initState() {
    super.initState();
    _refreshProducts();
  }

  void _refreshProducts() async {
    final data = await dbHelper.getProducts();
    double total = 0;
    for (var p in data) {
      total += p.quantity * p.price;
    }
    setState(() {
      products = data;
      totalValue = total;
    });
  }

  void _addProduct() async {
    if (_nameController.text.isEmpty ||
        _quantityController.text.isEmpty ||
        _priceController.text.isEmpty) {
      return;
    }

    final newProduct = Product(
      name: _nameController.text,
      quantity: int.parse(_quantityController.text),
      price: double.parse(_priceController.text),
    );

    await dbHelper.insertProduct(newProduct);
    _nameController.clear();
    _quantityController.clear();
    _priceController.clear();
    _refreshProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Inventory Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Product Name')),
            TextField(controller: _quantityController, decoration: const InputDecoration(labelText: 'Quantity'), keyboardType: TextInputType.number),
            TextField(controller: _priceController, decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _addProduct, child: const Text('Add Product')),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final p = products[index];
                  return Card(
                    color: p.quantity < 5 ? Colors.red[100] : null,
                    child: ListTile(
                      title: Text(p.name),
                      subtitle: Text('Qty: ${p.quantity} × ₹${p.price.toStringAsFixed(2)}'),
                      trailing: p.quantity < 5
                          ? const Text('Low Stock!', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))
                          : null,
                    ),
                  );
                },
              ),
            ),
            Text(
              'Total Stock Value: ₹${totalValue.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
