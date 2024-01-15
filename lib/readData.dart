import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/User.dart';

class readData extends StatefulWidget{
  const readData({super.key});

  @override
  State<readData> createState() => _readDataState();
}

class _readDataState extends State<readData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DB App"),),
      body: _createUI(),
    );
  }

  Widget _createUI(){
    return SafeArea(child: Column(
      children: [Center(
        child: StreamBuilder<List<User>>(
          stream: User.readData(),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }
            if(snapshot.data!.isEmpty){
              return const Center(child: Text("List is Empty"),);
            }
            final users=snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  children:
                  users!.map((user) { return ListTile(
                    trailing: GestureDetector(
                      onTap: (){
                        User.deleteUser(user.id!);
                      },
                      child: const Icon(Icons.delete),
                    ),
                    leading: GestureDetector(onTap:(){
                      User.updateUser(User(name:"new", id: user.id));
                    },
                        child: const Icon(Icons.update)),
                    title: Text(user.name!),
                    subtitle: Text(user.id!),
                  );
                  }
                  ).toList()
              ),
            );
          },),
      )],
    ));
  }
}