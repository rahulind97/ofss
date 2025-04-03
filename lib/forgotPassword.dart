import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ofss/Login.dart';

// import 'package:ofss/Login.dart';
import 'package:ofss/Otppage.dart';
import 'package:ofss/model/forgotModel.dart';
import 'package:ofss/services/services.dart';

import 'Constants/colors.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter FormBuilder Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        // brightness: Brightness.dark,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            gapPadding: 10,
          ),
        ),
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  final formKey = new GlobalKey<FormState>();
  var _scaffoldStateKey = new GlobalKey<ScaffoldState>();
  TextEditingController mobcontroller = new TextEditingController();
  bool isloading = false;

  void _submit() {
    final form = formKey.currentState;

    if (form!.validate()) {
      setState(() {
        form.save();
        isloading = true;
        ForgotPwd postdata =
        ForgotPwd(strCafNo: mobcontroller.text.toString(), strType: "2");//This method is used for forgot password
        print("req body forgetPassword?????"+postdata.strCafNo.toString()+","+"2");

        forgotPasswordServ(postdata).then((value) {
          List result = json.decode(value.body);
          setState(() {
            isloading = false;
          });
          print('##############');
          print("result"+result.toString());
          // print("OTP is >>>>>>>>>>>>>>>>>>"+result[0]['OTP']);
          if (result[0]['status'] == "200") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Otppage(
                      otp: result[0]['OTP'], cafno: result[0]['strCAFNo'],strOtpType:"vp",username: "",)
              ),
            );
          } else {
            if ((result[0]['status'] == "300")) {
              _displaySnackBarError(result[0]["msg"]);
            }
          }
        });
      });
    }
  }

  _displaySnackBarError(msg) {
    final snackBar = new SnackBar(
      content: Text(msg),
      backgroundColor: Color(0xffE11A29),
    );

  //  _scaffoldStateKey.currentState.showSnackBar(snackBar);
    ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text(msg), duration: Duration(milliseconds: 300),  backgroundColor: Color(0xffE11A29),), );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff89000A),
        key: _scaffoldStateKey,
        body: new Stack(
          children: buildWidget(context),
        ));
  }

  List<Widget> buildWidget(BuildContext context) {
    var mainWidget = Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/BSCB.png',
                    ),
                  ),
                  shape: BoxShape.rectangle,
                )),
            SizedBox(height: 25),
            Text(
              'ONLINE FACILITATION SYSTEM FOR \nSTUDENTS',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Bihar School Examination Board',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 4,
                surfaceTintColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                   // color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text("FORGOT PASSWORD",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Poppins-Bold",
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(height: 15),
                        Container(
                          child: Form(
                            key: formKey,
                            child: TextFormField(
                              controller: mobcontroller,
                              cursorColor: Colors.grey,
                              decoration:  InputDecoration(
                                hintText: 'Enter Barcode/Mobile Number',
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: borderColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(6.0)),
                                  borderSide:
                                  BorderSide(width: 1, color: borderColor),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Barcode/Mobile Number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        new Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width *0.8,
                          child: ElevatedButton(
                            // padding: const EdgeInsets.all(8.0),
                            // textColor: Colors.white,
                            // color: Colors.red[900],
                            style: ElevatedButton.styleFrom(backgroundColor: appBarColor),
                            onPressed: () {
                              forgotPasswordData();
                            },
                            child: Text('Generate OTP',
                                style: TextStyle(
                                    fontSize: 15,color: Colors.white,
                                    fontFamily: "Poppins-Bold",
                                    letterSpacing: .6)),
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              //textColor: Colors.redAccent,
                              child: Text(
                                'Back To Login',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: textColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => new LoginPage("Login Page")));
                              },
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    List<Widget> list = [];
    list.add(mainWidget);

    if (isloading) {
      var modal = new Stack(
        children: [
          new Opacity(
            opacity: 0.5,
            child: const ModalBarrier(dismissible: false, color: Colors.black),
          ),
          new Center(
              child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width / 1.6,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SpinKitCircle(
                          color: appBarColor,
                          size: 50.0,
                        ),
                        new Text(
                          'Loading...',
                          style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        )
                      ]))),
        ],
      );
      //        Future.delayed(Duration(seconds: 2));
      list.add(modal);
    }

    return list;
  }

  void forgotPasswordData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.none ||
        // ignore: unrelated_type_equality_checks
        connectivityResult == '' ||
        // ignore: unrelated_type_equality_checks
        connectivityResult == 'undefined') {
      _displaySnackBarError(
        "You are not connected to internet.Please connect to internet and try again",
      );
    } else {
      _submit();
      print(mobcontroller);
    }
  }
}
