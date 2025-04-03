import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:ofss/Constants/Constant.dart';
import 'package:ofss/college_info_list.dart';
import 'package:ofss/services/services.dart';

import 'Constants/colors.dart';
import 'model/blockModel.dart';

class CollegeInfo extends StatefulWidget {
  @override
  _CollegeInfostate createState() => _CollegeInfostate();
}

class _CollegeInfostate extends State<CollegeInfo> {
  var _scaffoldStateKey = new GlobalKey<ScaffoldState>();
  bool isLoading = true;
  List collegeData = [];
  String? districtValue;
  String? blockValue;
  Map? get_distResult;
  List<GetBlockResult> myAllData = [];
  List _distList = [];
  List<GetBlockResult> _blockList = [];
  List district = ["Khordha", "Ganjam", "Puri"];
  String _myDist = "";
  String _myBlock = "";
  String _myCollege = "";
  String _myDist1 = "";
  String _myBlock1 = "";
  String _myCollege1 = "";

//This method is used for getting the district list

  getDistListdata() {
    getDistData().then((value) {
      _distList.clear();
      Map result = json.decode(value.body);
      print(result);
      setState(() {
        _distList = result["get_distResult"];
        print(_distList);
      });
    });
  }

//This method is used for getting the block list

  Future<List<GetBlockResult>> _getBlockList() async {
    //getting Block list
    print(_blockList);
    try {
      http.Response res = await http.get(Uri.parse(URL + 'get_block'));
      print(res);
      _blockList = BlockModel.fromJson(json.decode(res.body)).getBlockResult!;
      print("Block List>>>>>>>>>" + _blockList[100].blockName.toString());
    } catch (e) {
      print(e);
    }
    return _blockList;
  }

  @override
  initState() {
    super.initState();
    checkconnectivity();
  }

  _displaySnackBar(msg) {
    final snackBar = new SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black,
    );
    //   _scaffoldStateKey.currentState.showSnackBar(snackBar);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(milliseconds: 300),
        backgroundColor: Colors.black,
      ),
    );
  }

  _displaySnackBarError(msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Please select district!!"),
        duration: Duration(milliseconds: 300),
        backgroundColor: Color(0xffE11A29),
      ),
    );
  }

  //This method is used for checking connectivity

  checkconnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
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
      getDistListdata();
      _getBlockList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      child: _distList.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'College Information',
                      style: TextStyle(
                      fontSize: 20,
                      color: appBarColor,
                      fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5,),
                    Center(
                      child: SizedBox(
                        height: 3,
                        width: 90,
                        child: Container(
                          width: 60,
                          color: Colors.red.shade900,
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Card(
                          elevation: 2,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            padding: const EdgeInsets.only(left: 3.0),
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0)),
                                alignedDropdown: true,
                                child: new DropdownButton(
                                  items: _distList.map((item) {
                                    return new DropdownMenuItem(
                                        value: item['dist_id'],
                                        child: new Text(item['dist_name']));
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      for (var i = 0;
                                          i < _distList.length;
                                          i++) {
                                        if (value == _distList[i]["dist_id"]) {
                                          districtValue =
                                              (_distList[i]["dist_name"]);
                                        }
                                      }
                                      _myDist = value.toString(); //casting done
                                      print(_myDist);
                                      blockValue = null;
                                      _myBlock = "0";
                                      FilterMethod(_myDist!);
                                    });
                                  },
                                  hint: districtValue != null
                                      ? Text(districtValue.toString(),
                                          style: TextStyle(
                                              color: Colors.grey[700]))
                                      : Text('Select District',
                                          style: TextStyle(
                                              color: Colors.grey[700])),
                                ),
                              ),
                            ),
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                          top: 10,
                        ),
                        child: Card(
                          elevation: 2,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            padding: const EdgeInsets.only(left: 3.0),
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                alignedDropdown: true,
                                child: new DropdownButton(
                                  hint: blockValue != null
                                      ? Text(blockValue.toString(),
                                          style: TextStyle(
                                              color: Colors.grey[700]))
                                      : Text(
                                          "Select Blocks",
                                          style: TextStyle(
                                              color: Colors.grey[400]),
                                        ),
                                  items: myAllData.map((item) {
                                    return new DropdownMenuItem(
                                        value: item.blockId,
                                        child: new Text(item.blockName!));
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      print("block value before>>>>>" +
                                          blockValue.toString());
                                      for (var i = 0;
                                          i < myAllData.length;
                                          i++) {
                                        if (value == myAllData[i].blockId) {
                                          blockValue = (myAllData[i].blockName);
                                          print("blockValue>>>>>>>>>>>>>" +
                                              blockValue.toString());
                                        }
                                      }
                                      _myBlock = value.toString();
                                      print("Selected Block after " + _myBlock);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 10),
                    Card(
                      elevation: 2,
                      child: Container(
                        height: 48.0,
                        width: MediaQuery.of(context).size.width / 1.15,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (String? val) {},
                          onChanged: (value) {
                            setState(() {
                              _myCollege = value;
                              print(_myCollege);
//                            _getCollegeList();
//                            collegeserv();
                            });
                          },
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            //fillColor: Colors.grey[200].withOpacity(0.5),
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            contentPadding: EdgeInsets.only(left: 2),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(6.0)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: "Type College Name",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.grey[400]),
                          ),
                        ),
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
                        style:
                            ElevatedButton.styleFrom(backgroundColor: btnColor),
                        onPressed: () {
//                        showprogressBar();
                          if (_myDist == '' || _myDist == null) {
                            Constants.instance.displayToastmessage(
                                context, "Please Select District !!");
                          } else {
                            setState(() {
                              _myDist1 = _myDist;
                              _myBlock1 = _myBlock;

                              print("sent Dist id is>>" + _myDist1);
                              print("sent block id is>>" + _myBlock1);
                              print("sent clg id is>>" + _myCollege1);
                              _myDist = "0";
                              _myBlock = "0";

                              districtValue = null;
                              blockValue = null;
                              print(" Dist id is>>" + _myDist);
                              print(" block id is>>" + _myBlock);
                              print(" clg id is>>" + _myCollege);
                            });
                            Constants.instance
                                .checkInternetConnectivity()
                                .then((internet) async {
                              if (internet) {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CollegeInfoList(
                                          _myDist1,
                                          _myBlock1.toString() == "null" ||
                                                  _myBlock1.toString() == "" ||
                                                  _myBlock1.toString() == null
                                              ? "0"
                                              : _myBlock1,
                                          _myCollege)),
                                );
                              } else {
                                print('No internet');
                                Constants.instance.displayToastmessage(context,
                                    "You are not connected to internet.Please connect to internet and try again");
                                /* _displaySnackBarError(
                              "You are not connected to internet.Please connect to internet and try again");
                        */
                              }
                            });
                          }
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => CollegeInfoList(result['CollegeName'])),
//                        );
                        },
                        child: new Text("Search",style: TextStyle(color: Colors.white),),
                      ),
                    )
                  ]),
            )
          : isLoading
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
                              color: appBarColor,
                              size: 50.0,
                            ),
                            new Text(
                              'Loading...',
                              style: new TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            )
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
                          ]))),
    );
  }

  //This method is used for getting the filtering list

  Future<void> FilterMethod(String myDist) async {
    myAllData.clear();
    for (var i = 0; i < _blockList.length; i++) {
      if (_blockList[i].distId!.contains(myDist)) {
        myAllData.add(_blockList[i]);
        print(myAllData);
      }
    }
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
}
