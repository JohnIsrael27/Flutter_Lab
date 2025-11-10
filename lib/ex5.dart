import 'package:flutter/material.dart';

void main() {
  runApp(ExpenseManagerApp());
}

class ExpenseManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InputScreen(),
    );
  }
}

class ExpenseData {
  final double income;
  final double rent;
  final double food;
  final double transport;
  final double others;

  ExpenseData({
    required this.income,
    required this.rent,
    required this.food,
    required this.transport,
    required this.others,
  });

  double get remainingBalance => income - (rent + food + transport + others);
}

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _incomeController = TextEditingController();
  final _rentController = TextEditingController();
  final _foodController = TextEditingController();
  final _transportController = TextEditingController();
  final _othersController = TextEditingController();

  @override
  void dispose() {
    _incomeController.dispose();
    _rentController.dispose();
    _foodController.dispose();
    _transportController.dispose();
    _othersController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final data = ExpenseData(
        income: double.parse(_incomeController.text),
        rent: double.parse(_rentController.text),
        food: double.parse(_foodController.text),
        transport: double.parse(_transportController.text),
        others: double.parse(_othersController.text),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultScreen(data: data)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _incomeController,
                decoration: InputDecoration(labelText: 'Monthly Income'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter monthly income';
                  }
                  final num = double.tryParse(value);
                  if (num == null || num <= 0) {
                    return 'Income must be a positive number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _rentController,
                decoration: InputDecoration(labelText: 'Rent/EMI'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter rent/EMI';
                  }
                  final num = double.tryParse(value);
                  if (num == null || num < 0) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _foodController,
                decoration: InputDecoration(labelText: 'Food Expenses'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter food expenses';
                  }
                  final num = double.tryParse(value);
                  if (num == null || num < 0) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _transportController,
                decoration: InputDecoration(labelText: 'Transport Expenses'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter transport expenses';
                  }
                  final num = double.tryParse(value);
                  if (num == null || num < 0) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _othersController,
                decoration: InputDecoration(labelText: 'Other Expenses'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter other expenses';
                  }
                  final num = double.tryParse(value);
                  if (num == null || num < 0) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Calculate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final ExpenseData data;

  ResultScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    final balance = data.remainingBalance;
    final isNegative = balance < 0;
    final color = isNegative ? Colors.red : Colors.green;
    final message = isNegative ? 'You are overspending!' : 'Great job managing your expenses!';

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Monthly Income: \$${data.income.toStringAsFixed(2)}'),
            Text('Rent/EMI: \$${data.rent.toStringAsFixed(2)}'),
            Text('Food Expenses: \$${data.food.toStringAsFixed(2)}'),
            Text('Transport Expenses: \$${data.transport.toStringAsFixed(2)}'),
            Text('Other Expenses: \$${data.others.toStringAsFixed(2)}'),
            SizedBox(height: 20),
            Text(
              'Remaining Balance: \$${balance.toStringAsFixed(2)}',
              style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              message,
              style: TextStyle(color: color, fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
