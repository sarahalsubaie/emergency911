import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergancy/Screens/Registration.dart';
import 'package:emergancy/Screens/ServicesList.dart';
import 'package:emergancy/toast.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController fName = TextEditingController();
  TextEditingController idNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
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
              textFieldEdit("First name", fName),
              textFieldEdit(
                "Nationality ID",
                idNumber,
                isNumber: true,
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  bool isRegestered = false;
                  await FirebaseFirestore.instance
                      .collection('users')
                      .where('firstName', isEqualTo: fName.text)
                      .where('idNumber', isEqualTo: idNumber.text)
                      .get()
                      .then((value) => value.docs.forEach((e) {
                            setState(() {
                              isRegestered = true;
                            });
                          }));
                  if (isRegestered) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServicesList(id: idNumber.text),
                      ),
                    );
                  } else {
                    errorMsg(context, "Do not match our data");
                  }
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(color: Colors.green),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  child: Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              )
            ],
          ),
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
