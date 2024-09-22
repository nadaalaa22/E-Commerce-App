import 'package:e_commerce_app/core/app_theme.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int _counter = 1;
  num _totalPrice = 0.0;
  final num productPrice = 3500; // Example price of the product

  void _incrementCounter() {
    setState(() {
      _counter++;
      _totalPrice = _counter * productPrice; // Update total price
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 1) {
        _counter--;
        _totalPrice = _counter * productPrice; // Update total price
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _totalPrice = productPrice; // Set initial total price
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(color: primaryColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Icon(
            Icons.shopping_cart,
            color: primaryColor,
            size: 25,
          ),
          const SizedBox(
            width: 30,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/images/shoose.png",
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nike Air Jordan', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 4),
                      Text('Orange | size 40',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // Add delete functionality here
                  },
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('EGP ${productPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16)),
                Container(
                  height: screenHeight * 0.05,
                  decoration: BoxDecoration(
                    color: const Color(0xff035696),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _decrementCounter,
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          size: 20,
                        ),
                        color: Colors.white,
                      ),
                      Text(
                        '$_counter',
                        style: TextStyle(
                            fontSize: screenWidth * 0.035, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: _incrementCounter,
                        icon: const Icon(
                          Icons.add_circle_outline,
                          size: 20,
                        ),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: screenHeight * 0.05,
              decoration: BoxDecoration(
                color: const Color(0xff035696),
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Check Out     ',
                    style: TextStyle(
                        fontSize: screenWidth * 0.035, color: Colors.white),
                  ),
                  const Icon(
                    Icons.arrow_right_alt,
                    size: 20,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
