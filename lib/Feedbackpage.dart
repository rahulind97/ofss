import 'dart:convert';
import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ofss/dashboardpage.dart';
import 'package:ofss/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/feedbackModel.dart';

class Feedbackpage extends StatefulWidget {
  @override
  _Feedbackstate createState() => _Feedbackstate();
}

class _Feedbackstate extends State<Feedbackpage> {
  @override
  void initState() {
    super.initState();
    getlogindata();
  }

  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _registration = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  GlobalKey<FormFieldState> _registrationFieldKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _emailFieldKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _phnFieldKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _descriptionFieldKey = GlobalKey<FormFieldState>();
  final RegExp emailRegex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  final RegExp phoneRegex = new RegExp(r'^[6-9]\d{9}$');

  var _scaffoldStateKey = new GlobalKey<ScaffoldState>();
  void _submit() {

    final form = formKey.currentState;
    if (form!.validate()) {
      setState(() {
        form.save();
        feedbackModel postdata = feedbackModel(
            userName: _registration.text,
            userMobile: _phone.text,
            userEmail: _email.text,
            description: _description.text);

    //   showprogressBar();

        feedbackServ(postdata).then((value) {
          Map result = json.decode(value.body);
        Navigator.pop(context);
          print('@@@@@@@@@@@');
          print(result);
          //      Navigator.pop(context);
          if (result['feedbackResult'] != null) {
            // showDialog(
            //     context: context,
            //     builder: (context) {
            //       return AlertDialog(
            //         content: Container(
            //           height: 60,
            //           child: Center(
            //             child: Text(
            //               result["feedbackResult"],
            //               style: TextStyle(color: Colors.green,
            //                   fontSize: 20.0),
            //             ),
            //           ),
            //         ),
            //       );
            //     });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(result["feedbackResult"]),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );


            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
            );
          } else if (result['feedbackResult'] == null) {
            // showDialog(
            //   context: context,
            //   builder: (context) {
            //     return AlertDialog(
            //       content: Container(
            //         height: 60,
            //         child: Center(
            //           child: Text(
            //             "error",
            //             //                    result["error"],
            //             style: TextStyle(color: Colors.red, fontSize: 20.0),
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(result["error"]),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
              ),
            );
          }
        });
      });
    }
  }

//This method is used for submitting the feedback
  feedbackserv() async {
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
    }
  }

  showprogressBar() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: Container(
            // height: 40.0,
            // margin: EdgeInsets.all(8.0),
            child: new Row(
              // mainAxisSize: MainAxisSize.min,
              children: [
                new CircularProgressIndicator(),
                SizedBox(
                  width: 35.0,
                ),
                new Text("Please wait...", style: TextStyle(fontSize: 20.0)),
              ],
            ),
          ),
        );
      },
    );
  }
  static void progressbar(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,

      builder: (BuildContext context) {
        return WillPopScope(
          child:SpinKitDoubleBounce(

            color: Colors.red,
            size: 50.0,
          ),
          onWillPop: () async => false,
        );
      },
    );
  }

  _displaySnackBarError(msg) {
    final snackBar = new SnackBar(
      content: Text(msg),
      backgroundColor: Color(0xffE11A29),
    );

   // _scaffoldStateKey.currentState.showSnackBar(snackBar);
    ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text(msg), duration: Duration(milliseconds: 300),backgroundColor: Color(0xffE11A29), ), );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldStateKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Feedback',
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
                image: DecorationImage(
              image: new AssetImage(
                'assets/bg.jpg',
              ),
              fit: BoxFit.cover,
            )),
            child: BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Column(children: <Widget>[
                  SizedBox(height: 80),
                  Padding(
                      padding: EdgeInsets.only(left: 30, right: 30, top: 50),
                      child: Text(
                        'Please give your feedback to improve our application for your better use',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 23,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(height: 20),
                  Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 1.15,
                          child: TextFormField(
                            controller: _registration,
                            key: _registrationFieldKey,
                            keyboardType: TextInputType.text,
                            onSaved: (String? val) {},
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 20),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(6.0)),
                                borderSide:
                                    BorderSide(width: 0, color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 0, color: Colors.white),
                              ),
                              hintText: "Enter your registration number",
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.grey[400]),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your registration number';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.15,
                          child: TextFormField(
                            controller: _phone,
                            key: _phnFieldKey,
                            keyboardType: TextInputType.phone,
                            onSaved: (String? val) {},
                            onTap: () {
                              _registrationFieldKey.currentState!.validate();
                            },
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 20),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(6.0)),
                                borderSide:
                                    BorderSide(width: 0, color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 0, color: Colors.white),
                              ),
                              hintText: "Enter your Mobile number",
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.grey[400]),
                            ),
                            inputFormatters: [
                              new FilteringTextInputFormatter.allow(
                                  new RegExp(r'^[0-9]*$')),
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
                        Container(
                          width: MediaQuery.of(context).size.width / 1.15,
                          child: TextFormField(
                            controller: _email,
                            key: _emailFieldKey,
                            onTap: () {
                              _registrationFieldKey.currentState!.validate();
                              _phnFieldKey.currentState!.validate();
                            },
                            onSaved: (String? val) {},
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 20),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(6.0)),
                                borderSide:
                                    BorderSide(width: 0, color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 0, color: Colors.white),
                              ),
                              hintText: "Enter Your Email",
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.grey[400]),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (!emailRegex.hasMatch(value!)) {
                                return 'Please enter valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.15,
                          child: TextFormField(
                            controller: _description,
                            key: _descriptionFieldKey,
                            onTap: () {
                              _registrationFieldKey.currentState!.validate();
                              _phnFieldKey.currentState!.validate();
                              _emailFieldKey.currentState!.validate();
                            },
                            keyboardType: TextInputType.text,
                            onSaved: (String? val) {},
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 20),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(6.0)),
                                borderSide:
                                    BorderSide(width: 0, color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 0, color: Colors.white),
                              ),
                              hintText: "Enter Description",
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.grey[400]),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Description';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        new Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width / 1.15,
                          child: ElevatedButton(
                            // padding: const EdgeInsets.all(8.0),
                            // textColor: Colors.white,
                            // color: Colors.red[900],
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red[900]),
                            onPressed: () {
                              feedbackserv();
                            },
                            child: new Text("Submit",style: TextStyle(color: Colors.white),),
                          ),
                        )
                      ],
                    ),
                  ),
                ]))),
      ),
    );
  }

  getlogindata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Map logindata = json.decode(prefs!.getString('LoginData').toString());
      _registration.text = logindata['cafNumber'];
      _email.text = logindata['strEmail'];
      _phone.text = logindata['username'];
    });
  }
}
