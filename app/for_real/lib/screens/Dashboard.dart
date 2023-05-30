import 'package:flutter/material.dart';
import 'package:for_real/constants.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.userName});
  final String userName;
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String userName = "";
  @override
  void initState() {
    userName = widget.userName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
              ),
              child: Text(
                "Hello $userName!",
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: grey),
              ),
            ),
            Row(
              children: [
                Text(
                  "Take a look at recently validated transactions!",
                  textAlign: TextAlign.center,
                )
              ],
            ),
            Expanded(
              child: FutureBuilder(
                  future: Future<String>.delayed(
                    const Duration(seconds: 30),
                    () => 'Data Loaded',
                  ),
                  builder: (_, snapshot) {
                    List<Widget> children;
                    if (snapshot.hasData) {
                      children = [
                        DashTiles(
                          product: "Rolex Submariner",
                          date: DateTime(2023, 05, 29),
                          value: 10000,
                          validatedBy: "fHcU7Y",
                        ),
                        DashTiles(
                          product: "Airpods Pro Max",
                          date: DateTime(2023, 05, 29),
                          value: 560,
                          validatedBy: "fHcU7Y",
                        ),
                      ];
                    } else {
                      children = [
                        DashTiles(
                          product: "Rolex Submariner",
                          date: DateTime(2023, 05, 29),
                          value: 10000,
                          validatedBy: "fHcU7Y",
                        ),
                      ];
                    }
                    return ListView(
                      // padding: const EdgeInsets.all(8),

                      children: <Widget>[
                        DashTiles(
                          product: "Rolex Submariner",
                          date: DateTime(2023, 05, 29),
                          value: 10000,
                          validatedBy: "fHcU7Y",
                        ),
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class DashTiles extends StatelessWidget {
  DashTiles(
      {super.key,
      required this.product,
      required this.validatedBy,
      required this.date,
      required this.value});
  String product;
  String validatedBy;
  DateTime date;
  double value;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(),
      child: Opacity(
        opacity: 0.8,
        child: Material(
          borderRadius: BorderRadius.circular(8),
          elevation: 1.5,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product,
                        style:
                            TextStyle(color: cyan, fontWeight: FontWeight.w500),
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        "$value SGD",
                        style:
                            TextStyle(color: blue, fontWeight: FontWeight.w600),
                      )
                    ],
                  )),
                  Expanded(child: SizedBox()),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Validated by $validatedBy on ${date.day}/${date.month}/${date.year}",
                        style: TextStyle(
                            color: grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
