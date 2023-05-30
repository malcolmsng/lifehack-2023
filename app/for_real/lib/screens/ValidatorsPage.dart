import 'package:flutter/material.dart';
import 'package:for_real/constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ValidatorsPage extends StatefulWidget {
  const ValidatorsPage({super.key});

  @override
  State<ValidatorsPage> createState() => _ValidatorsPageState();
}

class _ValidatorsPageState extends State<ValidatorsPage>
    with TickerProviderStateMixin {
  TextEditingController idController = TextEditingController();
  // late AnimationController animationController;
  bool isFirst = true;
  bool isMatching = false;
  // @override
  // void initState() {
  //   // userName = widget.userName;
  //   animationController =
  //       AnimationController(vsync: this, duration: Duration(seconds: 100));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    double height = getHeight(context);
    double width = getWidth(context);
    final Future<String> _calculation =
        Future<String>.delayed(const Duration(seconds: 5), () => 'Data Loaded');
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 48),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16.0,
              ),
              child: Text(
                "Validate An Item",
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: grey),
              ),
            ),
            Expanded(
                child: IgnorePointer(
              ignoring: isMatching,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isMatching = true;
                  });
                },
                child: Material(
                  borderRadius: BorderRadius.circular(16),
                  elevation: 2,
                  child: Container(
                      child: Center(
                    child: isMatching
                        ? MatchContainer()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LoadingAnimationWidget.beat(
                                color: cyan,
                                size: width * 0.3,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 24.0),
                                child:
                                    Text("Press here to validate a product!"),
                              )
                            ],
                          ),
                  )),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class MatchContainer extends StatefulWidget {
  const MatchContainer({super.key});

  @override
  State<MatchContainer> createState() => _MatchContainerState();
}

class _MatchContainerState extends State<MatchContainer> {
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );
  @override
  Widget build(BuildContext context) {
    double width = getWidth(context);
    return FutureBuilder(
        future: _calculation,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = [
              Text(
                "Airpods Pro Max",
                style: TextStyle(
                    color: blue, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text("560 USD"),
              Text("Reinold Loh"),
              Expanded(child: SizedBox()),
              Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),

                        // padding: EdgeInsets.symmetric(
                        //     horizontal: width * 0.21, vertical: 16),
                        side: BorderSide(color: blue),
                        backgroundColor: offWhite,
                      ),
                      onPressed: () {},
                      child: Text('Accept', style: TextStyle(color: blue)),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),

                        // padding: EdgeInsets.symmetric(
                        //     horizontal: width * 0.21, vertical: 16),
                        side: BorderSide(color: hotPink),
                        backgroundColor: offWhite,
                      ),
                      onPressed: () {},
                      child: Text('Decline', style: TextStyle(color: hotPink)),
                    ),
                  ],
                ),
              )
            ];
          } else {
            children = [
              LoadingAnimationWidget.inkDrop(
                color: hotPink,
                size: width * 0.3,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Text("Matching you with a seller"),
              )
            ];
          }
          return Column(
              mainAxisAlignment: MainAxisAlignment.center, children: children);
        });
  }
}
