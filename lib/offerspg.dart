// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:permission_handler/permission_handler.dart';


// class ItemForm extends StatefulWidget {
//   final Function(Item) onAddItem;

//   ItemForm({required this.onAddItem});

//   @override
//   _ItemFormState createState() => _ItemFormState();
// }

// class _ItemFormState extends State<ItemForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _originalPriceController = TextEditingController();
//   final _discountedPriceController = TextEditingController();
//   final _offerController = TextEditingController();
//   XFile? _imageFile;
//   final ImagePicker _picker = ImagePicker();

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _descriptionController.dispose();
//     _originalPriceController.dispose();
//     _discountedPriceController.dispose();
//     _offerController.dispose();
//     super.dispose();
//   }

//   Future<void> _requestPermissions() async {
//     await [Permission.camera, Permission.storage].request();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _requestPermissions();
//   }

//   Future<void> _pickImage(ImageSource source) async {
//     try {
//       final pickedFile = await _picker.pickImage(source: source);
//       setState(() {
//         _imageFile = pickedFile;
//       });
//     } catch (e) {
//       print('Image pick error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to pick image: $e')),
//       );
//     }
//   }

//   Future<String> _uploadImage(XFile imageFile) async {
//     try {
//       final fileName = imageFile.name;
//       final ref = FirebaseStorage.instance.ref().child('item_images/$fileName');
//       final uploadTask = ref.putFile(File(imageFile.path));
//       final snapshot = await uploadTask;
//       return await snapshot.ref.getDownloadURL();
//     } catch (e) {
//       print('Image upload error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to upload image: $e')),
//       );
//       rethrow;
//     }
//   }

//   void _submitForm() async {
//     if (_formKey.currentState!.validate() && _imageFile != null) {
//       try {
//         final imageUrl = await _uploadImage(_imageFile!);
//         final newItem = Item(
//           name: _nameController.text,
//           description: _descriptionController.text,
//           originalPrice: int.parse(_originalPriceController.text),
//           discountedPrice: int.parse(_discountedPriceController.text),
//           imageUrl: imageUrl,
//           offer: _offerController.text,
//         );

//         widget.onAddItem(newItem);
//         Navigator.of(context).pop();
//       } catch (e) {
//         print('Form submission error: $e');
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please fill all fields and pick an image.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Add Item'),
//       content: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: 'Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _descriptionController,
//                 decoration: InputDecoration(labelText: 'Description'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a description';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _originalPriceController,
//                 decoration: InputDecoration(labelText: 'Original Price'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the original price';
//                   }
//                   if (int.tryParse(value) == null) {
//                     return 'Please enter a valid number';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _discountedPriceController,
//                 decoration: InputDecoration(labelText: 'Discounted Price'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the discounted price';
//                   }
//                   if (int.tryParse(value) == null) {
//                     return 'Please enter a valid number';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _offerController,
//                 decoration: InputDecoration(labelText: 'Offer'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the offer';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               _imageFile == null
//                   ? Text('No image selected.')
//                   : Image.file(File(_imageFile!.path), height: 100),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () => _pickImage(ImageSource.camera),
//                     child: Text('Camera'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () => _pickImage(ImageSource.gallery),
//                     child: Text('Gallery'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: _submitForm,
//           child: Text('Add'),
//         ),
//       ],
//     );
//   }
// }

// // ------------------------------------------------------------------------------------------

// class OffersPage extends StatefulWidget {
//   @override
//   _OffersPageState createState() => _OffersPageState();
// }

// class _OffersPageState extends State<OffersPage> {
//   final List<Item> items = [];

//   void _addItem(Item item) {
//     FirebaseFirestore.instance.collection('items').add(item.toMap());
//     setState(() {
//       items.add(item);
//     });
//   }

//   void _showItemForm() {
//     showDialog(
//       context: context,
//       builder: (context) => ItemForm(onAddItem: _addItem),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Offers'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: _showItemForm,
//           ),
//         ],
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('items').snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }

//           final items = snapshot.data!.docs.map((doc) {
//             return Item.fromMap(doc.data() as Map<String, dynamic>);
//           }).toList();

//           return ListView.builder(
//             itemCount: items.length,
//             itemBuilder: (context, index) {
//               final item = items[index];
//               return ListTile(
//                 leading: item.imageUrl.isNotEmpty
//                     ? Image.network(item.imageUrl)
//                     : null,
//                 title: Text(item.name),
//                 subtitle: Text(item.description),
//                 trailing: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text('₹${item.discountedPrice}'),
//                     Text(
//                       '₹${item.originalPrice}',
//                       style: TextStyle(
//                         color: Colors.red,
//                         decoration: TextDecoration.lineThrough,
//                       ),
//                     ),
//                     Text(item.offer),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
// // ------------------------------------------------------------------------------------------------
// class Item {
//   final String name;
//   final String description;
//   final int originalPrice;
//   final int discountedPrice;
//   final String imageUrl;
//   final String offer;

//   Item({
//     required this.name,
//     required this.description,
//     required this.originalPrice,
//     required this.discountedPrice,
//     required this.imageUrl,
//     required this.offer,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'description': description,
//       'originalPrice': originalPrice,
//       'discountedPrice': discountedPrice,
//       'imageUrl': imageUrl,
//       'offer': offer,
//     };
//   }

