import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:for_real/constants.dart';
import 'package:for_real/screens/BuyersPage.dart';
import 'package:for_real/screens/Dashboard.dart';
import 'package:for_real/screens/LoginPage.dart';
import 'package:for_real/screens/SellersPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var navIndex = 0;
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
          FloatingNavbarItem(icon: Icons.settings, title: 'Settings'),
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
                child: SizedBox(),
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
        ],
      ),
    );
  }
}
