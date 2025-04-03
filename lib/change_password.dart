import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:ofss/services/services.dart';

import 'Constants/Constant.dart';
import 'Constants/colors.dart';
import 'Login.dart';
import 'model/changePasswordModel.dart';


class ChangePasswordPage extends StatefulWidget {
  String otp;
  String cafNo;
   ChangePasswordPage(this.otp,this.cafNo);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  GlobalKey<FormFieldState> _passwordFieldKey = GlobalKey<FormFieldState>();
  final formKey = new GlobalKey<FormState>();
  final passwordcontroller = TextEditingController();
  final passwordcontroller1 = TextEditingController();
  final passwordcontroller2 = TextEditingController();
  bool isloading = false;
  bool showPassword = true;
  bool showPassword1 = true;
  bool showPassword2 = true;

  @override
  void initState() {
    super.initState();
    // print("otp is############### "+widget.otp);
    // print("caf no is############### "+widget.cafNo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff89000A),
        //  key: _scaffoldStateKey,
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text("CHANGE PASSWORD",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Poppins-Bold",
                                  fontWeight: FontWeight.w500)),
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Container(
                            child: TextFormField(
                              controller: passwordcontroller1,
                              // key: _passwordFieldKey,
                              obscureText: showPassword1,
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
                                    icon: showPassword1
                                        ? Icon(Icons.visibility,color: Colors.grey,)
                                        : Icon(Icons.visibility_off,color: Colors.grey,),
                                    onPressed: () {
                                      setState(() {
                                        showPassword1 = !showPassword1;
                                      });
                                    }),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 10),
                                hintText: 'New Password',
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 14.0,
                                    color: Colors.grey[400]),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (val) {
                                if (val!.isEmpty)
                                  return 'please enter the password';
                                if (val.length < 8) {
                                  return 'Must be 8 charater';
                                }
                                return null;
                              },

                              onTap: () {
                                // _phnFieldKey.currentState!.validate();
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Container(
                            child: TextFormField(
                              controller: passwordcontroller2,
                              // key: _passwordFieldKey,
                              obscureText: showPassword2,
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
                                    icon: showPassword2
                                        ? Icon(Icons.visibility,color: Colors.grey,)
                                        : Icon(Icons.visibility_off,color: Colors.grey,),
                                    onPressed: () {
                                      setState(() {
                                        showPassword2 = !showPassword2;
                                      });
                                    }),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 10),
                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 14.0,
                                    color: Colors.grey[400]),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (val) {
                                if (val!.isEmpty)
                                  return 'please enter the password';
                                if (val.length < 8) {
                                  return 'Must be 8 charater';
                                }
                                return null;
                              },
                              onTap: () {
                                // _phnFieldKey.currentState!.validate();
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        new Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width / 1.12,
                          child: ElevatedButton(
                            // padding: const EdgeInsets.all(8.0),
                            // textColor: Colors.white,
                            // color: Colors.red[900],
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[900]),
                            onPressed: () {
                              changePasswordData();
                              /*  Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) => LoginPage("Login Page")));*/
                            },
                            child: Text('Submit',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Poppins-Bold",
                                    letterSpacing: .6,color: Colors.white)),
                          ),
                        ),
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

    /*if (isloading) {
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
                          color: Colors.red,
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
    }*/

    return list;
  }

  void changePasswordData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
  //  print(connectivityResult);
    if (connectivityResult == ConnectivityResult.none ||
        // ignore: unrelated_type_equality_checks
        connectivityResult == '' ||
        // ignore: unrelated_type_equality_checks
        connectivityResult == 'undefined') {
      _displaySnackBarError(
        "You are not connected to internet.Please connect to internet and try again",
      );
    } else {
     // print('Go to submit button validation');
      changePasswordDataInternetCheck();
    }
  }

  _displaySnackBarError(msg) {
    final snackBar = new SnackBar(
      content: Text(msg),
      backgroundColor: Color(0xffE11A29),
    );

    //  _scaffoldStateKey.currentState.showSnackBar(snackBar);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(milliseconds: 300),
        backgroundColor: Color(0xffE11A29),
      ),
    );
  }

  void changePasswordDataInternetCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
   // print(connectivityResult);
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

  void _submit() {
    if (passwordcontroller1.text == "") {
      Constants.instance
          .displayToastmessage(context, "Please enter your new password !!");
    } else if (passwordcontroller1.text.trim().length < 8) {
      Constants.instance.displayToastmessage(
          context, "New password must have minimum 8 characters. ");
    } else if (passwordcontroller2.text == "") {
      Constants.instance.displayToastmessage(
          context, "Please enter your confirm password !!");
    } else if (passwordcontroller2.text.trim().length < 8) {
      Constants.instance.displayToastmessage(
          context, "Confirm password must have minimum 8 characters. ");
    } else if (passwordcontroller1.text != passwordcontroller2.text) {
      Constants.instance.displayToastmessage(
          context, " New Password and Confirm Password must be equal.");
    }/* else if (!Constants().isValidPassword(passwordcontroller.text.trim())) {
      Constants.instance.displayToastmessage(
          context, "Invalid Password, Please enter valid password.");
    } */else
     // print("call change pswd api method");
      chngPassword();
  }
  chngPassword() {
   // print("enterinto  change pswd api method");
    ChangePasswordResponseModel postData = ChangePasswordResponseModel(
        strCafNo: widget.cafNo,
        strType: "2",
        strOtp: widget.otp,
        strPassword: passwordcontroller2.text
    );
    getChangePassword(postData).then((value) {
      List result = json.decode(value.body);
     // print('result ##############********' );
     //  print(result);
     //  print(result[0]['status']);
     //  print('result status##############********');
      if (result[0]['status'].toString() == "200") {
        //print('Password changed successfully');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) =>
                LoginPage("Login Page")));
      }
    });
  }
}
