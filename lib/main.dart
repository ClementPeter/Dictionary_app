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
  //int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  AudioPlayer audioPlayer =
      AudioPlayer(); // Play audio from local device and online

  DictionaryService dictionaryService = DictionaryService();

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
    controller.dispose();
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              height: MediaQuery.of(context).size.height,
              //color: Colors.green,
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
                        IconButton(
                            onPressed: () async {
                              await dictionaryService.getMeaning(
                                word: controller.text,
                              );
                            },
                            icon: const Icon(Icons.search))
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  controller.text.isEmpty
                      ? const SizedBox(child: Text('Search a term'))
                      // : const SizedBox(child: Text('a term'))
                      : FutureBuilder(
                          future: dictionaryService.getMeaning(
                              word: controller.text),
                          builder: (context,
                              AsyncSnapshot<List<DictionaryModel>> snapshot) {
                            if (snapshot.hasData) {
                              return Expanded(
                                child: ListView(
                                  children: List.generate(snapshot.data!.length,
                                      (index) {
                                    final data = snapshot.data![index];
                                    return Column(
                                      children: [
                                        Container(
                                          //color: Colors.grey,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE2E2E2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ListTile(
                                            leading: Text(data.word!),
                                            title: Text(
                                              data
                                                  .meanings![index]
                                                  .definitions![index]
                                                  .definition!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            subtitle: Text(
                                                data.phonetics![index].text!),
                                            trailing: IconButton(
                                              icon: Icon(
                                                Icons.volume_up,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              onPressed: () {
                                                String? audio = data
                                                    .phonetics![index].audio!;
                                                //print(path);
                                                playAudio(audio);
                                              },

                                              //isThreeLine: true,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                ],
              ),
            ),
          ),
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
