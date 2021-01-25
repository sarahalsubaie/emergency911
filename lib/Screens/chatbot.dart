import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Chatbot extends StatefulWidget {
  final String dep;

  const Chatbot({Key key, this.dep}) : super(key: key);
  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  TextEditingController controllerText = TextEditingController();
  bool texting = false;
  bool runFunction = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.dep),
      ),
      body: Column(
        children: [
          Expanded(child: Text("Here Message Will be")),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(color: Colors.white),
              controller: controllerText,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.greenAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                suffixIcon: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.solidPaperPlane,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
                prefixIcon: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.microphoneAlt,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                ),
                hintText: 'Type here...',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
