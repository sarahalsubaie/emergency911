import 'package:emergancy/Screens/Registration.dart';
import 'package:flutter/material.dart';

class PickALanguage extends StatelessWidget {
  final List<String> lang = [
    'Arabic',
    'English',
    'Chinese',
    'French',
    'German',
    'Italian',
    'Japanes',
    'Korean',
    'Portuges',
    'Russian',
    'Spanish',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          Text("AVAILABLE OFFLINE LANGUAGE"),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.75,
            child: ListView.separated(
                itemBuilder: (context, i) {
                  return ListTile(
                    onTap: () {
                      if (lang[i] == 'English') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Registration(lang: lang[i])),
                        );
                      }
                    },
                    title: Text(lang[i]),
                    trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios), onPressed: null),
                  );
                },
                separatorBuilder: (context, i) {
                  return Divider();
                },
                itemCount: lang.length),
          )
        ],
      ),
    );
  }
}
