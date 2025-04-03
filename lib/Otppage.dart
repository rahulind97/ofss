import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:ofss/services/services.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'change_password.dart';
import 'dashboardpage.dart';
import 'model/applyForSlideUpModel.dart';
import 'model/forgotModel.dart';
import 'model/otpModel.dart';
import 'model/resendOtpModel.dart';

class Otppage extends StatefulWidget {
  final String otp, cafno, strOtpType, username;

  Otppage(
      {required this.otp,
      required this.cafno,
      required this.strOtpType,
      required this.username});

  @override
  _Otppagestate createState() => _Otppagestate();
}

class _Otppagestate extends State<Otppage> {

  var _scaffoldStateKey = new GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  List otpData = [];
  List result = [];
  String? OTP_Text, strOtpType;
  String cafno = "", username = "";
  TextEditingController controller = TextEditingController();
  OtpFieldController otpController = OtpFieldController();

  @override
  initState() {
    super.initState();
    setState(() {
      controller.text = widget.otp;
      strOtpType = widget.strOtpType;
      cafno = widget.cafno;
      username = widget.username;
      print('@@@@@@@@@@@');
      print("otp is>>>>><<<<<<" + controller.text);
      print("caf no is>>>>><<<<<<" + cafno);
      print("strOtpType is>>>>><<<<<<" + widget.strOtpType);
      print("username is>>>>><<<<<<" + username);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg.jpg"), fit: BoxFit.fitHeight)),
        child: new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: true,
                // resizeToAvoidBottomPadding: true,
                key: _scaffoldStateKey,
                body: SingleChildScrollView(
                    child: Stack(children: <Widget>[
                  ClipPath(
                      clipper: CurveClipper(),
                      child: Container(
                          height: MediaQuery.of(context).size.height / 1.3,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.red[900],
                          ))),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height / 15),
                      Image(
                        image: AssetImage('assets/BSCB.png'),
                        width: 120.0,
                        height: 120.0,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "ONLINE FACILATION SYSTEM \n FOR STUDENTS ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        height: 5.0,
                      ),
                      Text(
                        "Bihar School Examination Board",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 30),
                      Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                              height: 250,
                              width: 320,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Column(children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, top: 20),
                                    child: Text(
                                      "Sit back & relax! while we verify your mobile number",
                                      style: TextStyle(
                                        color: Colors.red[900],
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    )),
                                Form(
                                  key: formKey,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 30),
                                    /* child: PinCodeTextField(
                                            autoFocus: true,
//                                        controller: TextEditingController(text: otp,),
                                            controller: controller,
                                            length: 6,
                                            obscureText: true,
                                            animationType: AnimationType.fade,
                                            validator: (v) {
                                              if (v!.length < 3) {
                                                return "please enter your OTP";
                                              } else {
                                                return null;
                                              }
                                            },
                                            pinTheme: PinTheme(
                                              shape: PinCodeFieldShape.underline,
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              fieldHeight: 50,
                                              fieldWidth: 40,
                                              inactiveColor: Colors.grey,
                                              // activeColor:  hasError ? Colors.orange : Colors.green,
                                            ),
                                            animationDuration:
                                            Duration(milliseconds: 300),

                                            onCompleted: (v) {
                                              print("Completed");
                                              print(v);
                                            },
                                            // onTap: () {
                                            //   print("Pressed");
                                            // },
                                            onChanged: (value) {
                                              print(value);

                                              setState(() {
                                                controller.text = value;
                                              });
                                            },
                                            beforeTextPaste: (text) {
                                              print("Allowing to paste $text");
                                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                              return false;
                                            }, appContext: context,
                                          )*/
                                    child: OTPTextField(
                                        controller: otpController,
                                        length: 6,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        textFieldAlignment:
                                            MainAxisAlignment.spaceAround,
                                        fieldWidth: 30,
                                        fieldStyle: FieldStyle.underline,
                                        outlineBorderRadius: 15,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(fontSize: 17),
                                        onChanged: (pin) {
                                          OTP_Text = pin;
                                          print("Changed: " + OTP_Text!);
                                        },
                                        onCompleted: (pin) {
                                          OTP_Text = pin;
                                          print("Completed: " + OTP_Text!);
                                        }),
                                  ),
                                ),
                                new Container(
                                  height: 46,
                                  padding: const EdgeInsets.all(8.0),
                                  width: MediaQuery.of(context).size.width / 2.2,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red[900],
                                    ),
                                    onPressed: () {
                                      if (OTP_Text.toString().isEmpty ||
                                          OTP_Text.toString() == null ||
                                          OTP_Text.toString() == 'null') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "Otp field can't be left blank"),
                                            duration:
                                                Duration(milliseconds: 300),
                                          ),
                                        );
                                      } else if (OTP_Text.toString().length !=
                                          6) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text("Please enter valid otp"),
                                            duration:
                                                Duration(milliseconds: 300),
                                          ),
                                        );
                                      } else {
                                        _submit();
                                      }
                                    },
                                    child: new Text("Verify OTP",style: TextStyle(color: Colors.white),),
                                  ),
                                ),
                                SizedBox(height: 20),
                                new Container(
                                  height: 45,
                                  width: MediaQuery.of(context).size.width,
                                  child: TextButton(
                                    // padding: const EdgeInsets.all(8.0),
                                    onPressed: () {
                                      checkconnectivityOfResendOtp();
                                    },
                                    child: new Text(
                                      "Resend OTP ?",
                                      style: TextStyle(color: Colors.red[900]),
                                    ),
                                  ),
                                )
                              ])))
                    ],
                  ),
                ])))));
  }


  void _submit() {
    final form = formKey.currentState;
    if (form!.validate()) {
      setState(() {
        form.save();
        checkconnectivity();
      });
    }
  }

  _displaySnackBarError(msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Color(0xffE11A29),
        duration: Duration(milliseconds: 300),
      ),
    );
  }

  checkconnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.none) {
      _displaySnackBarError(
          "You are not connected to internet.Please connect to internet and try again");
    } else {
      if (strOtpType == "vp") {
        otpserv();
      } else {
        applyForSlideupOTPApiMethod();
      }
    }
  }

  //This method is used for getting OTP
  otpserv() {
    otpData.clear();

    OtpPageModel postdata = OtpPageModel(
        strOtp: OTP_Text,
        strOtpType: strOtpType,
        strCAfNo: widget.cafno,
        type: "2");
    debugPrint(
        "otp request Body of vp type---->${jsonEncode(postdata.toJson())}");
    OtpServ(postdata).then((value) {
      var result = json.decode(value.body);
      Navigator.pop(context);
      print('###################');
      print(result);
      for (var i = 0; i < result.length; i++) {
        setState(() {
          otpData.add(result);
          print(otpData);
          print(otpData[0][0]['status']);
        });
      }
      if (otpData[0][0]['status'] == "200") {
        print("Otp data status print success");
        FocusScope.of(context).unfocus();
        otpDialog();
      } else if (otpData[0][0]['status'] == "300") {
        print("Otp data status print failed");
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                content: Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      otpData[0][0]['msg'],
                      style: TextStyle(color: Colors.red[900], fontSize: 20.0),
                    ),
                  ),
                ),
              );
            });
      }
    });
  }

  //This method is used for getting slide up data
  applyForSlideupOTPApiMethod() {
    print("enter into apply slide up  api method");

    ApplyForSlideUpReqModel slideUpData = ApplyForSlideUpReqModel(
        strCAfNo: widget.cafno,
        strOtpType: strOtpType,
        strOtp: OTP_Text,
        type: "2");

    debugPrint("Apply Slide up---->${jsonEncode(slideUpData.toJson())}");

    applyForSlideup(slideUpData).then((value) {
      List<dynamic> result = json.decode(value.body);
      print(result);
      print('Apply Slide up');
      debugPrint(":::" + result[0]['status'].toString());
      if (result[0]['status'].toString() == "200") {
        debugPrint("open slideup Dilog");
        debugPrint("osuccess 200"+result[0]['msg'].toString());
        FocusScope.of(context).unfocus();
        slideUpDialog(result[0]['msg'].toString());
      } else if (result[0]['status'].toString() == "300") {
        debugPrint("osuccess 300"+result[0]['msg'].toString());
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                content: Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      result[0]['msg'],
                      style: TextStyle(color: Colors.red[900], fontSize: 20.0),
                    ),
                  ),
                ),
              );
            }
          );
      }
    });
  }

  //otp success dialog
  otpDialog() {
    showDialog(
        context: context,
        builder: (context) {
          Timer(Duration(seconds: 2), () {
            print("Yeah, this line is printed after 2 seconds");
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ChangePasswordPage(OTP_Text!, widget.cafno)));
          });
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Container(
                height: 80,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        otpData[0][0]["msg"],
                        style: TextStyle(color: Colors.green, fontSize: 20.0),
                      ),
                      Text(
                        "Your OTP is verified successfully",
                        style: TextStyle(color: Colors.green, fontSize: 15.0),
                      ),
                    ])),
          );
        });
  }

  //slide up dialog
  slideUpDialog(String msg) {
    showDialog(
        context: context,
        builder: (context) {
          Timer(Duration(seconds: 2), () {
            print("Yeah, this line is printed after 20 seconds in slide up");
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Dashboard()));
          });
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Container(
                height: 100,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        msg,
                        style: TextStyle(color: Colors.green, fontSize: 20.0),
                      ),
                    ])),
          );
        });
  }

  showprogressBar() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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

  //resend data internet check
  checkconnectivityOfResendOtp() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.none) {
      _displaySnackBarError(
          "You are not connected to internet.Please connect to internet and try again");
    } else {
      if (strOtpType == "vp") {
        ForgotPwd postdata =
        ForgotPwd(strCafNo: widget.cafno.toString(), strType: "2");
        forgotPasswordServ(postdata).then((value) {
          result = json.decode(value.body);
          print('result  ##############');
          print(result);
          print(result[0]['OTP']);
        });
      } else {
        print("enter into Resend otp ");
        resendOtpApiMethpd();
      }
    }
  }

  //resend data
  resendOtpApiMethpd() {
    print("enter into resend otp  api method");
    ResendOtpPageModel resendOtpData = ResendOtpPageModel(
        strCAfNo: widget.cafno,
        mobileNumber: username,
        strOtpType: strOtpType,
        type: "2");
    debugPrint(
        "Resend Otp APi method ---->${jsonEncode(resendOtpData.toJson())}");
    getResendOtp(resendOtpData).then((value) {
      List<dynamic> resendOtoData = json.decode(value.body);
      print(resendOtoData);
      print('Resend Otp>>>>> ');
      debugPrint(":::" + resendOtoData[0]['status'].toString());
      if (resendOtoData[0]['status'].toString() == "200") {
        FocusScope.of(context).unfocus();
        debugPrint("sent data To otp page ---->" +
            resendOtoData[0]['OTP'] +
            widget.cafno +
            strOtpType! +
            username);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Otppage(
                    otp: resendOtoData[0]['OTP'],
                    cafno: widget.cafno,
                    strOtpType: strOtpType!,
                    username: username)));
      } else if (resendOtoData[0]['status'] == "300") {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                content: Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      resendOtoData[0]['msg'],
                      style: TextStyle(color: Colors.red[900], fontSize: 20.0),
                    ),
                  ),
                ),
              );
            });
      }
    });
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    // path starts with (0.0, 0.0) point (1)
    path.lineTo(0.0, size.height - 150);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 150);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
