import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ofss/services/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'Mainpage.dart';
import 'dashboardpage.dart';
class AppVersion extends StatefulWidget {
  @override
  _AppVersionstate createState() => _AppVersionstate();
}

class _AppVersionstate extends State<AppVersion> {
  var _scaffoldStateKey = new GlobalKey<ScaffoldState>();
 String? appversion;
  Map? result;
  initState() {
    super.initState();
    appversionserv();
  }
  appversionserv() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appversion = packageInfo.version;
    });

   /*appVersionServ().then((value) {
      result = json.decode(value.body);
      print('@@@@@@@@@@@');
      print(result);
   print(result!['GetVersionResult']['VersionData'][0]['Version']);
setState(() {
  appversion=result!['GetVersionResult']['VersionData'][0]['Version'];
});

      //      Navigator.pop(context);
//      if (result['GetVersionResult']['status'] != null) {
//        showDialog(
//            context: context,
//            builder: (context) {
//              return AlertDialog(
//                content: Container(
//                  height:
//                  MediaQuery.of(context).size.height *
//                      0.3,
//                  color: Colors.green,
//                  child: Center(
//                    child: Text(
//                      result['GetVersionResult']['status'],
//                      style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 20.0),
//                    ),
//                  ),
//                ),
//              );
//            });
//      }else if(result['feedbackResult'] == null){
//        showDialog(
//          context: context,
//          builder: (context) {
//            return AlertDialog(
//              content: Container(
//                height:
//                MediaQuery.of(context).size.height *
//                    0.3,
//                color: Colors.red,
//                child: Center(
//                  child: Text(
//                    "error",
//                    //                    result["error"],
//                    style: TextStyle(
//                        color: Colors.white,
//                        fontSize: 20.0),
//                  ),
//                ),
//              ),
//            );
//          },
//        );
//      }
    });*/

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            key: _scaffoldStateKey,
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
                      Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(top: 20),
                          child: Column(children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height / 1.1,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height / 5,
                                  ),
                                  Text(
                                    "Welcome to \nBihar School Examination Board",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),

                                  SizedBox(height: 30),
                                  Image(
                                    image: AssetImage('assets/BSCB.png'),
                                    width: 120.0,
                                    height: 120.0,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height / 15,
                                  ),
                                  appversion!=null
                                      ?
                                  Text(
                                    "Version $appversion",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700)):Text('', style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(height: 50),
                                  new Container(
                                    height: 35,
                                    child: ElevatedButton(
                                      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      // padding: const EdgeInsets.all(8.0),
                                      // textColor: Colors.white,
                                      // color: Colors.red,
                                      style: ElevatedButton.styleFrom(backgroundColor:  Colors.red,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      ),
                                      onPressed: () {
                                       /* Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Dashboard()),
                                        );*/
                                        Navigator.pop(context);
                                      },
                                      child: new Text("BACK",style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]))
                    ]))));
  }
}
