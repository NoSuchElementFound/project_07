import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String? name;
  final String? id;
  User({
    required this.name, required this.id});


  static createUser(User user){
    final userCollection=FirebaseFirestore.instance.collection("users");
    String id=userCollection.doc().id;
    final newUser=User(
      name: user.name,
      id: id
    )._toJson();
    userCollection.doc(id).set(newUser);
  }

  static Stream<List<User>> readData(){
    final userCollection=FirebaseFirestore.instance.collection("users");
    return userCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => User.fromJson(e)).toList());
  }

  _toJson(){
    return {"name":name, "id":id};
  }

  static User fromJson(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return User(
    name: snapshot["name"],
    id: snapshot["id"]
    );
  }

  static updateUser(User user) {
    final userCollection=FirebaseFirestore.instance.collection("users");
    String id;
    final newUser=User(
        name: user.name,
        id: user.id
    )._toJson();
    userCollection.doc(user.id).update(newUser);
  }

  static void deleteUser(String id) {
    final userCollection=FirebaseFirestore.instance.collection("users");
    userCollection.doc(id).delete();
  }
}