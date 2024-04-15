import 'package:flutter/material.dart';
import 'package:food_ordering/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loading Screen Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace these with your desired text and image
    String loadingText = "Cacoa Bliss";
    String imagePath = "assets/images/chocolate.png";


    // Delay for 4 seconds before navigating to the home screen
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FoodOrderApp()),
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(loadingText,style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 32,
            ),),
            SizedBox(height: 20),
            Image.asset(imagePath),
          ],
        ),
      ),
      backgroundColor: Color(0xFFDAC0A3),
    );
  }
}


