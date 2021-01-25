import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServicesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            height: 150,
            width: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/emrg.png'),
              ),
            ),
          ),
          Container(
            child: Text(
              "How can we help you?",
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          listTail(
              "Fire Department",
              FaIcon(
                FontAwesomeIcons.fireExtinguisher,
                size: 40,
              )),
          Divider(),
          listTail(
              "Police Department",
              FaIcon(
                FontAwesomeIcons.hardHat,
                size: 40,
              )),
          Divider(),
          listTail(
              "Medical Emergency",
              FaIcon(
                FontAwesomeIcons.clinicMedical,
                size: 40,
              )),
        ],
      ),
    );
  }

  Widget listTail(text, icon) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      trailing: icon,
    );
  }
}
