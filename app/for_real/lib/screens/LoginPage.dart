import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:for_real/constants.dart';
import 'package:for_real/screens/HomePage.dart';
import 'package:for_real/screens/RegisterPage.dart';
import 'package:go_router/go_router.dart';
import 'package:pkce/pkce.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

String generateAuthUrl(clientId, redirectUri, challenge) {
  return """https://api.id.gov.sg/v2/oauth/authorize?code_challenge_method=S256&response_type=code&client_id=$clientId&redirect_uri=$redirectUri&scope=openid%20myinfo.name&code_challenge=$challenge""";
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  dynamic pkce;
  Map creds = {};
  @override
  // ignore: must_call_super
  initState() {
    pkce = PkcePair.generate();
    creds = dotenv.env;
    print(creds.runtimeType);
  }

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
              "The decentralised validation service for your big ticket items! For REAL!",
              style: defaultStyle,
              textAlign: TextAlign.justify,
            ),
          ),
          Expanded(child: SizedBox()),
          Text("Login with SingPass",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          GestureDetector(
            onTap: () async {
              var auth_url = Uri.parse(
                generateAuthUrl(creds["CLIENT_ID"],
                    "http://localhost:5001/api/callback", pkce.codeChallenge),
              );
              context.go('/home');
              // await launchUrl(auth_url);
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                  border: Border.all(width: 6, color: blue),
                  borderRadius: BorderRadius.circular(16)),
              child: QrImageView(
                data: generateAuthUrl(
                    creds["CLIENT_ID"], "abc.com", pkce.codeChallenge),
                version: QrVersions.auto,
                size: width * 0.55,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.225,
              ),
              child: Text(
                "Want to improve our consumer experience? Sign up as a validator below!",
                style: defaultStyle,
                textAlign: TextAlign.justify,
              )),
          Expanded(flex: 4, child: SizedBox()),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: width * 0.175),
              side: BorderSide(color: Colors.transparent),
              backgroundColor: violet,
            ),
            onPressed: () {
              debugPrint('Received click');
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RegisterPage()));
            },
            child:
                Text('Become a Validator!', style: TextStyle(color: offWhite)),
          ),
          //
          SizedBox(
            height: 32,
          )
        ]),
      ),
    );
  }
}
