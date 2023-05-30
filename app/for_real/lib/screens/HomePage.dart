import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:for_real/constants.dart';
import 'package:for_real/screens/BuyersPage.dart';
import 'package:for_real/screens/Dashboard.dart';
import 'package:for_real/screens/LoginPage.dart';
import 'package:for_real/screens/SellersPage.dart';
import 'package:for_real/screens/Settings.dart';
import 'package:for_real/screens/ValidatorsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var navIndex = 0;
  TextEditingController reportController = TextEditingController();

  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    double height = getHeight(context);
    double width = getWidth(context);
    return Scaffold(
      bottomNavigationBar: FloatingNavbar(
        iconSize: 16,
        padding: EdgeInsets.symmetric(vertical: 4),
        margin: EdgeInsets.zero,
        backgroundColor: blue,
        onTap: (int val) {
          setState(() {
            navIndex = val;
            controller.animateToPage(val,
                duration: Duration(milliseconds: 300), curve: Curves.linear);
          });
        },
        currentIndex: navIndex,
        items: [
          FloatingNavbarItem(icon: Icons.home, title: 'Home'),
          FloatingNavbarItem(icon: Icons.wallet, title: 'Sellers'),
          FloatingNavbarItem(icon: Icons.search_rounded, title: 'Buyers'),
          FloatingNavbarItem(
              icon: Icons.done_all_outlined, title: 'Validators'),
        ],
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * .10),
        child: Padding(
          padding: EdgeInsets.only(top: 24),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.done_all,
                            size: 24,
                            color: offWhite,
                          ),
                        ),
                        TextSpan(
                            text: "fR",
                            style: TextStyle(
                                color: offWhite,
                                fontWeight: FontWeight.w700,
                                fontSize: 12))
                      ]),
                    ),
                    decoration: BoxDecoration(
                      color: blue,
                      shape: BoxShape.circle,
                    ),
                  )),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(fontSize: 14, color: cyan),
                  ),
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) => Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Container(
                              height: 120,
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Enter ID of user",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: blue),
                                  ),
                                  Expanded(
                                    child: SizedBox(),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: reportController,
                                          style: TextStyle(fontSize: 8),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            labelText: 'ID',
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 16),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),

                                          // padding: EdgeInsets.symmetric(
                                          //     horizontal: width * 0.21, vertical: 16),
                                          side: BorderSide(color: blue),
                                          backgroundColor: blue,
                                        ),
                                        onPressed: () {},
                                        child: Text('Report',
                                            style: TextStyle(color: offWhite)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )),
                  child: const Text(
                    'Report User',
                    style: TextStyle(fontSize: 14, color: blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: controller,
        children: [
          Dashboard(
            userName: "Malcolm",
          ),
          SellersPage(),
          BuyersPage(
            userName: "Malcolm",
          ),
          ValidatorsPage(),
        ],
      ),
    );
  }
}