//   factory Item.fromMap(Map<String, dynamic> map) {
//     return Item(
//       name: map['name'],
//       description: map['description'],
//       originalPrice: map['originalPrice'],
//       discountedPrice: map['discountedPrice'],
//       imageUrl: map['imageUrl'],
//       offer: map['offer'],
//     );
//   }
// }
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class ItemForm extends StatefulWidget {
  final Function(Item) onAddItem;
  final Item? item;

  ItemForm({required this.onAddItem, this.item});

  @override
  _ItemFormState createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _originalPriceController;
  late TextEditingController _discountedPriceController;
  late TextEditingController _offerController;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _descriptionController = TextEditingController(text: widget.item?.description ?? '');
    _originalPriceController = TextEditingController(text: widget.item?.originalPrice.toString() ?? '');
    _discountedPriceController = TextEditingController(text: widget.item?.discountedPrice.toString() ?? '');
    _offerController = TextEditingController(text: widget.item?.offer ?? '');
    _requestPermissions();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _originalPriceController.dispose();
    _discountedPriceController.dispose();
    _offerController.dispose();
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    await [Permission.camera, Permission.storage].request();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      print('Image pick error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  Future<String> _uploadImage(XFile imageFile) async {
    try {
      final fileName = imageFile.name;
      final ref = FirebaseStorage.instance.ref().child('item_images/$fileName');
      final uploadTask = ref.putFile(File(imageFile.path));
      final snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Image upload error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
      rethrow;
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() && (_imageFile != null || widget.item?.imageUrl != null)) {
      try {
        String imageUrl;
        if (_imageFile != null) {
          imageUrl = await _uploadImage(_imageFile!);
        } else {
          imageUrl = widget.item!.imageUrl;
        }
        final newItem = Item(
          id: widget.item?.id ?? '',
          name: _nameController.text,
          description: _descriptionController.text,
          originalPrice: int.parse(_originalPriceController.text),
          discountedPrice: int.parse(_discountedPriceController.text),
          imageUrl: imageUrl,
          offer: _offerController.text,
         
        );

        widget.onAddItem(newItem);
        Navigator.of(context).pop();
      } catch (e) {
        print('Form submission error: $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields and pick an image.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.item == null ? 'Add Item' : 'Edit Item'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _originalPriceController,
                decoration: InputDecoration(labelText: 'Original Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the original price';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _discountedPriceController,
                decoration: InputDecoration(labelText: 'Discounted Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the discounted price';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _offerController,
                decoration: InputDecoration(labelText: 'Offer'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the offer';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              _imageFile == null && widget.item?.imageUrl == null
                  ? Text('No image selected.')
                  : _imageFile != null
                      ? Image.file(File(_imageFile!.path), height: 100)
                      : Image.network(widget.item!.imageUrl, height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.camera),
                    child: Text('Camera'),
                  ),
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    child: Text('Gallery'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: Text(widget.item == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }
}

// ------------------------------------------------------------------------------------------

class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  final List<Item> items = [];

  void _addItem(Item item) {
    if (item.id.isEmpty) {
      // Adding a new item
      FirebaseFirestore.instance.collection('items').add(item.toMap()).then((doc) {
        setState(() {
          items.add(Item(
            id: doc.id,
            name: item.name,
            description: item.description,
            originalPrice: item.originalPrice,
            discountedPrice: item.discountedPrice,
            imageUrl: item.imageUrl,
            offer: item.offer,
          ));
        });
      });
    } else {
      // Updating an existing item
      FirebaseFirestore.instance.collection('items').doc(item.id).update(item.toMap()).then((_) {
        setState(() {
          final index = items.indexWhere((i) => i.id == item.id);
          if (index != -1) {
            items[index] = item;
          }
        });
      });
    }
  }

  void _showItemForm([Item? item]) {
    showDialog(
      context: context,
      builder: (context) => ItemForm(onAddItem: _addItem, item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offers'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showItemForm(),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final items = snapshot.data!.docs.map((doc) {
            return Item.fromMap(doc.data() as Map<String, dynamic>, doc.id);
          }).toList();

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                leading: item.imageUrl.isNotEmpty ? Image.network(item.imageUrl) : null,
                title: Text(item.name),
                subtitle: Text(item.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                   
                  
                  ],
                ),
                onTap: () => _showItemForm(item),
              );
            },
          );
        },
      ),
    );
  }
}

// ------------------------------------------------------------------------------------------

class Item {
  final String id;
  final String name;
  final String description;
  final int originalPrice;
  final int discountedPrice;
  final String imageUrl;
  final String offer;
 

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.originalPrice,
    required this.discountedPrice,
    required this.imageUrl,
    required this.offer,
   
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'originalPrice': originalPrice,
      'discountedPrice': discountedPrice,
      'imageUrl': imageUrl,
      'offer': offer,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map, String id) {
    return Item(
      id: id,
      name: map['name'],
      description: map['description'],
      originalPrice: map['originalPrice'],
      discountedPrice: map['discountedPrice'],
      imageUrl: map['imageUrl'],
      offer: map['offer'],
    
    );
  }
}
