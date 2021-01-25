import 'package:emergancy/Screens/StartScreen.dart';
import 'package:flutter/material.dart';
import 'package:watson_assistant_v2/watson_assistant_v2.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StartScreen(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String _text;
//   WatsonAssistantV2Credential credential = WatsonAssistantV2Credential(
//     apikey: '1Yd3UTq24zVxo1moo2RIRocHH6dC5f_eXL3MlnyRc9Tq',
//     assistantID: '14dc2892-47f6-43c2-a87c-bb6b3b17f497',
//     url:
//         'https://api.au-syd.assistant.watson.cloud.ibm.com/instances/25ff5db0-79da-4c6b-b7d3-7055c0ccb622/v2',
//   );

//   WatsonAssistantApiV2 watsonAssistant;
//   WatsonAssistantResponse watsonAssistantResponse;
//   WatsonAssistantContext watsonAssistantContext =
//       WatsonAssistantContext(context: {});

//   final myController = TextEditingController();

//   void _callWatsonAssistant() async {
//     watsonAssistantResponse = await watsonAssistant.sendMessage(
//         myController.text, watsonAssistantContext);
//     setState(() {
//       _text = watsonAssistantResponse.resultText;
//     });
//     watsonAssistantContext = watsonAssistantResponse.context;
//     myController.clear();
//   }

//   @override
//   void initState() {
//     super.initState();
//     watsonAssistant =
//         WatsonAssistantApiV2(watsonAssistantCredential: credential);
//     _callWatsonAssistant();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Watson_Assistant_V2'),
//         centerTitle: true,
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.restore,
//             ),
//             onPressed: () {
//               watsonAssistantContext.resetContext();
//               setState(() {
//                 _text = null;
//               });
//             },
//           )
//         ],
//       ),
//       body: Scaffold(
//         backgroundColor: Colors.white,
//         body: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               TextField(
//                 controller: myController,
//                 decoration: InputDecoration(
//                   hintText: 'Your Input to the chatbot',
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide:
//                         BorderSide(color: Colors.lightBlueAccent, width: 1.0),
//                     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide:
//                         BorderSide(color: Colors.lightBlueAccent, width: 2.0),
//                     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 8.0,
//               ),
//               Text(
//                 _text != null ? '$_text' : 'Watson Response Here',
//                 style: Theme.of(context).textTheme.display1,
//               ),
//               SizedBox(
//                 height: 24.0,
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _callWatsonAssistant,
//         child: Icon(Icons.send),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     myController.dispose();
//     super.dispose();
//   }
// }
