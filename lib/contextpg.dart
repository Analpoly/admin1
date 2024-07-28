// import 'package:admin1/detail.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';

// class MyImageWidget extends StatefulWidget {
//   final String itemName;

//   MyImageWidget({required this.itemName});

//   @override
//   _MyImageWidgetState createState() => _MyImageWidgetState();
// }

// class _MyImageWidgetState extends State<MyImageWidget> {
//   late Future<String> _imageUrl;

//   @override
//   void initState() {
//     super.initState();
//     _imageUrl = _getImageUrl(widget.itemName);
//   }

//   Future<String> _getImageUrl(String itemName) async {
//     final ref = FirebaseStorage.instance.ref().child('PhotoDatabase/2024-07-26/user/$itemName.jpg');
//     return await ref.getDownloadURL();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [],
//         title: Text(widget.itemName),
//       ),
//       body: Center(
//         child: FutureBuilder<String>(
//           future: _imageUrl,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else if (!snapshot.hasData) {
//               return Text('No image found');
//             } else {
//               return Image.network(snapshot.data!);
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// class Contextpg extends StatelessWidget {
//   final List<String> items = [
//     'ATHAM',
//     'CHITHIRA',
//     'CHODHI',
//     'VISHAKAM',
//     'ANIZHAM',
//     'THRIKETA',
//     'MOOLAM',
//     'POORADAM',
//     'UTHRADAM',
//     'THIRUVONAM',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Items'),
//       ),
//       body: ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => FetchDataPage(

//                   ),
//                 ),
//               );
//             },
//             child: Container(
//               margin: EdgeInsets.all(8.0),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.pinkAccent, Colors.purpleAccent],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: ListTile(
//                 title: Center(
//                   child: Text(
//                     items[index],
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:admin1/contextdate.dart';
import 'package:admin1/detail.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MyImageWidget extends StatefulWidget {
  final String itemName;

  MyImageWidget({required this.itemName});

  @override
  _MyImageWidgetState createState() => _MyImageWidgetState();
}

class _MyImageWidgetState extends State<MyImageWidget> {
  late Future<String> _imageUrl;

  @override
  void initState() {
    super.initState();
    _imageUrl = _getImageUrl(widget.itemName);
  }

  Future<String> _getImageUrl(String itemName) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('PhotoDatabase/2024-07-26/user/$itemName.jpg');
    return await ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(widget.itemName),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: _imageUrl,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return Text('No image found');
            } else {
              return Image.network(snapshot.data!);
            }
          },
        ),
      ),
    );
  }
}

class Contextpg extends StatelessWidget {
  final List<String> items = [
    'ATHAM',
    'CHITHIRA',
    'CHODHI',
    'VISHAKAM',
    'ANIZHAM',
    'THRIKETA',
    'MOOLAM',
    'POORADAM',
    'UTHRADAM',
    'THIRUVONAM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AdminDateSetterScreen();
                    });
              },
              icon: Icon(Icons.add))
        ],
        title: Text('Items'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FetchDataPage(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pinkAccent, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Center(
                  child: Text(
                    items[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
