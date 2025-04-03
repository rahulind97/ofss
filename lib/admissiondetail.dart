import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ofss/dashboardpage.dart';
import 'package:ofss/model/AdmissiondetailModel.dart';
import 'package:ofss/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Admissiondetails extends StatefulWidget {
  Admissiondetails( this.title);
  final String title;

  @override
  _AdmissiondetailsState createState() => _AdmissiondetailsState();
}

class _AdmissiondetailsState extends State<Admissiondetails> {

  final formKey = new GlobalKey<FormState>();
  var _scaffoldStateKey = new GlobalKey<ScaffoldState>();

  bool showPassword = true;
  bool isloading = false;
  Map? result;
  String message="";
  final RegExp phoneRegex = new RegExp(r'^[6-9]\d{9}$');

  _displaySnackBar(msg) {
    final snackBar = new SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black,
    );
  //  _scaffoldStateKey.currentState!.showSnackBar(snackBar);
    ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text(msg), duration: Duration(milliseconds: 300), ), );
  }

  _displaySnackBarError(msg) {
    final snackBar = new SnackBar(
      content: Text(msg),
      backgroundColor: Color(0xffE11A29),
    );
   // _scaffoldStateKey.currentState.showSnackBar(snackBar);
    ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text(msg), duration: Duration(milliseconds: 300), backgroundColor: Color(0xffE11A29), ), );
  }

  @override
  void initState() {
    super.initState();
    getAdmissiondetails();
  }

  getAdmissiondetails() async {
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map logindata = json.decode(prefs.getString("LoginData").toString());
    print(logindata);

    Admissiondetail postdata = Admissiondetail(
        strCAfNo: logindata["cafNumber"],
        strOtpType: "a",
        strOtp: "",
        type: "2");
    getAdmissionData(postdata).then((value) {
      result = json.decode(value.body);
      print(result);
      print(result!["msg"]);
      setState(() {
        message=result!["msg"];
      });
    });
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldStateKey,
        body: new Stack(
          children: buildWidget(context),
        ));
  }

  List<Widget> buildWidget(BuildContext context) {
    var mainWidget = Center(
        child: SingleChildScrollView(
      child: Stack(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
              image: DecorationImage(
            image: new AssetImage(
              'assets/bg.jpg',
            ),
            fit: BoxFit.cover,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  shadowColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 20),
                    child: Container(
                      // height: MediaQuery.sizeOf(context).height*0.35,
                      //  color: Colors.white,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                'ADMISSION DETAILS',
                                style: TextStyle(
                                    color: Colors.red[900],
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ),
                                 SizedBox(
                                   height: 16,
                                 ),
                                 message!=null
                                  ? Text(
                                      message,
                                      style: TextStyle(
                                          color: Colors.red[900],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text("Please wait for first Merit List"),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: ElevatedButton(
                                    // shape: RoundedRectangleBorder(
                                    //   borderRadius: BorderRadius.circular(20.0),
                                    // ),
                                    // textColor: Colors.white,
                                    // color: Colors.amber,
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber,
                                        shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(20.0),
                                           ),
                                    ),
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () async {
                                       Navigator.push(
                                         context,
                                         MaterialPageRoute(
                                             builder: (context) => Dashboard()),
                                       );
                                    }),
                              ),
                            ])),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    ));
    List<Widget> list = [];
    list.add(mainWidget);

    return list;
  }

}
