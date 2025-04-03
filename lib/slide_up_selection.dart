import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ofss/services/services.dart';
import 'package:ofss/user_info.dart';
import 'Constants/colors.dart';
import 'Otppage.dart';
import 'model/GetSlideupContentModel.dart';
import 'model/getOtpModel.dart';
import 'model/slideUpStatusModel.dart';

class SlideUpSelection extends StatefulWidget {
  String cafNo, username;

  SlideUpSelection(this.cafNo, this.username);

  @override
  _SlideUpSelectionState createState() => _SlideUpSelectionState();
}

class _SlideUpSelectionState extends State<SlideUpSelection> {
  String cafNo = "", slideUpStatus = "", username = "", msg = "";
  bool isLoading = true;
  List<LstContent> slideUpContent = [];

  @override
  void initState() {
    super.initState();
    cafNo = widget.cafNo;
    print("Caf NO is>>>>>> " + cafNo);
    username = widget.username;
    print("UserName  is>>>>> " + username);
    slideUpDataInternetCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          title: Text(
            'Slide Up Selection',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: appBarColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            //replace with our own icon data.
          ),
        ),
        body:
      /*  slideUpStatus != "0"
            ? Center(
                child: CircularProgressIndicator(
                color: btnColor,
              ))
            : Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 15,right: 15),
                  child: Card(
                    surfaceTintColor: Colors.white,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 15,right: 15),

                      height: MediaQuery.sizeOf(context).height*0.2,
                      child: Center(
                        child: Text(msg,textAlign: TextAlign.center,
                            style:
                                TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      ),
                    ),
                  ),
                )),
*/
        //NB- This commented code should be actvated in next session when slideup content is added in live
         slideUpContent.isEmpty
      ? Center(
              child: CircularProgressIndicator(
              color: btnColor,
            )
      )
      :slideUpStatus != "3"
              ?slideUpContent[0].strSeq.toString()=="0"
             ? Center(
               child: Container(
               height: MediaQuery.sizeOf(context).height*0.16,
               width: MediaQuery.sizeOf(context).width*0.86,
               child: Card(child: Center(child: Text(slideUpContent[0].strContent.toString(),textAlign: TextAlign.center,
                 style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)))),
             )
             : Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: appBarColor,
                        child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: slideUpContent[0].strContent!=""? Text(
                                        slideUpContent[0].strContent.toString(),
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ):SizedBox(),
                                    ),
                                    slideUpContent[1].strContent!=""
                                        ?Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: RichText(
                                            textAlign: TextAlign.justify,
                                            softWrap: true,
                                            text: new TextSpan(
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text:
                                                        'स्लाइड अप प्रक्रिया -',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                      text: slideUpContent[1].strContent.toString(),
                                                      style: TextStyle(
                                                          fontSize: 16))
                                                ]))):SizedBox(),
                                    Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          'आवेदक विशेष ध्यान दें',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child:  slideUpContent[2].strContent!=""?
                                      Text(
                                        slideUpContent[2].strContent.toString(),
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ):SizedBox(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0),
                                      child: slideUpStatus == '2'
                                          ? ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xff89000A)),
                                              onPressed: () {
                                                print("Slideup status ==2");
                                                getOtpInternetCheck();
                                              },
                                              child: Text('Choose Slide Up',style: TextStyle(color: Colors.white),))
                                          : slideUpStatus == '1'
                                              ? ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Color(
                                                                  0xff89000A)),
                                                  onPressed: () {
                                                    print("Slideup status ==1");
                                                    getOtpInternetCheck();
                                                  },
                                                  child:
                                                      Text('Revert Slide Up',style: TextStyle(color: Colors.white)))
                                              : SizedBox(),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                )
              : SizedBox(
           child: Center(
             child: Text(msg,textAlign: TextAlign.center,
                 style:
                 TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
           ),
         ),
        );
  }

  _displaySnackBarError(msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(milliseconds: 300),
        backgroundColor: Color(0xffE11A29),
      ),
    );
  }

  void slideUpDataInternetCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.none ||
        // ignore: unrelated_type_equality_checks
        connectivityResult == '' ||
        // ignore: unrelated_type_equality_checks
        connectivityResult == 'undefined') {
      _displaySnackBarError(
        "Unable to proceed due to bad network connectivity.Please try after sometimes !!",
      );
    } else {
      // write api call method
      getSlideUPContent();
      slideUpOption();
    }
  }

  slideUpOption() {
    debugPrint("enter into slide up api method");
    SlideUpModel postData =
        SlideUpModel(strCafNo: cafNo, strOtpType: "s", strOtp: "", type: "2");
    debugPrint("slide up requestBody---->${jsonEncode(postData.toJson())}");
    getSlideUpStatus(postData).then((value) {
      var result = json.decode(value.body);
      // print('result ##############********'+result.toString() );
      // debugPrint(result);
      debugPrint(result['strSlideUpStatus']);
      debugPrint('slide up result status##############********');
      setState(() {
        slideUpStatus = result['strSlideUpStatus'];
        msg = result['msg'];
      });
      if (result['status'].toString() == "200") {
        debugPrint('SLide up api ' + result['msg']);
        debugPrint('msg>>>>>>>>>>>>>>>>>>>>>>>>... ' + msg);
        //  getOtpInternetCheck();
      }
    });
  }

  void getOtpInternetCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.none ||
        // ignore: unrelated_type_equality_checks
        connectivityResult == '' ||
        // ignore: unrelated_type_equality_checks
        connectivityResult == 'undefined') {
      _displaySnackBarError(
        "Unable to register due to bad network connectivity.Please try after sometimes !!",
      );
    } else {
      // write api call method
      getOtpApiMethpd();
    }
  }

  getOtpApiMethpd() {
    print("enter into otp  api method");
    if (slideUpStatus == '2') {
      GetOtpPageModel postData1 = GetOtpPageModel(
          mobileNumber: username, strOtpType: "u", strCAfNo: cafNo, type: "2");
      debugPrint("otp request Body---->${jsonEncode(postData1.toJson())}");
      getOtp(postData1).then((value) {
        var result = json.decode(value.body);
        print(result);
        print('Slide up status 2 ');
        if (result[0]['status'].toString() == "200") {
          print('Get OTP >>>>>>>>>>>>');
          print(result[0]['OTP']);
          print(
              "sent data is u type>>>>>>>>>" + result[0]['OTP'] + cafNo + "u");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Otppage(
                      otp: result[0]['OTP'],
                      cafno: cafNo,
                      strOtpType: "u",
                      username: username)));
        }
      });
    } else {
      GetOtpPageModel postData2 = GetOtpPageModel(
          mobileNumber: widget.username,
          strOtpType: "r",
          strCAfNo: cafNo,
          type: "2");

      debugPrint("otp request Body---->${jsonEncode(postData2.toJson())}");

      getOtp(postData2).then((value) {
        var result = json.decode(value.body);
        // print('result ##############********'+result.toString() );
        print(result);
        print('Slide up status 1 ');
        print('otp result status##############********');
        if (result[0]['status'].toString() == "200") {
          print('Get OTP >>>>>>>>>>>>');
          print("sent data is>>>>>>>>>" + result[0]['OTP'] + username + "r");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Otppage(
                      otp: result[0]['OTP'],
                      cafno: cafNo,
                      strOtpType: "r",
                      username: username)));
        }
      });
    }
  }

  Future<List<LstContent>> getSlideUPContent() async {
    print("slideUpContent");
    print(slideUpContent);
    try {
      http.Response res = await http.post(Uri.parse(URL + 'getSlideupContent'));
      print(res);
      slideUpContent =
          GetSlideupContentModel.fromJson(json.decode(res.body)).lstContent!;

      print("SLide Up Content >>>>>>>>>" +
          slideUpContent[0].strContent.toString());

    } catch (e) {
      print(e);
    }
    return slideUpContent;
  }
}
