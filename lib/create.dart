import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_07/model/User.dart';

class create extends StatefulWidget{
  const create({super.key});

  @override
  State<create> createState() => _createState();
}

class _createState extends State<create> {
  final _databaseReference=FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DB App"),),
      body: _createUI(),
    );
  }

  Widget _createUI(){
    return SafeArea(child: Column(
      children: [Center(
        child: ElevatedButton(onPressed:() {
          User.createUser(User(name: 'lmn', id: '5'));
        }, child: const Text("Add")),
      )],
    ));
  }
}
