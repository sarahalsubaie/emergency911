import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergancy/Screens/ServicesList.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:twilio_flutter/twilio_flutter.dart' as tw;
import 'package:uuid/uuid.dart';
import 'package:emergancy/toast.dart';

class Verfiy extends StatefulWidget {
  final String phoneNumber;
  final String idNumber;
  const Verfiy({Key key, this.phoneNumber, this.idNumber}) : super(key: key);
  @override
  _VerfiyState createState() => _VerfiyState();
}

class _VerfiyState extends State<Verfiy> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  tw.TwilioFlutter twilioFlutter;
  String codeID;
  @override
  void initState() {
    super.initState();

    twilioInfo();
  }

  twilioInfo() async {
    var uuid = Uuid();
    codeID = uuid.v1();
    String accID;
    String accApi;
    await FirebaseFirestore.instance
        .collection('twilio')
        .get()
        .then((value) => value.docs.forEach((e) {
              setState(() {
                accID = e.data()['id'];
                accApi = e.data()['api'];
              });
            }));
    twilioFlutter = tw.TwilioFlutter(
      accountSid: accID,
      authToken: accApi,
      twilioNumber: '+12054966662',
    );
    String number = widget.phoneNumber;
    if (number[0] == '0') {
      number.substring(1);
    }
    String phoneSMS = "+966$number";
    codeID = codeID.replaceAll(new RegExp(r'[^0-9]'), ''); // '23'
    codeID = codeID.substring(0, 4);
    twilioFlutter.sendSMS(
      toNumber: phoneSMS,
      messageBody: ' This is your temporary code: $codeID',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            width: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/emrg.png'),
              ),
            ),
          ),
          ListTile(
            title: Text("Enter the code sent"),
            leading: Icon(
              Icons.mail_outline,
              size: 45,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: PinPut(
              eachFieldMargin: EdgeInsets.all(16),
              fieldsCount: 4,
              // onSubmit: (String pin) => _showSnackBar(pin, context),
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: _pinPutDecoration.copyWith(
                borderRadius: BorderRadius.circular(20.0),
              ),
              selectedFieldDecoration: _pinPutDecoration,
              followingFieldDecoration: _pinPutDecoration.copyWith(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: Colors.deepPurpleAccent.withOpacity(.5),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () async {
                  if (_pinPutController.text == codeID) {
                    succMsg(context, 'Verified');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ServicesList(id: widget.idNumber)),
                    );
                  } else {
                    errorMsg(context, "Code error");
                  }
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(color: Colors.green),
                  child: Center(
                    child: Text(
                      "Verify Code",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: twilioInfo,
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(color: Colors.green),
                  child: Center(
                    child: Text(
                      "Resend Code",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
