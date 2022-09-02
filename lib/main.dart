// import 'package:flutter/material.dart';
// import 'package:dictionary_app/services/service.dart';
// // import 'package:dictionary_app/services/services.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Dictionary App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Dictionary App'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   //int _counter = 0;

//   // void _incrementCounter() {
//   //   setState(() {
//   //     _counter++;
//   //   });
//   // }

//   DictionaryService dictionaryService = DictionaryService();

//   TextEditingController controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         centerTitle: true,
//       ),
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: Container(
//               padding: const EdgeInsets.all(10),
//               height: MediaQuery.of(context).size.height,
//               //color: Colors.green,
//               child: Column(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Row(
//                       children: [
//                         TextFormField(
//                           controller: controller,
//                           decoration: const InputDecoration(
//                             label: Text('Search Query'),
//                             border: InputBorder.none,
//                           ),
//                         ),
//                         IconButton(
//                             onPressed: () async {
//                               await dictionaryService.getMeaning(
//                                   word: controller.text);
//                             },
//                             icon: const Icon(Icons.search))
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   controller.text.isEmpty
//                       ? const SizedBox(child: Text('Search a term'))
//                       : FutureBuilder(
//                           future: dictionaryService.getMeaning(
//                               word: controller.text),
//                           builder: (context, snapshot) {
//                             return  const Text('chortle my balls');
//                             // if(snapshot.hasData){
//                             //   return Expanded
//                             // }
//                           },
//                         ), 
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),

//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: _incrementCounter,
//       //   tooltip: 'Increment',
//       //   child: const Icon(Icons.add),
//       // ),
//     );
//   }
// }
