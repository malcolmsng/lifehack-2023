import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:for_real/constants.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    double height = getHeight(context);
    double width = getWidth(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * .10),
        child: Padding(
          padding: EdgeInsets.only(top: 24),
          child: Row(
            children: [
              Expanded(
                child: IconButton(
                  color: grey,
                  iconSize: 16,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.blueGrey,
                    size: 24,
                  ),
                  onPressed: () => {Navigator.of(context).pop()},
                ),
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
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("forReal.io",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700, color: blue)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.225,
            ),
            child: Text(
              "Be a part of a more secure and reliable consumer experience!",
              style: defaultStyle,
              textAlign: TextAlign.justify,
            ),
          ),
          Expanded(child: SizedBox()),
          Text("Login with SingPass",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
                border: Border.all(width: 6, color: violet),
                borderRadius: BorderRadius.circular(16)),
            child: QrImageView(
              data: '1234567890',
              version: QrVersions.auto,
              size: width * 0.55,
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.225,
              ),
              child: Text(
                "Swipe up to find out about how a validator works!",
                style: defaultStyle,
                textAlign: TextAlign.justify,
              )),
          Expanded(flex: 4, child: SizedBox()),
          GestureDetector(
              onVerticalDragEnd: (details) => {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(),
                    )
                  },
              child: Icon(
                Icons.keyboard_arrow_up_outlined,
                size: 40,
                color: grey,
              )),
          // child: Text("dasas")),
          SizedBox(
            height: 16,
          )
        ]),
      ),
    );
  }
}
