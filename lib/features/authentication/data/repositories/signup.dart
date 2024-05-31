import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> addUser(String name, String username, String password) async {

  final reference = FirebaseFirestore.instance.collection('users');

  try {

    String userId = reference.doc().id;
    Map<String, String> user = {'name' : name, 'username' : username, 'password' : password};


    print(userId);
    final snapshot = reference.doc(userId);
    await snapshot.set(user);
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<int> login(String username, String password) async {

  final reference = FirebaseFirestore.instance.collection('users');

  try {

    final snapshot = await reference.where('username', isEqualTo: username).get();
    final allData = snapshot.docs.map((doc) => doc.data()).toList();

    print(allData);

    for (var data in allData) {
      if (data['username'] == username) {
        // Username exists, now check if the password matches
        if (data['password'] == password) {
          return 200; // Password matches
        } else {
          return 1; // Password does not match
        }
      } else{
        return 0;
      }
    }

    return 0;

  } catch (e) {
    print('###${e.toString()}');
    return -1;
  }
}