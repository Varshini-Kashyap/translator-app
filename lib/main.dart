import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';


void main()
{
  runApp(
      MaterialApp(
        home: App(),
      )
  );

}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  GoogleTranslator translator = new GoogleTranslator();   //using google translator
  final FlutterTts tts=FlutterTts();
  Home() {
    tts.setLanguage('en');
    tts.setSpeechRate(0.4);
  }
    var out;
    final lang = TextEditingController();

  var dropdownValue;
  static const Map<String, String> translate = {
    "English": "en",
    "Hindi": "hi",
    "kannada": "kn",
    "Tamil":"ta",
    "Telugu":"te",
    "Malayalam": "ml",
    "Urdu": "ur",
    "Gujurati":"gu",
    "Bihari":"bi",
    "Chinese": "zh-hk",
    "French": "fr",
    "Arabic": "ar-eq",
    "Spanish": "es-ar",
    "korean": "ko"
  };//getting text


  void trans()
  {

    translator.translate(lang.text, to: '$dropdownValue')
        .then((output)
    {
      setState(() {
        out=output;                          //placing the translated text to the String to be used
      });
      print(out);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Language translator"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Container(
        child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/trans.jpg",
                  width: 200,
                  height: 150,

                  ),
                ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                       labelText: "Type here",
                      ),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: lang,
                    ),
                  ),
                     DropdownButton<String>(
                      value: dropdownValue,
                      style: TextStyle(color:Colors.deepPurple,
                      fontSize: 20
                      ),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,

                      ),
                      onChanged: (String? newValue){
                        setState(() {
                          dropdownValue=newValue!;
                          trans();
                        });
                      },
                      hint: Text("Select language"),
                      items: translate
                      .map((string, value){
                        return MapEntry(
                          string,
                            DropdownMenuItem<String>(
                            value: value,
                            child: Text(string),
                            ),
                            );
                      }).values
                          .toList(),

              ),


                  SizedBox(
                      height: 30,
                  ),
                  Text("Translated text",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
    out == null ? " " : out.toString(),
    style: TextStyle(
    fontSize: 25,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w500),
    ),
            IconButton(
            icon: Icon(
              Icons.mic,
            ),
            iconSize: 30,
            onPressed: (){
              tts.speak(out.text);
            },
          ),

    ],


    ),

            ),

    ),

      ),

    );


  }
}


