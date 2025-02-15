import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key}); // Removed `const` because of `.obs` variables

  // The selected location (State management with GetX)
  var selectedLocation = "Dhaka".obs;

  // Complain numbers data
  final Map<String, String> complainNumbers = {
    "Dhaka": "01780803694",
    "Chittagong": "01609302952",
    "Sylhet": "01720298448",
  };

  // Product list
  var products = [
    {
      "name": "Egg",
      "price": "৳12 per piece",
      "image": "assets/images/egg.png",
      "description": "Fresh farm eggs, rich in protein."
    },
    {
      "name": "Mango",
      "price": "৳150 per kg",
      "image": "assets/images/mango.png",
      "description": "Juicy and sweet mangoes from the best farms."
    },
    {
      "name": "Milk",
      "price": "৳80 per liter",
      "image": "assets/images/milk.png",
      "description": "Fresh cow milk, rich in calcium."
    },
  ].obs; // Making it observable with GetX

  // Update selected location
  void updateLocation(String location) {
    selectedLocation.value = location;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Screen")),
      body: Column(
        children: [
          Obx(() => DropdownButton<String>(
            value: selectedLocation.value,
            onChanged: (newLocation) {
              if (newLocation != null) {
                updateLocation(newLocation);
              }
            },
            items: complainNumbers.keys
                .map<DropdownMenuItem<String>>((String location) {
              return DropdownMenuItem<String>(
                value: location,
                child: Text(location),
              );
            }).toList(),
          )),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: Image.asset(product["image"]!),
                  title: Text(product["name"]!),
                  subtitle: Text(product["price"]!),
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}
