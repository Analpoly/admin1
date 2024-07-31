// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AdminScreen extends StatefulWidget {
//   @override
//   _AdminScreenState createState() => _AdminScreenState();
// }

// class _AdminScreenState extends State<AdminScreen> {
//   bool _isChatEnabled = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchChatStatus();
//   }

//   Future<void> _fetchChatStatus() async {
//     DocumentSnapshot chatStatusDoc = await FirebaseFirestore.instance
//         .collection('settings')
//         .doc('chat_status')
//         .get();

//     setState(() {
//       _isChatEnabled = chatStatusDoc['isEnabled'];
//     });
//   }

//   void _toggleChatStatus() async {
//     setState(() {
//       _isChatEnabled = !_isChatEnabled;
//     });

//     await FirebaseFirestore.instance
//         .collection('settings')
//         .doc('chat_status')
//         .update({'isEnabled': _isChatEnabled});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Admin Panel'),
//       ),
//       body: Column(
//         children: [
//           SwitchListTile(
//             title: Text('Enable Chat'),
//             value: _isChatEnabled,
//             onChanged: (bool value) {
//               _toggleChatStatus();
//             },
//           ),
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('community_chat')
//                   .orderBy('timestamp')
//                   .snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 var messages = snapshot.data!.docs;
//                 return ListView.builder(
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     var message = messages[index];
//                     return ListTile(
//                       title: Text(message['sender']),
//                       subtitle: message['imageUrl'] != null
//                           ? Image.network(message['imageUrl'])
//                           : Text(message['text']),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             message['timestamp'] != null
//                                 ? (message['timestamp'] as Timestamp)
//                                     .toDate()
//                                     .toString()
//                                 : '',
//                             style: TextStyle(fontSize: 10, color: Colors.grey),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.delete, color: Colors.red),
//                             onPressed: () => _deleteMessage(message.id),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _deleteMessage(String messageId) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('community_chat')
//           .doc(messageId)
//           .delete();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Message deleted')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to delete message: $e')),
//       );
//     }
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AdminChatControlScreen extends StatefulWidget {
//   @override
//   _AdminChatControlScreenState createState() => _AdminChatControlScreenState();
// }

// class _AdminChatControlScreenState extends State<AdminChatControlScreen> {
//   bool _isChatEnabled = false;

//   @override
//   void initState() {
//     super.initState();
//     _fetchChatStatus();
//   }

//   void _fetchChatStatus() async {
//     DocumentSnapshot chatStatusDoc = await FirebaseFirestore.instance
//         .collection('admin_settings')
//         .doc('chat_status')
//         .get();
//     if (chatStatusDoc.exists) {
//       setState(() {
//         _isChatEnabled = chatStatusDoc['enabled'];
//       });
//     }
//   }

//   void _toggleChatStatus(bool isEnabled) async {
//     setState(() {
//       _isChatEnabled = isEnabled;
//     });
//     await FirebaseFirestore.instance
//         .collection('admin_settings')
//         .doc('chat_status')
//         .set({'enabled': isEnabled});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Admin Chat Control'),
//         ),
//         body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(children: [
//               SwitchListTile(
//                 title: Text('Enable Chat'),
//                 value: _isChatEnabled,
//                 onChanged: _toggleChatStatus,
//               ),
//               Expanded(
//                   child: StreamBuilder(
//                       stream: FirebaseFirestore.instance
//                           .collection('community_chat')
//                           .orderBy('timestamp')
//                           .snapshots(),
//                       builder:
//                           (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                         if (!snapshot.hasData) {
//                           return Center(child: CircularProgressIndicator());
//                         }
//                         var messages = snapshot.data!.docs;
//                         return ListView.builder(
//                           itemCount: messages.length,
//                           itemBuilder: (context, index) {
//                             var message = messages[index];
//                             return ListTile(
//                               title: Text(message['sender']),
//                               subtitle: message['imageUrl'] != null
//                                   ? Image.network(message['imageUrl'])
//                                   : Text(message['text']),
//                               trailing: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Text(
//                                     message['timestamp'] != null
//                                         ? (message['timestamp'] as Timestamp)
//                                             .toDate()
//                                             .toString()
//                                         : '',
//                                     style: TextStyle(
//                                         fontSize: 10, color: Colors.grey),
//                                   ),
//                                   IconButton(
//                                     icon: Icon(Icons.delete, color: Colors.red),
//                                     onPressed: () => _deleteMessage(message.id),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         );
//                       }))
//             ])));
//   }

//   void _deleteMessage(String messageId) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('community_chat')
//           .doc(messageId)
//           .delete();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Message deleted')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to delete message: $e')),
//       );
//     }
//   }
// }

import 'dart:io';
import 'package:admin1/chatdesign.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminChatScreen extends StatefulWidget {
  @override
  _AdminChatScreenState createState() => _AdminChatScreenState();
}

class _AdminChatScreenState extends State<AdminChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;
  bool _chatEnabled = false;
  String _adminUsername = '';

  @override
  void initState() {
    super.initState();
    _fetchChatStatus();
    _loadAdminUsername();
  }

  Future<void> _fetchChatStatus() async {
    DocumentSnapshot chatStatusDoc = await FirebaseFirestore.instance
        .collection('admin_settings')
        .doc('chat_status')
        .get();
    if (chatStatusDoc.exists) {
      setState(() {
        _chatEnabled = chatStatusDoc['enabled'];
      });
    }
  }

  Future<void> _loadAdminUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _adminUsername = prefs.getString('adminUsername') ?? '';
    });
  }

  Future<void> _saveAdminUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('adminUsername', username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 8),
            Expanded(
              child: Text(
                "Admin Chat",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('community_chat')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                var messages = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    bool checkuser = message['sender'] == _adminUsername;
                    return Container(
                      alignment: checkuser
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: checkuser
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        mainAxisAlignment: checkuser
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Text(message['sender']),
                          message['imageUrl'] != null
                              ? Image.network(
                                  message['imageUrl'],
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                )
                              : Chatdesign(
                                  message: message['text'],
                                ),
                          IconButton(
                              onPressed: () {
                                delete(message.id);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red[200],
                              ))
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          if (_isUploading) CircularProgressIndicator(),
          if (_chatEnabled)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.photo),
                    onPressed: _pickImage,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration:
                          InputDecoration(hintText: 'Send a message...'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('community_chat').add({
          'text': _messageController.text,
          'sender': _adminUsername,
          'timestamp': FieldValue.serverTimestamp(),
          'imageUrl': null,
        });
        _messageController.clear();
      } catch (e) {
        print('Error sending message: $e');
      }
    }
  }

  void _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      _uploadImage(image);
    }
  }

  Future<void> _uploadImage(File image) async {
    setState(() {
      _isUploading = true;
    });

    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('uploads/$fileName');
      UploadTask uploadTask = storageReference.putFile(image);
      await uploadTask;
      String imageUrl = await storageReference.getDownloadURL();
      await FirebaseFirestore.instance.collection('community_chat').add({
        'text': null,
        'sender': _adminUsername,
        'timestamp': FieldValue.serverTimestamp(),
        'imageUrl': imageUrl,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image upload successful!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void delete(String messageId) {
    try {
      FirebaseFirestore.instance
          .collection('community_chat')
          .doc(messageId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Message deleted')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete message: $e')),
      );
    }
  }
}
