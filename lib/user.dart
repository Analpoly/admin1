// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';

// class DetailScreen extends StatelessWidget {
//   final String imageUrl;
//   final String userName;

//   DetailScreen({required this.imageUrl, required this.userName});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(userName)),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: PhotoView(
//                 imageProvider: NetworkImage(imageUrl),
//                 backgroundDecoration: BoxDecoration(color: Colors.white),
//                 minScale: PhotoViewComputedScale.contained,
//                 maxScale: PhotoViewComputedScale.covered * 2.0,
//                 enableRotation: false,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_view/photo_view.dart';

class DetailScreen  extends StatelessWidget {
  final String imageUrl;
  final String userName;

  DetailScreen({required this.imageUrl, required this.userName,});

  Future<Map<String, dynamic>?> _fetchUserDetails() async {
    try {
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('RegisterDatabase');
      QuerySnapshot query = await usersCollection.where('username', isEqualTo: userName).get();
      if (query.docs.isNotEmpty) {
        DocumentSnapshot doc = query.docs.first;
        return doc.data() as Map<String, dynamic>;
      } else {
        print('No user found with mobile number: $userName');
        return null;
      }
    } catch (e) {
      print('Error fetching user details: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Details')),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _fetchUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('User not found'));
          } else {
            final userData = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: PhotoView(
                      imageProvider: NetworkImage(imageUrl),
                      backgroundDecoration: BoxDecoration(color: Colors.white),
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 2.0,
                      enableRotation: false,
                    ),
                  ),
                  Text('Username: ${userData['username']}'),
                  Text('Mobile Number: ${userData['mobilenumber']}'),
                  Text('House Number: ${userData['housenumber']}'),
                  Text('Building Name: ${userData['buildingname']}'),
                  Text('Street: ${userData['street']}'),
                  Text('Place: ${userData['place']}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
