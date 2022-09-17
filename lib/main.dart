import 'package:dictionary_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:dictionary_app/services/service.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'package:dictionary_app/services/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dictionary App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Dictionary App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AudioPlayer audioPlayer =
      AudioPlayer(); // Play audio from local device and online

  //Dictionary Object/instance
  DictionaryService dictionaryService = DictionaryService();

  //TextEditing controller- for text manipulation
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      audioPlayer = AudioPlayer(); //Audio player Instance
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    audioPlayer.dispose();
  }

  //Function to play pronunciation from Dictionary API
  void playAudio(String audio) {
    audioPlayer.stop();
    audioPlayer.play(audio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      //body shoes list view
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: MediaQuery.of(context).size.height,
        //color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        decoration: const InputDecoration(
                          label: Text('Search any word'),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    //Search Button
                    IconButton(
                      //Does automatic re-rendering
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          setState(() {});
                        }
                      },
                      icon: const Icon(Icons.search),
                    ),
                    //Cancle Button
                    IconButton(
                      onPressed: () {
                        //Does automatic re-rendering
                        setState(() {
                          controller.clear();
                        });
                      },
                      icon: const Icon(Icons.cancel_outlined),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              controller.text.isEmpty
                  ? const SizedBox(child: Text('Search a term'))
                  : FutureBuilder(
                      future:
                          dictionaryService.getMeaning(word: controller.text),
                      builder: (context,
                          AsyncSnapshot<List<DictionaryModel>> snapshot) {
                        print("Data snapshot : $snapshot");
                        if (snapshot.hasData) {
                          return ListView(
                            shrinkWrap: true,
                            children: List.generate(
                              snapshot.data!.length,
                              (index) {
                                final data = snapshot.data![index];
                                return Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        child: ListTile(
                                          tileColor: const Color(0xFFE2E2E2),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                          ),
                                          title: Text(data.word!),
                                          subtitle: Text(
                                            data.phonetics![index].text!,
                                          ),
                                          //Audio
                                          trailing: IconButton(
                                            icon: Icon(
                                              Icons.volume_up,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            onPressed: () {
                                              String? audio =
                                                  data.phonetics![index].audio;
                                              //print(path);
                                              //playAudio(audio!);
                                              playAudio("https:$audio");
                                            },
                                          ),
                                          // isThreeLine: true,
                                        ),
                                      ),
                                      Container(
                                        child: ListTile(
                                          tileColor: const Color(0xFFE2E2E2),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          title: Text(data.meanings![index]
                                              .definitions![index].definition!),
                                          subtitle: Text(data
                                              .meanings![index].partOfSpeech!),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
