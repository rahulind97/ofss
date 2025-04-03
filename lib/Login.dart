import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ofss/Constants/colors.dart';
import 'package:ofss/dashboardpage.dart';
import 'package:ofss/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

import 'Constants/Constant.dart';
import 'forgotPassword.dart';
import 'model/loginModel.dart';

class LoginPage extends StatefulWidget {
  LoginPage(this.title);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  GlobalKey<FormFieldState> _phnFieldKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _passwordFieldKey = GlobalKey<FormFieldState>();
  var _scaffoldStateKey = new GlobalKey<ScaffoldState>();
  TextEditingController mobilenocontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  bool showPassword = true;
  bool isloading = false;
  final RegExp phoneRegex = new RegExp(r'^[6-9]\d{9}$');

  _displaySnackBar(msg) {
    final snackBar = new SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black,
    );
    //_scaffoldStateKey.currentState.showSnackBar(snackBar);
    ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text(msg), duration: Duration(milliseconds: 300), backgroundColor: Colors.red, ), );
  }

  _displaySnackBarError(msg) {
    final snackBar = new SnackBar(
      content: Text(msg),
      backgroundColor: Color(0xffE11A29),
    );
   // _scaffoldStateKey.currentState.showSnackBar(snackBar);
    ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text(msg), duration: Duration(milliseconds: 300), backgroundColor: Color(0xffE11A29),), );
  }

  Future<bool> _showDialog() async {
    // flutter defined function
    return (await showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
              title: Text('Exit?'),
              content: new Text(
                "Do you want to exit the app?",
                style: TextStyle(color: Colors.grey),
              ),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new TextButton(
                  child: new Text("Cancel",style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new TextButton(
                  child: new Text("Exit",style: TextStyle(color: Colors.red),),
                  onPressed: () {
                    SystemChannels.platform
                        .invokeMethod<void>('SystemNavigator.pop');
                  },
                )
              ]);
        })) ??
        false;
  }

  @override
  void initState() {
    super.initState();

    // getVestionAlert();
  }
  Future<void> getVestionAlert() async {
    await Upgrader.clearSavedSettings();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _showDialog,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Color(0xff89000A),
          key: _scaffoldStateKey,
          body: new Stack(
            children: buildWidget(context),
          )
      ),
    );
  }

  List<Widget> buildWidget(BuildContext context) {
    var mainWidget = Center(
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children:
          <Widget>[
            Container(
                height: 120,
                width: 120,
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
              'ONLINE FACILITATION SYSTEM FOR\n  STUDENTS',
              style: TextStyle(
                  fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Bihar School Examination Board',
              style: TextStyle(
                  color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),

                  child: new Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text("INTERMIDIATE",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Poppins-Bold",
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff89000A))),
                          ),
                        ),
                        Divider(
                          color: Color(0xff89000A),
                          thickness: 2.5,
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.center,
                          child: Text("INTERMIDIATE STUDENT'S LOGIN",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Poppins-Bold",
                                  fontWeight: FontWeight.w400)),
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 15),
                          child: Text(
                              "अपना मोबाइल नंबर नीचे भरें जिसके माध्यम से आपने Application Form भरा है !",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.red[800])),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: TextFormField(
                            key: _phnFieldKey,
                            controller: mobilenocontroller,
                            keyboardType: TextInputType.phone,
                            cursorColor: Colors.grey,
                            decoration:  InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(6.0)),
                                borderSide:
                                BorderSide(width: 1, color: borderColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(6.0)),
                                borderSide:
                                BorderSide(width: 1, color: borderColor),
                              ),
                              suffixIcon: const Icon(Icons.phone,color: Colors.grey,),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                              isDense: true,
                              hintText: 'Enter Mobile Number',
                              hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                            inputFormatters: [
                              new FilteringTextInputFormatter.allow(
                                  new RegExp(r'^[0-9]*$'),),
                              new LengthLimitingTextInputFormatter(10)
                            ],
                            validator: (value) {
                              if (!phoneRegex.hasMatch(value!)) {
                                return 'Please enter valid phone number';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              "पासवर्ड यहाँ नीचे भरे",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.red[800]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                          child: Container(
                            child: TextFormField(
                              controller: passwordcontroller,
                              key: _passwordFieldKey,
                              obscureText: showPassword,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(6.0)),
                                  borderSide:
                                  BorderSide(width: 1, color: borderColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(6.0)),
                                  borderSide:
                                  BorderSide(width: 1, color: borderColor),
                                ),

                                suffixIcon: IconButton(
                                    icon: showPassword
                                        ? Icon(Icons.visibility,color: Colors.grey,)
                                        : Icon(Icons.visibility_off,color: Colors.grey),
                                    onPressed: () {
                                      setState(() {
                                        showPassword = !showPassword;
                                      });
                                    }),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 10),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 14.0,
                                    color: Colors.grey[400]),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (val) {
                                if (val!.isEmpty) return 'please enter the password';
                                return null;
                              },
                              onTap: () {
                                _phnFieldKey.currentState!.validate();
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width / 1.25,
                            child: ElevatedButton(
                              // textColor: Colors.white,
                              // color: Color(0xff89000A),
                              style: ElevatedButton.styleFrom(backgroundColor: Color(0xff89000A)),
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              onPressed: () async {
                                var connectivityResult =
                                await (Connectivity().checkConnectivity());
                                print(connectivityResult);
                                if (connectivityResult == ConnectivityResult.none) {
                                  _displaySnackBarError(
                                      "You are not connected to internet.Please connect to internet and try again");
                                } else {
                                  if (mobilenocontroller.text == '' ||
                                      mobilenocontroller.text == null) {
                                    print("mobile number");
                                    _displaySnackBar(
                                        "Mobile number cannot be left blank !!");
                                  } else if (passwordcontroller.text == '' ||
                                      passwordcontroller.text == null) {
                                    _displaySnackBar(
                                        "Password cannot be left blank !!");
                                  } else {
                                    loginserv();
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.redAccent,
                            ),
                            child: Text(
                              'Forgot Password ?',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.red[800],
                                  fontWeight: FontWeight.w400),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new ForgotPassword()));
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ));
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
                          color: Color(0xff89000a),
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

