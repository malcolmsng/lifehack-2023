import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:for_real/constants.dart';

class SellersPage extends StatefulWidget {
  const SellersPage({super.key});

  @override
  State<SellersPage> createState() => _SellersPageState();
}

class _SellersPageState extends State<SellersPage> {
  TextEditingController productController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  var productId = '';
  @override
  Widget build(BuildContext context) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    Future<void> addProducts(name, price, url) {
      return products.add({
        'name': name, // John Doe
        'price': price, // Stokes and Sons
        'url': url,
        'dateValidated': "", 'validator': '' // 42
      }).then((DocumentReference doc) {
        setState(() {
          productId = doc.id;
        });
      }).catchError((error) => print("Failed to add product: $error"));
    }

    double width = getWidth(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16.0,
              ),
              child: Text(
                "Request for a validator:",
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: productController,
                style: TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  labelText: 'Product Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: priceController,
                style: TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  labelText: 'Price',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: linkController,
                style: TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  labelText: 'Link to Product Listing',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.21, vertical: 16),
                  side: BorderSide(color: blue),
                  backgroundColor: offWhite,
                ),
                onPressed: () {
                  // Map payload = {
                  //   'product': productController.text,
                  //   'link': linkController.text,
                  //   'price': double.parse(priceController.text),
                  //   'isValidated': false
                  // };
                  // send to products collection
                  // generate unique id
                  addProducts(productController.text, priceController.text,
                      linkController.text);
                },
                child: Text('Validate this product!',
                    style: TextStyle(color: blue)),
              ),
            ),
            Expanded(child: SizedBox()),
            Opacity(
              opacity: productId == "" ? 0 : 1,
              child: Material(
                child: Container(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 48),
                  decoration: BoxDecoration(
                    color: blue,
                  ),
                  child: Text(
                    'Your unique product ID : $productId',
                    style: TextStyle(color: offWhite, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                elevation: 1.5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
