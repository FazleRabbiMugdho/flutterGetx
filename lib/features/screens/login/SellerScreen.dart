import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SellerScreen extends StatefulWidget {
  const SellerScreen({super.key});

  @override
  _SellerScreenState createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController buyerIdController = TextEditingController();
  final TextEditingController productController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  // Simulate seller's unique ID (this can be fetched from Firebase)
  final String sellerUniqueId = 'SELLER_12345';

  // Function to save transaction details to Firebase
  Future<void> saveTransaction() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Create a new document in the 'transactions' collection
        await FirebaseFirestore.instance.collection('transactions').add({
          'buyerId': buyerIdController.text.trim(),
          'product': productController.text.trim(),
          'quantity': int.parse(quantityController.text.trim()),
          'price': double.parse(priceController.text.trim()),
          'location': locationController.text.trim(),
          'sellerId': sellerUniqueId,
          'totalAmount': int.parse(quantityController.text.trim()) * double.parse(priceController.text.trim()),
          'status': 'pending', // default status
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });

        // Clear the fields after saving
        buyerIdController.clear();
        productController.clear();
        quantityController.clear();
        priceController.clear();
        locationController.clear();

        // Show success message
        Get.snackbar('Transaction Saved', 'The transaction has been saved to Firebase.',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
      } catch (e) {
        Get.snackbar('Error', 'Failed to save transaction: $e',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell Product'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(
                  Icons.storefront,
                  size: 100.0,
                  color: Colors.orange,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Add and manage your products',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Form for adding product details
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Buyer ID Field
                      TextFormField(
                        controller: buyerIdController,
                        decoration: const InputDecoration(
                          labelText: 'Buyer ID',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter Buyer ID' : null,
                      ),
                      const SizedBox(height: 20),

                      // Product Field
                      TextFormField(
                        controller: productController,
                        decoration: const InputDecoration(
                          labelText: 'Product',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.shopping_bag),
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter the product name' : null,
                      ),
                      const SizedBox(height: 20),

                      // Quantity Field
                      TextFormField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Quantity',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.confirmation_number),
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter quantity' : null,
                      ),
                      const SizedBox(height: 20),

                      // Price Field
                      TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.attach_money),
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter price' : null,
                      ),
                      const SizedBox(height: 20),

                      // Location Field
                      TextFormField(
                        controller: locationController,
                        decoration: const InputDecoration(
                          labelText: 'Location',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.location_on),
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter location' : null,
                      ),
                      const SizedBox(height: 40),

                      // Submit Button
                      ElevatedButton(
                        onPressed: saveTransaction,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text('Save Transaction'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