//This method is used for getting login information
  loginserv() {
    setState(() {
      isloading = true;
    });
    Login postdata = Login(
        mobileNumber: mobilenocontroller.text.toString(),
        password: passwordcontroller.text.toString(),
        type: "2");


    print("post Data "+postdata.password.toString());
    print("post Data "+postdata.password.toString());
    print("login req body ::::::::::::"+  " " +postdata.mobileNumber.toString()+"  "+postdata.password.toString());


    loginServ(postdata).then((value) {
      List result = json.decode(value.body);
      print(result);

      if (result[0]['status'] == '200') {
        if (result[0]['lstUser'] != '' &&
            result[0]['lstUser'] != null &&
            result[0]['lstUser'] != 'undefined') {
          print(1);
          if (result[0]['lstUser'].length > 0) {
            print("Data store");
            storeLoginData(
                result[0]['lstUser'][0]['Name'].toString(),
                result[0]['lstUser'][0]['applicantId'].toString(),
                result[0]['lstUser'][0]['cafNumber'].toString(),
                result[0]['lstUser'][0]['status'].toString(),
                result[0]['lstUser'][0]['strEmail'].toString(),
                result[0]['lstUser'][0]['username'].toString()
                );
          }
        }
      } else if (result[0]['status'] == '400') {
        setState(() {
          isloading = false;
        });
        _displaySnackBar(result[0]['msg']);
      }
    });
  }

//This method is used for storing login data
  Future<void> storeLoginData(String name, String applicantid, String cafNumber,
      String status, String strEmail, String username) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

    var jsonString1 = {
      "Name": name,
      "applicantId:": applicantid,
      "cafNumber": cafNumber,
      "status": status,
      "strEmail": strEmail,
      "username": username,
    };

    String jsonString = jsonEncode(jsonString1);
    prefs.setString('LoginData', jsonString);
    setState(() {
      isloading = false;
    });

    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new Dashboard()));
  }
}
