import 'package:flutter/material.dart';
import 'package:for_real/constants.dart';
import 'package:lottie/lottie.dart';

class BuyersPage extends StatefulWidget {
  const BuyersPage({super.key, required this.userName});
  final String userName;
  @override
  State<BuyersPage> createState() => _BuyersPageState();
}

class _BuyersPageState extends State<BuyersPage> with TickerProviderStateMixin {
  TextEditingController idController = TextEditingController();

  late AnimationController animationController;
  String userName = "";
  @override
  void initState() {
    userName = widget.userName;
    idController.text = 'BcBEJi9DrdDMm3YT3qYU';
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 100));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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
              child: Container(
                  child:
                      CheckContainer(animationController: animationController)),
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
                  animationController
                    ..duration = Duration(seconds: 10)
                    ..forward();

                  print(payload);
                  //add product tile
                },
                child: Text('Find product!', style: TextStyle(color: blue)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckContainer extends StatefulWidget {
  CheckContainer({super.key, required this.animationController});
  AnimationController animationController;
  @override
  State<CheckContainer> createState() => _CheckContainerState();
}

class _CheckContainerState extends State<CheckContainer> {
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 6),
    () => 'Data Loaded',
  );
  @override
  Widget build(BuildContext context) {
    double width = getWidth(context);
    return FutureBuilder(
        future: _calculation,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Widget child;
          if (snapshot.hasData) {
            child = Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.green,
                    size: width * .5,
                  ),
                  Text("Rolex Submariner"),
                  Text("Seller: Reinold Loh"),
                  Text("Validated By: fHcU7Y"),
                  Text("Price: 10000")
                ],
              ),
            );
          } else if (snapshot.hasError) {
            child = Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.do_disturb_alt_outlined,
                    color: hotPink,
                    size: width * .5,
                  ),
                  Text("Cannot find product ID ")
                ],
              ),
            );
          } else {
            child = Lottie.asset(
              "assets/lottie/searching.json",
            );
          }
          return child;
        });
  }
}
