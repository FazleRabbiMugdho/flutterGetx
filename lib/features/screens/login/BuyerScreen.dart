import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BuyerScreen extends StatelessWidget {
  const BuyerScreen({super.key});

  // Fetching products from Firestore
  Future<List<Map<String, dynamic>>> _fetchProducts() async {
    var snapshot = await FirebaseFirestore.instance.collection('products').get();
    List<Map<String, dynamic>> products = [];
    for (var doc in snapshot.docs) {
      products.add(doc.data());
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Product'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Navigate back to the previous screen
          },
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products available'));
          }

          // Display the list of products
          List<Map<String, dynamic>> products = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                var product = products[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    title: Text(product['name']),
                    subtitle: Text('Price: \$${product['price']}'),
                    leading: Icon(Icons.shopping_bag),
                    onTap: () {
                      // Navigate to a detailed view where buyers can initiate purchase
                      Get.to(() => PurchaseScreen(product: product));
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class PurchaseScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  const PurchaseScreen({super.key, required this.product});

  @override
  _PurchaseScreenState createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  int quantity = 1;
  String location = '';

  Future<void> _purchaseProduct(BuildContext context) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Get.snackbar('Error', 'Please log in to proceed with the purchase');
      return;
    }

    // Calculate the total price
    double totalPrice = widget.product['price'] * quantity;

    // Create a new transaction in Firestore
    var transactionRef = FirebaseFirestore.instance.collection('transactions').doc();
    await transactionRef.set({
      'buyerId': user.uid,
      'sellerId': widget.product['sellerId'],
      'productId': widget.product['productId'],
      'productName': widget.product['name'],
      'productPrice': widget.product['price'],
      'quantity': quantity,
      'totalPrice': totalPrice,
      'location': location,
      'status': 'pending', // Status of the transaction (can be updated later)
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    Get.snackbar('Purchase Successful', 'You have successfully purchased ${widget.product['name']}');
    Get.back(); // Navigate back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Purchase ${widget.product['name']}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.product['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Price: \$${widget.product['price']}'),
            const SizedBox(height: 16),
            // Quantity Input Field
            Row(
              children: [
                const Text('Quantity:'),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                ),
                Text('$quantity'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Location Input Field
            TextField(
              decoration: const InputDecoration(labelText: 'Enter your location'),
              onChanged: (value) {
                setState(() {
                  location = value;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _purchaseProduct(context),
              child: const Text('Purchase Now'),
            ),
          ],
        ),
      ),
    );
  }
}
