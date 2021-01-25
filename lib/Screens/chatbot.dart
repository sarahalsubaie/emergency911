import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:watson_assistant_v2/watson_assistant_v2.dart';

class Chatbot extends StatefulWidget {
  final String dep;
  final String id;
  const Chatbot({Key key, this.dep, this.id}) : super(key: key);
  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  TextEditingController controllerText = TextEditingController();
  bool texting = false;
  bool runFunction = true;
//------------------------
  String _text;
  WatsonAssistantV2Credential credential = WatsonAssistantV2Credential(
    apikey: '1Yd3UTq24zVxo1moo2RIRocHH6dC5f_eXL3MlnyRc9Tq',
    assistantID: '14dc2892-47f6-43c2-a87c-bb6b3b17f497',
    url:
        'https://api.au-syd.assistant.watson.cloud.ibm.com/instances/25ff5db0-79da-4c6b-b7d3-7055c0ccb622/v2',
  );
  WatsonAssistantApiV2 watsonAssistant;
  WatsonAssistantResponse watsonAssistantResponse;
  WatsonAssistantContext watsonAssistantContext =
      WatsonAssistantContext(context: {});

  Future<void> _callWatsonAssistant() async {
    watsonAssistantResponse = await watsonAssistant.sendMessage(
        controllerText.text, watsonAssistantContext);
    setState(() {
      _text = watsonAssistantResponse.resultText;
    });
    watsonAssistantContext = watsonAssistantResponse.context;
  }

  @override
  void initState() {
    super.initState();
    watsonAssistant =
        WatsonAssistantApiV2(watsonAssistantCredential: credential);
    _callWatsonAssistant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.dep),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("chat")
                    .where('id', isEqualTo: widget.id)
                    .where('department', isEqualTo: widget.dep)
                    .orderBy('time')
                    .snapshots(),
                builder: (context, stream) {
                  if (stream.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (stream.hasError) {
                    return Center(child: Text(stream.error.toString()));
                  }
                  QuerySnapshot querySnapshot = stream.data;
                  return ListView.builder(
                    itemCount: querySnapshot.size,
                    itemBuilder: (context, i) {
                      return querySnapshot.docs[i].data()['me']
                          ? Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 64.0),
                                child: Container(
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                      color: Colors.blue[200],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child:
                                      Text(querySnapshot.docs[i].data()['msg']),
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 64.0),
                                child: Container(
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child:
                                      Text(querySnapshot.docs[i].data()['msg']),
                                ),
                              ),
                            );
                    },
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(color: Colors.black),
              controller: controllerText,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.greenAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                suffixIcon: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.solidPaperPlane,
                      color: Colors.black,
                    ),
                    onPressed: () async {
                      Map<String, dynamic> sendMsg = {
                        'time': DateTime.now(),
                        'msg': controllerText.text,
                        'department': widget.dep,
                        'id': widget.id,
                        'me': true,
                      };
                      await FirebaseFirestore.instance
                          .collection('chat')
                          .add(sendMsg);
                      await _callWatsonAssistant();
                      Map<String, dynamic> botMsg = {
                        'time': DateTime.now(),
                        'msg': _text,
                        'department': widget.dep,
                        'id': widget.id,
                        'me': false,
                      };
                      await FirebaseFirestore.instance
                          .collection('chat')
                          .add(botMsg);
                      controllerText.clear();
                    }),
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
