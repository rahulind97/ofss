import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ofss/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constants/colors.dart';
import 'model/user_info_model.dart';

Map? markdetail;
Map? personalInformation;
Map? paymentInformation;
Map? result;
Image? img;

class UserInfo extends StatefulWidget {
  String cafNo;

  UserInfo({required this.cafNo});

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  var _scaffoldStateKey = new GlobalKey<ScaffoldState>();
  bool _status = true;
  bool isloading = false;
  bool isNodata = false;

  String profileImage = "";
  String profileImageNew = "";

  @override
  void initState() {
    super.initState();
    checkconnectivity();
    print("cafNo>>>>>>>" + widget.cafNo);
    getlogindata();
  }

  getlogindata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Map logindata = json.decode(prefs!.getString('LoginData').toString());
      profileImage= logindata['ImagePath'];
      // profileImageNew=logindata['ImagePath'];
    });
    print("profileImage>>>>>>>" + profileImage);
  }

  _displaySnackBarError(msg) {
    final snackBar = new SnackBar(
      content: Text(msg),
      backgroundColor: Color(0xffE11A29),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(milliseconds: 300),
        backgroundColor: Color(0xffE11A29),
      ),
    );
    //_scaffoldStateKey.currentState!.showSnackBar(snackBar);
  }

  checkconnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.none) {
      _displaySnackBarError(
          "You are not connected to internet.Please connect to internet and try again");
      setState(() {
        isNodata = true;
      });
    } else {
      // getprofilephoto();
      getprofileData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldStateKey,
        backgroundColor: Color(0xff89000A),
        body: new Stack(
          children: isNodata ? buildEmptyWidget(context) : buildWidget(context),
        ));
  }

  List<Widget> buildEmptyWidget(BuildContext context) {
    var mainView = new Center(
        child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/no-wifi.png',
                          ),
                        ),
                        shape: BoxShape.rectangle,
                      )),
                  new Text(
                    'No Internet Connection',
                    style: new TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500),
                  )
                ])));
    List<Widget> list = [];
    list.add(mainView);

    return list;
  }

  List<Widget> buildWidget(BuildContext context) {
    var mainView = SafeArea(
      child: Scaffold(
        body: Material(
          color: Colors.transparent,
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: MySliverAppBar(
                  expandedHeight: 160,
                  profileImage: profileImage
                ),
                pinned: true,
                floating: false,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(color: Colors.transparent, height: 50.0),
                    silverlist(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    List<Widget> list = [];
    list.add(mainView);

    if (isloading) {
      var modal = new Stack(
        children: [
          new Opacity(
            opacity: 0.3,
            child: const ModalBarrier(dismissible: false, color: Colors.grey),
          ),
          new Center(
            child: SpinKitCircle(
              color: appBarColor,
              size: 50.0,
            ),
          )
        ],
      );
      list.add(modal);
    }

    return list;
  }

  //  Widget emptyWidget(BuildContext context)
  //  {
  //    return Stack(children: <Widget>[
  //      Text("nodata")
  //    ],);
  //  }

  Widget silverlist(BuildContext context) {
    return result != null
        ? Padding(
            padding: const EdgeInsets.only(top: 108.0, bottom: 50),
            child: new Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: new BoxDecoration(
                        color: Color(0xfff2f2f2),
                        borderRadius: new BorderRadius.all(
                          const Radius.circular(40.0),
                          //                    topRight: const Radius.circular(40.0),
                        )),
                    //              color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Marks',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: btnColor),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: (new Text('Full marks',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  )))),
                                          Padding(
                                              padding: EdgeInsets.only(top: 5),
                                              child: (new Text(
                                                  markdetail!["fullMark"],
                                                  style: TextStyle(
                                                      color: btnColor,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold)))),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: new Text('Obtained marks',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                )),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: new Text(
                                                markdetail!["obtainedMark"],
                                                style: TextStyle(
                                                    color: btnColor,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    decoration: new BoxDecoration(
                        color: Color(0xfff2f2f2),
                        borderRadius: new BorderRadius.all(
                          const Radius.circular(40.0),
                          //                    topRight: const Radius.circular(40.0),
                        )),
                    //              color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Personal Information',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff89000a)),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Father Name',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25.0),
                            child: TextFormField(
                              //                        controller: nameController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 10),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  //                    contentPadding:
                                  //                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                  ),
                                  hintText:
                                      personalInformation!["fatherName"] != null
                                          ? personalInformation!["fatherName"]
                                          : ""),
                              enabled: !_status,
                              autofocus: !_status,
                              onChanged: (nameController) {
                                // do what you want with the text
                              },
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 10.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Mother Name',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25.0),
                            child: TextFormField(
                              //                        controller: nameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 10),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                //                    contentPadding:
                                //                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                                hintText:
                                    personalInformation!["motherName"] != null
                                        ? personalInformation!["motherName"]
                                        : "",
                              ),
                              enabled: !_status,
                              autofocus: !_status,
                              onChanged: (nameController) {
                                // do what you want with the text
                              },
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 10.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'CAF No',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25.0),
                            child: TextFormField(
                              //                        controller: nameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 10),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                //                    contentPadding:
                                //                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                prefixIcon: const Icon(
                                  Icons.format_list_numbered,
                                  color: Colors.grey,
                                ),
                                hintText: widget.cafNo,
                              ),
                              enabled: !_status,
                              autofocus: !_status,
                              onChanged: (nameController) {
                                // do what you want with the text
                              },
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 10.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: new Text(
                                        'Date Of Birth',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25.0),
                            child: TextFormField(
                              //                        controller: nameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 10),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                //                    contentPadding:
                                //                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                prefixIcon: const Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.grey,
                                ),
                                hintText: personalInformation!["dob"],
                              ),
                              enabled: !_status,
                              autofocus: !_status,
                              onChanged: (nameController) {
                                // do what you want with the text
                              },
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 10.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: new Text(
                                        'Gender',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25.0),
                            child: TextFormField(
                              //                        controller: nameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 10),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                //                    contentPadding:
                                //                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                prefixIcon: const Icon(
                                  Icons.people,
                                  color: Colors.grey,
                                ),
                                hintText: personalInformation!['gender'],
                              ),
                              enabled: !_status,
                              autofocus: !_status,
                              onChanged: (nameController) {
                                // do what you want with the text
                              },
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 10.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: new Text(
                                        'Cast',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25.0),
                            child: TextFormField(
                              //                        controller: nameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 10),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                //                    contentPadding:
                                //                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                                hintText: personalInformation!['cast_name'],
                              ),
                              enabled: !_status,
                              autofocus: !_status,
                              onChanged: (nameController) {
                                // do what you want with the text
                              },
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 10.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: new Text(
                                        'Board',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25.0),
                            child: TextFormField(
                              //                        controller: nameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 10),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                //                    contentPadding:
                                //                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                prefixIcon: const Icon(
                                  Icons.book,
                                  color: Colors.grey,
                                ),
                                hintText: personalInformation!['board'],
                              ),
                              enabled: !_status,
                              autofocus: !_status,
                              onChanged: (nameController) {
                                // do what you want with the text
                              },
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 10.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: new Text(
                                        'Roll No',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25.0),
                            child: TextFormField(
                              //                        controller: nameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 10),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                //                    contentPadding:
                                //                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                prefixIcon: const Icon(
                                  Icons.format_list_numbered,
                                  color: Colors.grey,
                                ),
                                hintText: personalInformation!['rollno'],
                              ),
                              enabled: !_status,
                              autofocus: !_status,
                              onChanged: (nameController) {
                                // do what you want with the text
                              },
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 10.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: new Text(
                                        'year Of Passing',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25.0),
                            child: TextFormField(
                              //                        controller: nameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 10),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                //                    contentPadding:
                                //                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                prefixIcon: const Icon(
                                  Icons.access_time,
                                  color: Colors.grey,
                                ),
                                hintText:
                                    personalInformation!['yop'].toString(),
                              ),
                              enabled: !_status,
                              autofocus: !_status,
                              onChanged: (nameController) {
                                // do what you want with the text
                              },
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 10.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: new Text(
                                        'Applied Date',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25.0),
                            child: TextFormField(
                              //                        controller: nameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 10),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                //                    contentPadding:
                                //                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                prefixIcon: const Icon(
                                  Icons.date_range,
                                  color: Colors.grey,
                                ),
                                hintText:
                                    personalInformation!['strAppliedDate'],
                              ),
                              enabled: !_status,
                              autofocus: !_status,
                              onChanged: (nameController) {
                                // do what you want with the text
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: new Container(
                      decoration: new BoxDecoration(
                          color: Color(0xfff2f2f2),
                          borderRadius: new BorderRadius.all(
                            const Radius.circular(40.0),
                            //                    topRight: const Radius.circular(40.0),
                          )),
                      //              color: Color(0xffFFFFFF),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 25.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 10.0),
                                child: new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 15,
                                        ),
                                        new Text(
                                          'Payment Status',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff89000a)),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 10.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Transaction Date',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Card(
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 25.0),
                              child: TextFormField(
                                //                        controller: nameController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 10),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  //                    contentPadding:
                                  //                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                  prefixIcon: const Icon(
                                    Icons.date_range,
                                    color: Colors.grey,
                                  ),
                                  hintText:
                                      paymentInformation!['transactionDate'],
                                ),
                                enabled: !_status,
                                autofocus: !_status,
                                onChanged: (nameController) {
                                  // do what you want with the text
                                },
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 10.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Transaction Number',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Card(
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 25.0),
                              child: TextFormField(
                                //                        controller: nameController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 10),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  //                    contentPadding:
                                  //                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                  prefixIcon: const Icon(
                                    Icons.format_list_numbered,
                                    color: Colors.grey,
                                  ),
                                  hintText:
                                      paymentInformation!['transactionNumber'],
                                ),
                                enabled: !_status,
                                autofocus: !_status,
                                onChanged: (nameController) {
                                  // do what you want with the text
                                },
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 10.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Payment Status',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Card(
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 25.0),
                              child: TextFormField(
                                //                        controller: nameController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 10),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  //                    contentPadding:
                                  //                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                  prefixIcon: const Icon(
                                    Icons.check_circle,
                                    color: Colors.grey,
                                  ),
                                  hintText:
                                      paymentInformation!['paymentStatus'],
                                ),
                                enabled: !_status,
                                autofocus: !_status,
                                onChanged: (nameController) {
                                  // do what you want with the text
                                },
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 10.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: new Text(
                                          'Application Fee',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                  ],
                                )),
                            Card(
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 25.0),
                              child: TextFormField(
                                //                        controller: nameController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 10),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  //                    contentPadding:
                                  //                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                  prefixIcon: const Icon(
                                    Icons.currency_rupee,
                                    color: Colors.grey,
                                  ),
                                  hintText:
                                      paymentInformation!['applicationFee'],
                                ),
                                enabled: !_status,
                                autofocus: !_status,
                                onChanged: (nameController) {
                                  // do what you want with the text
                                },
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 10.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: new Text(
                                          'Payment Gateway Name',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                  ],
                                )),
                            Card(
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 25.0),
                              child: TextFormField(
                                //                        controller: nameController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 10),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  //                    contentPadding:
                                  //                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                  prefixIcon: const Icon(
                                    //Icons.attach_money,
                                    Icons.payment_outlined,
                                    color: Colors.grey,
                                  ),
                                  hintText:
                                      paymentInformation!['paymentGateWayName'],
                                ),
                                enabled: !_status,
                                autofocus: !_status,
                                onChanged: (nameController) {
                                  // do what you want with the text
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : Container();
  }

  //This method is used for getting the profile data
  getprofileData() async {
    setState(() {
      isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map logindata = json.decode(prefs.getString("LoginData").toString());
    print(logindata);

    Userinfo postdata = Userinfo(strCafNo: logindata["cafNumber"], type: "2");

    getuserInfo(postdata).then((value) {
      result = json.decode(value.body);
      setState(() {
        isloading = false;
      });
      print(result);
      setState(() {
        markdetail = result!["markDetail"];
        paymentInformation = result!["paymentInformation"];
        personalInformation = result!["personalInformation"];
        print(markdetail);
      });
    });
  }

//          getprofilephoto() async {
//              SharedPreferences prefs = await SharedPreferences.getInstance();
//           Map logindata = json.decode(prefs.getString("LoginData"));
//           print(logindata);

//           Profilepic postdata = Profilepic(strCAfNo: logindata["cafNumber"],strOtpType: "a",strOtp:"", type: "2");

//           getProfilepic(postdata,logindata["status"]).then((value) {
//            print('yyyyyyyyyyyyyyyyyyyyyy');
//            Map result= json.decode(value.body);
//            print(result);

//          });}
// }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String profileImage;
  String? name;

  MySliverAppBar({required this.expandedHeight,required this.profileImage});

  String imgPath = "http://portal.ofssbihar.org/DownloadImage.ashx/";


  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {

    if (result != null) {
      return Stack(
          fit: StackFit.expand,
          /* overflow: Overflow.visible*/
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
//              begin: Alignment.topLeft,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
//              end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
                  colors: [Color(0xff89000a), Color(0xff89000a)],
                  // whitish to gray
                  tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
                ),
              ),
            ),
            result != null
                ? Positioned(
                    top: expandedHeight / 1.9 - (shrinkOffset / 1.11),
                    child: Opacity(
                      opacity: (1 - shrinkOffset / expandedHeight),
                      child: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: ClipPath(
                            clipper: CurveClipper(),
                            child: Container(
                                height: expandedHeight * 1.5,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xff89000a),
                                      const Color(0xff89000a)
                                    ], // whitish to gray
                                    tileMode: TileMode.repeated,
                                  ),

                                  color: Colors.white,
                                  // repeats the gradient over the canvas
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                        child: SingleChildScrollView(
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: ClipOval(
                                              child: SizedBox.fromSize(
                                                size: Size.fromRadius(48),
                                                // Image radius
                                                child: profileImage!=""
                                                         ?Image.network(
                                                    profileImage,
                                                   // "https://bseb.s3.ap-south-1.amazonaws.com/OFSS2025/SAMS/ONLINE_CAF/APPL_IMAGES/2025/9024556604_20250320123533.jpg",
                                                    fit: BoxFit.cover)
                                                :Icon(Icons.person,size: 40,color: Colors.white,),
                                              ),
                                            ),
                                          ),

                                          Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: (personalInformation!["mob"] != "" &&
                                                      personalInformation!["mob"] != null
                                                  ? new Text(
                                                      personalInformation![
                                                          "mob"],
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                    )
                                                  : Text(""))),
                                          Padding(
                                              padding: EdgeInsets.only(top: 5),
                                              child: (new Text(
                                                  personalInformation!["email"],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  )))),
                                        ])))
                                  ],
                                )),
                          )),
                    ),
                  )
                : new Container(),
            Positioned(
                top: expandedHeight / MediaQuery.of(context).size.height * 670 -
                    (shrinkOffset) / 1.3,
                left: expandedHeight / MediaQuery.of(context).size.width * 320,
                child: Opacity(
                  opacity: (1 - shrinkOffset / expandedHeight),
                  child: Container(
                      color: Colors.transparent,
                      height: expandedHeight,
//              margin: EdgeInsets.symmetric(
//                  horizontal: MediaQuery.of(context).size.width / 12),
                      //  width: 500 ,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
//                         //cmnt plz
//                         child: Container(
//                             height: 80,
// //                          margin: EdgeInsets.only(top: 100,),
//                             width: 80,
//                             decoration: new BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.white,
//                                   width: 4,
//                                 ),
//                                 borderRadius: BorderRadius.circular(70.0),
//                                 color: Colors.blue[800]),
//                             child: Padding(
//                                 padding: EdgeInsets.only(top: 0, left: 0),
//                                 child: CircleAvatar(
//                                     radius: (60),
//                                     backgroundColor: Colors.red,
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(50),
//                                       child: Image.asset("assets/profile.png"),
//                                     )))
//                         ),
                            ),
                          ])),
                )),
            result != null
                ? Container(
                    child: Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Center(
                          child: (Text(
                            personalInformation!["name"],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                        )),
                  )
                : Container(),
            Positioned(
                top: 0.1,
                child: Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
//                new Icon(Icons.arrow_back, color: Colors.white),
                        GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(top: 10, left: 10),
                              child: new Icon(Icons.arrow_back,
                                  color: Colors.white, size: 24),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
//                        Navigator.push(
//                            context, new MaterialPageRoute(builder: (context) => new Dashboard()));
                            }),
                        SizedBox(
                          width: 10.0,
                        ),
                      ],
                    ))),
          ]);
    } else {
      return Stack();
    }
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  appTitleBasedOnPages() {}
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    // path starts with (0.0, 0.0) point (1)
    path.lineTo(0.0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
