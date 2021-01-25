import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Registration extends StatefulWidget {
  final String lang;

  const Registration({Key key, this.lang}) : super(key: key);
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool checkedValue = false;
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController idNumber = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
            textFieldEdit("First name", fName),
            textFieldEdit("Last name", lName),
            textFieldEdit(
              "Nationality ID",
              idNumber,
              isNumber: true,
            ),
            textFieldEdit(
              "Phone number",
              phoneNumber,
              isNumber: true,
            ),
            CheckboxListTile(
              title: Text("I agree to The Term and Condition"),
              value: checkedValue,
              onChanged: (newValue) {
                setState(() {
                  checkedValue = newValue;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            InkWell(
              onTap: () async {
                if (fName.text.isEmpty ||
                    lName.text.isEmpty ||
                    idNumber.text.isEmpty ||
                    phoneNumber.text.isEmpty) {
                  Toast.show("Toast plugin app", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                }
              },
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(color: Colors.green),
                child: Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textFieldEdit(text, controllerText, {isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          controller: controllerText,
          keyboardType: isNumber ? TextInputType.number : null,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 1.0),
            ),
            hintText: text,
          ),
        ),
      ),
    );
  }
}
