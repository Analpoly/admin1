// import 'package:admin1/shopping_app/lib/firebase_options.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:validators/validators.dart' as validator;

// class FetchDataPage extends StatelessWidget {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Fetch Data from Firestore')),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _firestore.collection('/PhotoDatabase/2024-07-26/user').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(child: Text('No Data Found'));
//           }
//           final data = snapshot.data!.docs;

//           return ListView.builder(
//             itemCount: data.length,
//             itemBuilder: (context, index) {
//               var doc = data[index].data() as Map<String, dynamic>;
//               var imageUrl = doc['imageUrl'];
//               var user = doc['user'] ?? 'No user';

//               return ListTile(
//                 leading: imageUrl != null && validator.isURL(imageUrl )
//                     ? SizedBox(
//                         width: 50,
//                         height: 50,
//                         child: Image.network(
//                           imageUrl,
//                           fit: BoxFit.cover,
//                         ),
//                       )
//                     : Icon(Icons.image_not_supported),
//                 title: Text(user),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:validators/validators.dart' as validator;
// import 'package:intl/intl.dart';

// class FetchDataPage extends StatelessWidget {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     String gettdate() {
//       DateTime days = DateTime.now();
//       return DateFormat('yyyy-MM-dd').format(days);
//     }

//     String data = gettdate();
//     return Scaffold(
//       appBar: AppBar(title: Text('Fetch Data from Firestore')),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _firestore.collection('PhotoDatabase/$data/user').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(child: Text('No Data Found'));
//           }
//           final data = snapshot.data!.docs;

//           return ListView.builder(
//             itemCount: data.length,
//             itemBuilder: (context, index) {
//               try {
//                 var doc = data[index].data() as Map<String, dynamic>;
//                 var imageUrl = doc['imageUrl'] as String?;
//                 var userName = doc['user'] as String? ?? 'No user';

//                 if (imageUrl != null && validator.isURL(imageUrl)) {
//                   return ListTile(
//                     leading: SizedBox(
//                       width: 50,
//                       height: 50,
//                       child: Image.network(
//                         imageUrl,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     title: Text(userName),
//                   );
//                 } else {
//                   return ListTile(
//                     leading: Icon(Icons.image_not_supported),
//                     title: Text(userName),
//                   );
//                 }
//               } catch (e) {
//                 print('Error processing document: $e');
//                 return ListTile(
//                   leading: Icon(Icons.error),
//                   title: Text('Error loading item'),
//                 );
//               }
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:validators/validators.dart' as validator;

class FetchDataPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fetch Data from Firestore')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collectionGroup('CHITHIRA').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No Data Found'));
          }
          final data = snapshot.data!.docs;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              try {
                var doc = data[index].data() as Map<String, dynamic>;
                var imageUrl = doc['imageUrl'] as String?;
                var userName = doc['username'] as String? ?? 'No user';

                if (imageUrl != null && validator.isURL(imageUrl)) {
                  return ListTile(
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(userName),
                  );
                } else {
                  return ListTile(
                    leading: Icon(Icons.image_not_supported),
                    title: Text(userName),
                  );
                }
              } catch (e) {
                print('Error processing document: $e');
                return ListTile(
                  leading: Icon(Icons.error),
                  title: Text('Error loading item'),
                );
              }
            },
          );
        },
      ),
    );
  }
}
