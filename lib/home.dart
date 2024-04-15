import 'package:flutter/material.dart';
import 'package:food_ordering/order.dart';
class FoodOrderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Order App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BuildContext? _storedContext;
  List<String> items = ['Munch', 'DairyMilk', 'KitKat','FiveStar','Perk'];
  List<String> pictures = ['assets/images/card.png', 'assets/images/diarymilk.jpg', 'assets/images/card2.jpg','assets/images/5star.jpg','assets/images/perk.jpg'];
  List<String> brands = ['Nestle', 'Cadbury', 'Nestle','Cadbury','Cadbury'];
  List<Map<String, int>> quantities = [
    {'10g-Regular': 0, '20g - Regular': 0, '20g - Max': 0, '110g - MaxBrownies': 0},
    {'10g-Regular': 0, '35g - Regular': 0, '110g - Regular': 0, '110g - Silk': 0},
    {'20g-Regular': 0, '20g-White Chocolate': 0},
    {'30g-Regular': 0, '30g-Caramel': 0},
    {'25g': 0, '40g': 0},
  ];
  List<Map<String, int>> prices = [
    {'10g-Regular': 10, '20g - Regular': 20, '20g - Max': 20, '110g - MaxBrownies': 25},
    {'10g-Regular': 10, '35g - Regular': 30, '110g - Regular': 80, '110g - Silk': 95},
    {'20g-Regular': 30, '20g-White Chocolate': 30},
    {'30g-Regular': 20, '30g-Caramel': 30},
    {'25g': 10, '40g': 20},
  ];
  // Prices for each item category
  int calculateTotalItemsInCart() {
    int totalItems = 0;
    for (var quantityMap in quantities) {
      for (var quantity in quantityMap.values) {
        totalItems += quantity;
      }
    }
    return totalItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDAC0A3),
      appBar: AppBar(
        backgroundColor: Color(0xFFDAC0A3), // Set app bar background color to match scaffold
        title: Text('Cacoa Bliss',style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 32,
        ),),
        actions: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(right: 20), // Add margin to the right of the container
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF6B240C), // Set background color of the circle
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(
                          items: items,
                          quantities: quantities,
                          prices: prices,
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.shopping_cart, color: Color(0xFFDAC0A3)), // Change icon color to 0xFFDAC0A3
                ),
              ),
              Positioned(
                right: 15, // Adjust the position of the circle
                top: 3, // Adjust the position of the circle
                child: CircleAvatar(
                  backgroundColor: Colors.black, // Set background color of circle to black
                  radius: 10, // Adjust the size of the circle
                  child: Text(
                    calculateTotalItemsInCart().toString(), // You can replace this with the actual count of items in the cart
                    style: TextStyle(
                      color: Color(0xFFDAC0A3),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

     body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(15.0),
                  child: Card(
                    elevation: 4,
                    color: Color(0xFFCF926D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left Section: Image
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                pictures[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 20), // Add some space between image and text
                          // Right Section: Text and Button
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height:10),
                                Text(
                                  items[index],
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  brands[index],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF6B240C)
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xFF6B240C), // Border color
                                      width: 1.0, // Border width
                                    ),
                                    borderRadius: BorderRadius.circular(5.0), // Optional: border radius
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center, // Changed to MainAxisAlignment.center
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            _decrementQuantity(context, index);
                                          },
                                          icon: Icon(Icons.remove),
                                        ),
                                        Text(
                                          '${_totalQuantity(quantities[index])}',
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            _showSizeSelectionDialog(context, index);
                                          },
                                          icon: Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // "Order Now" button
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
                      builder: (context) => OrderScreen(
                        items: items,
                        quantities: quantities,
                        prices: prices,
                      ),
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


    );
  }

  void _decrementQuantity(BuildContext context, int index) {
    List<String> sizes = quantities[index].keys.toList(); // Extract sizes for the given item
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Choose Size to Reduce'),
          backgroundColor: Color(0xFFDAC0A3),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                for (String size in sizes)
                  _buildSizeOptionForDecrement(size, index, dialogContext), // Pass dialogContext here
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSizeOptionForDecrement(String size, int index, BuildContext dialogContext) {
    int quantity = quantities[index][size]!;
    if (quantity > 0) {
      return ListTile(
        title: Text(size),
        onTap: () {
          setState(() {
            quantities[index][size] = quantity - 1; // Reduce quantity for the chosen size
          });
          Navigator.of(dialogContext).pop(); // Close the dialog
        },
      );
    } else {
      // If quantity is already zero, disable the option
      return ListTile(
        title: Text(
          size,
          style: TextStyle(color: Colors.grey), // Optionally style disabled option
        ),
      );
    }
  }

  int _totalQuantity(Map<String, int> sizeQuantities) {
    int total = 0;
    sizeQuantities.forEach((_, quantity) {
      total += quantity;
    });
    return total;
  }


  void _showSizeSelectionDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) { // Use dialogContext here
        return AlertDialog(
          title: Text('Select Size'),
          backgroundColor: Color(0xFFDAC0A3),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                for (String size in quantities[index].keys)
                  _buildSizeOption(size, index, dialogContext), // Pass dialogContext here
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSizeOption(String size, int index, BuildContext dialogContext) {
    int price = prices[index][size]!;
    return ListTile(
      title: Row(
        children: [
          Text(size),
          SizedBox(width: 10), // Add some spacing between size and price
          Text(
            '\₹$price',
            style: TextStyle(color: Color(0xFF6B240C)), // Optionally style the price
          ),
        ],
      ),
      onTap: () {
        if (mounted) {
          setState(() {
            quantities[index][size] = (quantities[index][size] ?? 0) + 1;
          });

          Navigator.of(dialogContext).pop(); // Use dialogContext here
        }
      },
    );
  }


}

class CartScreen extends StatelessWidget {
  final List<String> items;
  final List<Map<String, int>> quantities;
  final List<Map<String, int>> prices;

  CartScreen({
    required this.items,
    required this.quantities,
    required this.prices,
  });

  @override
  Widget build(BuildContext context) {
    List<String> cartItems = [];
    List<int> itemPrices = [];
    double totalPrice = 0;

    for (int i = 0; i < items.length; i++) {
      quantities[i].forEach((size, quantity) {
        if (quantity > 0) {
          int price = prices[i][size]!;
          cartItems.add('${items[i]} - $size: $quantity');
          itemPrices.add(price * quantity);
          totalPrice += price * quantity;
        }
      });
    }

    return Scaffold(
      backgroundColor: Color(0xFFDAC0A3),
      appBar: AppBar(
        title: Text('Cart'),
          backgroundColor: Color(0xFFDAC0A3)
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cartItems[index]),
            trailing: Text('\₹${itemPrices[index].toStringAsFixed(2)}'),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
          color: Color(0xFFDAC0A3),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Total Price: \₹${totalPrice.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}


