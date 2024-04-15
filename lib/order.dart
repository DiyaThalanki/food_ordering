import 'package:flutter/material.dart';
import 'package:food_ordering/final.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';




class OrderScreen extends StatefulWidget {
  final List<String> items;
  final List<Map<String, int>> quantities;
  final List<Map<String, int>> prices;
  Uint8List? bytes;

  OrderScreen({
    required this.items,
    required this.quantities,
    required this.prices,
  });

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
    List<String> cartItems = [];
    List<int> itemPrices = [];
    double totalPrice = 0;

    for (int i = 0; i < widget.items.length; i++) {
      widget.quantities[i].forEach((size, quantity) {
        if (quantity > 0) {
          int price = widget.prices[i][size]!;
          cartItems.add('${widget.items[i]} - $size: $quantity');
          itemPrices.add(price * quantity);
          totalPrice += price * quantity;
        }
      });
    }

    return Scaffold(
      backgroundColor: Color(0xFFDAC0A3),
      appBar: AppBar(
        title: Text('Place Order'),
          backgroundColor: Color(0xFFDAC0A3)
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Summary',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              // Container(
              //   decoration: BoxDecoration(
              //     color: Color(0xFFCF926D), // Set background color to yellow
              //     borderRadius: BorderRadius.circular(12.0), // Optionally add border radius
              //   ),
              //   child: Column(
              //     children: [
              //       SizedBox(
              //         height: 250, // Set a fixed height for the ListView.builder
              //         child: ListView.builder(
              //           itemCount: cartItems.length,
              //           itemBuilder: (context, index) {
              //             return ListTile(
              //               title: Text(cartItems[index]),
              //               trailing: Text('\₹${itemPrices[index].toStringAsFixed(2)}'),
              //             );
              //           },
              //         ),
              //       ),
              //       SizedBox(height: 16),
              //       Text(
              //         'Total Price: \₹${totalPrice.toStringAsFixed(2)}',
              //         style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              //       ),
              //     ],
              //   ),
              // ),
              bill(
                cartItems: cartItems,
                itemPrices: itemPrices,
                totalPrice: totalPrice,
              ),
              SizedBox(height: 16),
              Text(
                'Delivery Address:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                // Address text field
                decoration: InputDecoration(
                  hintText: 'Enter your address',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              Container(
                width: double.infinity, // Full width
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                // color: Colors.blue, // Background color of the button
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF6B240C), // Background color of the button
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderPlacedPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Order Now',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFDAC0A3)
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



}

Widget bill({required List<String> cartItems,required List<int> itemPrices,required double totalPrice})=>
  Container(
    decoration: BoxDecoration(
      color: Color(0xFFCF926D), // Set background color to yellow
      borderRadius: BorderRadius.circular(12.0), // Optionally add border radius
    ),
    child: Column(
      children: [
        SizedBox(
          height: 250, // Set a fixed height for the ListView.builder
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cartItems[index]),
                trailing: Text('\₹${itemPrices[index].toStringAsFixed(2)}'),
              );
            },
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Total Price: \₹${totalPrice.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );




