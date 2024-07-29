import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDateSetterScreen extends StatefulWidget {
  @override
  _AdminDateSetterScreenState createState() => _AdminDateSetterScreenState();
}

class _AdminDateSetterScreenState extends State<AdminDateSetterScreen> {
  DateTime? baseDate;
  List<String> days = [
    'ATHAM',
    'CHITHIRA',
    'CHODHI',
    'VISHAKAM',
    'ANIZHAM',
    'THRIKETA',
    'MOOLAM',
    'POORADAM',
    'UTHRADAM',
    'THIRUVONAM'
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        baseDate = picked;
      });
    }
  }

  void _saveDates() async {
    if (baseDate != null) {
      await FirebaseFirestore.instance.collection('days').doc('settings').set({
        'baseDate': baseDate,
        'days': days,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Base date and days saved successfully')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              baseDate == null
                  ? 'No base date selected'
                  : 'Starting date: ${baseDate!.toLocal()}'.split(' ')[0],
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select date'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _saveDates,
              child: Text('Save settings'),
            ),
          ],
        ),
      ),
    );
  }
}
