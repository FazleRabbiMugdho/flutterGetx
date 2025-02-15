import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'BuyerScreen.dart';
import 'SellerScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Buyerandseller extends StatefulWidget {
  const Buyerandseller({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<Buyerandseller> {
  String userRole = ''; // To store the user's role

  @override
  void initState() {
    super.initState();
    _fetchUserRole();
  }

  // Fetch the user role from Firestore based on the current user
  Future<void> _fetchUserRole() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var docSnapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (docSnapshot.exists) {
        setState(() {
          userRole = docSnapshot['role']; // Store the user role (Buyer, Seller, or Merchant)
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Dashboard'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Navigate back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.dashboard,
              size: 100.0,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to your Dashboard!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            // Conditional Buttons based on the user's role
            if (userRole == 'Buyer' || userRole == 'Merchant') // Show "Buy Product" for Buyer and Merchant
              ElevatedButton(
                onPressed: () {
                  Get.to(() => BuyerScreen()); // Navigate to Buy Product screen
                },
                child: const Text('Buy Product'),
              ),
            if (userRole == 'Seller' || userRole == 'Merchant') // Show "Sell Product" for Seller and Merchant
              ElevatedButton(
                onPressed: () {
                  Get.to(() => const SellerScreen()); // Navigate to Sell Product screen
                },
                child: const Text('Sell Product'),
              ),
          ],
        ),
      ),
    );
  }
}
