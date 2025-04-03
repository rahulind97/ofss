import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_install_app_plugin/flutter_install_app_plugin.dart';
import 'package:ofss/CollegeInformation.dart';
import 'package:ofss/Login.dart';
import 'package:ofss/app_version.dart';
import 'package:upgrader/upgrader.dart';

import 'custom_text.dart';


class Mainpage extends StatefulWidget {
  @override
  _Mainpagestate createState() => _Mainpagestate();
}

class _Mainpagestate extends State<Mainpage> {
  bool _status = true;
  var _scaffoldStateKey = new GlobalKey<ScaffoldState>();


  Future<bool> _showDialog() async{
    // flutter defined function
  return(await showDialog(
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
                child: new Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new TextButton(
                child: new Text("Exit"),
                onPressed: () {
                  SystemChannels.platform
                      .invokeMethod<void>('SystemNavigator.pop');
                },
              )
            ]);
      }) )?? false;
  }

  void rateMe() {
    // flutter defined function
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))
            ),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 26.0, top: 18),
                    child: Text(
                      "Rate BSEB",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText:
                            "If you enjoy using BSEB, would\nyou mind taking a moment to \nrate it? It won't take more than a \nminute. Thanks for your support!",
                        border: InputBorder.none,
                      ),
                      enabled: !_status,
                      autofocus: !_status,
                      maxLines: 5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 160.0),
                    child: GestureDetector(
                      child: Text(
                        "NO, THANKS",
                        style:
                            TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 160.0),
                    child: GestureDetector(
                        child: Text(
                          "RATE IT NOW",
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                        ),
                        // onTap: () {
                        //   var app = AppSet();
                        //   app.androidPackageName = "com.csm.biharSamso";
                        //   FlutterInstallAppPlugin.installApp(app);
                        // }
                      ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 120.0),
                    child: GestureDetector(
                      child: Text(
                        "REMIND ME LATER",
                        style:
                            TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          );
        });
  }

  // Upgrader upgrader = Upgrader(
  //   dialogStyle: UpgradeDialogStyle.cupertino, // or .material
  //   showLater: false,
  //   showIgnore: false,
  //   canDismissDialog: false,
  //   showReleaseNotes: false,
  //   durationUntilAlertAgain: Duration(milliseconds: 1),
  // );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _showDialog,
        child: Stack(
          children: [
            Scaffold(
                key: _scaffoldStateKey,
                drawer: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(35),
                        bottomRight: Radius.circular(35)
                    ),
                    child: Drawer(
                      child: ListView(children: <Widget>[
                        ListTile(
                          title: Text(
                            'Intermediate',
                            style: CustomTextStyle.headlinestlye,
                          ),
                        ),
                        ListTile(
                            leading: Icon(Icons.settings, color: Colors.black),
                            title: Text(
                              'Slide Up Selection',
                              style: CustomTextStyle.mediumTextStyle,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginPage(""))
                              );
                            }),
                        ListTile(
                            title: Text(
                              'Others',
                              style: CustomTextStyle.headlinestlye,
                            )),
                        /*  ListTile(
                        leading: Icon(
                          Icons.thumb_up,
                          size: 30,
                          color: Colors.black,
                        ),
                        title: Text(
                          'RateMe',
                          style: CustomTextStyle.mediumTextStyle,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          rateMe();
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => _showDialog()),
//                     );
                        },
                      ),*/
                        ListTile(
                          leading: Icon(
                            Icons.error_outline,
                            size: 30,
                            color: Colors.black,
                          ),
                          title: Text(
                            'App Version',
                            style: CustomTextStyle.mediumTextStyle,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AppVersion()),
                            );
                          },
                        ),
                      ]),
                    )),
                body: Center(
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
                                  ))),
                          GestureDetector(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height / 50,
                                    top: MediaQuery.of(context).size.height / 15),
                                child: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              onTap: () {
                                _scaffoldStateKey.currentState!.openDrawer();
                              }),
                          Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  GestureDetector(
                                    child: Container(
                                        height: MediaQuery.of(context).size.height / 3.2,
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.6),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(100))),
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Image(
                                                image: AssetImage('assets/Exam.png'),
                                                width: 100.0,
                                                height: 100.0,
                                                fit: BoxFit.fill,
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'College Information',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ])),
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20.0),
                                              topRight: Radius.circular(20.0),
                                            )),
                                        builder: (_) => Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context).viewInsets.bottom),
                                          child: CollegeInfo(),
                                        ),
                                      );
                                      /*  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CollegeInfo()),
                            );*/
                                    },
                                  )
                                ]),
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(top: 20),
                              child: Column(children: <Widget>[
                                Container(
                                  height: MediaQuery.of(context).size.height / 1.62,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[

                                      Padding(
                                        padding:  EdgeInsets.only(top: MediaQuery.sizeOf(context).height*0.12),
                                        child: Image(
                                          image: AssetImage('assets/BSCB.png'),
                                          width: 120.0,
                                          height: 120.0,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        "ONLINE FACILATION SYSTEM \n FOR STUDENTS ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.center,
                                      ),
                                      Container(
                                        height: 5.0,
                                      ),
                                      Text(
                                        "Bihar School Examination Board, Govt.of  Bihar",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 30),
                                      Text(
                                        "Not Login Yet?\nLogin New with Registration No",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 20),
                                      new Container(
                                        height: 45,
                                        width: MediaQuery.of(context).size.width / 2,
                                        child: ElevatedButton(
                                          // shape: RoundedRectangleBorder(
                                          //     borderRadius: BorderRadius.circular(20)),
                                          // padding: const EdgeInsets.all(8.0),
                                          // textColor: Colors.red[900],
                                          // color: Colors.white,
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red[900],
                                              shape:(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                    //side: BorderSide(color: Colors.red)
                                                  )
                                              )
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => LoginPage("Login Page")),
                                            );
                                          },
                                          child: new Text("LOGIN",
                                              style: new TextStyle(
                                                  fontSize: 16.0,color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]))
                        ])))),
            Container(child: Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: UpgradeAlert(
                // upgrader: upgrader, // Pass the upgrader object if needed
                /*child: UpgradeCard()*/
              ),
            )),),
          ],
        ));
  }
}
