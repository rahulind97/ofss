import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ofss/seat_strength.dart';
import 'package:ofss/services/services.dart';

import 'Constants/colors.dart';
import 'model/collegeInfoModel.dart';

class CollegeInfoList extends StatefulWidget {
  final String myDist, myBlock, myCollege;

  CollegeInfoList(this.myDist, this.myBlock, this.myCollege);

//  final List collegeData;
//  CollegeInfoList( { List collegeData,});

  @override
  _CollegeInfoListState createState() => _CollegeInfoListState();
}

class _CollegeInfoListState extends State<CollegeInfoList> {
  List collegeData = [];
  String block = "";
  bool isLoading = true;
  var _scaffoldStateKey = new GlobalKey<ScaffoldState>();

  //This method is used for getting college Information
  collegeserv() {
    collegeData.clear();
    isLoading = true;
    CollegeInfoModel postdata = CollegeInfoModel(
        strColType: '2',
        intDistrictId: widget.myDist,
        intBlockId: widget.myBlock == null ? block : widget.myBlock,
        strCollegename: widget.myCollege);

    print("Dist>>>" + widget.myDist);
    print("Block>>>" + widget.myBlock);
    print("my clg>>" + widget.myCollege);
    collegeInfoServ(postdata).then((value) {
      Map result = json.decode(value.body);
      print('###################');
     // print(result["Get_College_InfoResult"][0]['CollegeName']);
      for (var i = 0; i < result["Get_College_InfoResult"].length; i++) {
          collegeData.add(result["Get_College_InfoResult"][i]);
//  print(collegeData['CollegeName']);
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  initState() {
    super.initState();
    checkconnectivity();
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 5), child: Text("Loading")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 3), () {
//          Navigator.pushReplacement(
//            context,
//            MaterialPageRoute(builder: (context) => LoginPage()),
//          );
        });
        return alert;
      },
    );
  }

  _displaySnackBarError(msg) {
    final snackBar = new SnackBar(
      content: Text(msg),
      backgroundColor: Color(0xffE11A29),
    );

    // _scaffoldStateKey.currentState.showSnackBar(snackBar);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(milliseconds: 300),
        backgroundColor: Color(0xffE11A29),
      ),
    );
  }

  checkconnectivity() async {
    print(widget.myBlock != null ? widget.myBlock == "0" : widget.myBlock);
    var connectivityResult = await (Connectivity().checkConnectivity());
    print('%%%%%%%%%%%%%%%%%%%');
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.none) {
      _displaySnackBarError(
          "You are not connected to internet.Please connect to internet and try again");
      Future.delayed(const Duration(milliseconds: 800), () {
        setState(() {
          isLoading = false;
        });
      });
    } else {
      collegeserv();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldStateKey,
      appBar: AppBar(
        title: Text("College List Information",style: TextStyle(color: Colors.white),),
        //centerTitle: true,
        backgroundColor: appBarColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            widget.myDist == "";
            widget.myBlock == "";
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          //replace with our own icon data.
        ),
        actions: [
          /*  Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Dashboard()));
              },
            ),
          ),*/
        ],
      ),
      body: collegeData.isNotEmpty && !isLoading
          ? ListView.builder(
              itemCount: collegeData.length,
              itemBuilder: (context, int i) => Column(
                children: [
                  new ListTile(
                    title: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 1.0,
                      // surfaceTintColor:Colors.red ,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [redColor1, redColor2],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            stops: [0.8, 0.1],
                            tileMode: TileMode.repeated,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: collegeData != null
                                    ? Text(collegeData[i]['CollegeName']
                                        .toString()
                                        .toUpperCase())
                                    : SizedBox(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black87,
                                ),
                                onPressed: () {
                                  /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SeatStrength(
                                        name: collegeData[i]['CollegeName'],
                                        id: collegeData[i]['CollegeID']
                                    )));*/

                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.55,
                                    ),
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    )),
                                    builder: (_) => SeatStrength(
                                        name: collegeData[i]['CollegeName'],
                                        id: collegeData[i]['CollegeID']),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
//              new Text(listViewData[i].title),
                    onTap: () {},
                  ),
                ],
              ),
            )
          : isLoading && collegeData.isEmpty
              ? new Center(
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
                            ),
                          ])))
              : new Center(
                  child: Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset('assets/NoDataFound.png'),
                            )
                            // Container(
                            //     height: 120,
                            //     width: 120,
                            //     decoration: BoxDecoration(
                            //       image: DecorationImage(
                            //         image: AssetImage(
                            //           'assets/no-wifi.png',
                            //         ),
                            //       ),
                            //       shape: BoxShape.rectangle,
                            //     )),
                            // new Text(
                            //   'No Internet Connection',
                            //   style: new TextStyle(
                            //       fontSize: 14.0,
                            //       color: Colors.grey[700],
                            //       fontWeight: FontWeight.w500),
                            // )
                          ]))),
    );
  }
}
