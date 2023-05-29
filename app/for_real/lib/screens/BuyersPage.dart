import 'package:flutter/material.dart';
import 'package:for_real/constants.dart';

class BuyersPage extends StatefulWidget {
  const BuyersPage({super.key, required this.userName});
  final String userName;
  @override
  State<BuyersPage> createState() => _BuyersPageState();
}

class _BuyersPageState extends State<BuyersPage> {
  TextEditingController idController = TextEditingController();

  String userName = "";
  @override
  void initState() {
    userName = widget.userName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = getHeight(context);
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
                "Check an item for validation:",
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: grey),
              ),
            ),
            Expanded(
                child: Material(
              borderRadius: BorderRadius.circular(16),
              elevation: 2,
              child: Container(),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextField(
                controller: idController,
                style: TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  labelText: 'Enter Unique Product ID',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),

                  // padding: EdgeInsets.symmetric(
                  //     horizontal: width * 0.21, vertical: 16),
                  side: BorderSide(color: blue),
                  backgroundColor: offWhite,
                ),
                onPressed: () {
                  Map payload = {
                    'productId': idController.text,
                  };
                  // send to products collection
                  print(payload);
                },
                child: Text('Validate this product!',
                    style: TextStyle(color: blue)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
