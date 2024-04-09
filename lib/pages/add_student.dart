import 'package:darb_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("إضافة طالب", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: blueColor), 
        ), 
      ),
    );
  }
}