import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_install_app_plugin/flutter_install_app_plugin.dart';
// import 'package:launch_review/launch_review.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:ofss/Constants/Constant.dart';
import 'package:ofss/dashboardpage.dart';
import 'package:ofss/services/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import 'Constants/colors.dart';
import 'Mainpage.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Upgrader.clearSavedSettings();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen()));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var result;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      result = pref.getString('LoginData');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BSEB OFSS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: result == null ? Mainpage() : Dashboard(),);
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

String appVersion = '';
String? ServAppVersion;
String platform = '';
String projectAppID = '';

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  String? appversion;
  String version = "";
  Map? result;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    print('ttrrr');
    // getversion();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => MyApp()));
  }

  @override
  void initState() {
    super.initState();
    startTime();
    // getAppVersionData();
    // appversionserv();
    // getVestionAlert();
  }
  Future<void> getVestionAlert() async {
    await Upgrader.clearSavedSettings();
  }
  appVersionService() {
    appVersionServ().then((value) {
      result = json.decode(value.body);
      print(result!['GetVersionResult']['VersionData'][0]['Version']);
      setState(() {
        appversion = result!['GetVersionResult']['VersionData'][0]['Version'];
        if (version ==
            result!['GetVersionResult']['VersionData'][0]['Version']) {
          startTime();
        }
      });
    });
  }

  appversionserv() {
    appVersionServ().then((value) {
      result = json.decode(value.body);
      print('@@@@@@@@@@@');
      print(result);
      print(result!['GetVersionResult']['VersionData'][0]['Version']);
      setState(() {
        appversion = result!['GetVersionResult']['VersionData'][0]['Version'];
        if (version !=
            result!['GetVersionResult']['VersionData'][0]['Version']) {
          //condition change == to !=
          debugPrint(
              "New Version Available:::::${result!['GetVersionResult']['VersionData'][0]['Version']}");
          debugPrint("old Version Available:::::${version}");
          Dialogs.materialDialog(
              barrierDismissible: false,
              title: "Update Alert!!!!",
              titleStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: appBarColor),
              titleAlign: TextAlign.center,
              color: Colors.white,
              msg:
                  "There is a newer version of this application available.Click OK to update now.",
              msgStyle: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              msgAlign: TextAlign.left,
              context: context,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: result!['GetVersionResult']['VersionData'][0]
                                  ['Mandatory'] ==
                              "0"
                          ? true
                          : false,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: IconsButton(
                          onPressed: () {
                            startTime();
                          },
                          text: 'Skip',
                          color: appBarColor,
                          textStyle: TextStyle(
                              fontFamily: "Poppins-Regular",
                              fontSize: 11.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                          iconColor: Colors.white,
                        ),
                      ),
                    ),
                    IconsButton(
                      onPressed: () async {
                        // LaunchReview.launch(
                        //   androidAppId: "com.csm.biharSamso",
                        //   // iOSAppId: "585027354",
                        // );
                        //startProcedure();
                        //close the app
                        SystemNavigator.pop();
                      },
                      text: 'OK',
                      color: appBarColor,
                      textStyle: TextStyle(
                          fontFamily: "Poppins-Regular",
                          fontSize: 11.5,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                      iconColor: Colors.white,
                    ),
                  ],
                )
              ]);
        } else {
          startTime();
        }
      });
    });
  }

  Future<void> getAppVersionData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
      debugPrint("version:::::::::::::::::::::::::::::::::==$version");
      appVersionService();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset(
            'assets/bg1.jpg',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }

/*
  getversion() async {
print('ppppppppppp');
appVersion = await GetVersion.projectVersion;
projectAppID = await GetVersion.appID;
platform = Platform.operatingSystem;

var connectivityResult = await (Connectivity().checkConnectivity());
if (connectivityResult == ConnectivityResult.none ||
    connectivityResult == '' ||
    connectivityResult == 'undefined') {
  Constants.instance.displayToastmessage(context,
      "You are not connected to internet.Please connect to internet and try again",
    );
} else {
  GetAppVersion postdata = GetAppVersion(

      Applicanttype: "visitor",
      platform: platform.toString());

  getAppVersion(postdata).then((onValue) {
    if (!mounted) return;
    setState(() {
      Map data = json.decode(onValue.body);
      print(data);
      if (data != null && data != '' && data != 'undefined') {
        if (data['status'] == '200') {
          print('uuuuuu');
          if (data['VersionList'] != '' &&
              data['VersionList'] != null &&
              data['VersionList'] != 'undefined') {
            ServAppVersion = data['VersionList'][0]['appversion'];
                 print(appVersion.toString());
            if (appVersion.toString() != ServAppVersion.toString()) {
             Navigator.of(context).pushReplacementNamed('/LoginPage');
              versionAlert();
              print('uuuuuuuuuuuuu');
            }
            else
              {
              Navigator.of(context).pushReplacementNamed('/LoginPage');
                print('eeyrtyrtry');
              }

          } else {

            Constants.instance.displayToastmessage(context,"Something went wrong");

          }
        } else {
          Constants.instance.displayToastmessage(context,data['msg'].toString());
        }
      } else {
        Constants.instance.displayToastmessage(context,"Something went wrong");
      }
    });
  });
}
  }


 versionAlert() {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            title: Text('Update App?'),
            content: new Text(
              "A newer version upgrader is available!.Would you like to update it now?",
              style: TextStyle(color: Colors.grey),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new TextButton(
                child: new Text("NOT NOW"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new TextButton(
                child: new Text("UPDATE"),
                onPressed: () {
                  var app = AppSet();
                  app.androidPackageName = projectAppID.toString();
                  FlutterInstallAppPlugin.installApp(app);
                },
              )
            ]);
      });
}
*/
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
