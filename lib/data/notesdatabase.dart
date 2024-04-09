import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task3/features/home/ui/homePage.dart';

class DatabaseMethods{
  var userId = FirebaseAuth.instance.currentUser!.email!;
  Future addCourse(Map<String , dynamic> notesDetails , String id) async {
    return await FirebaseFirestore.instance
        .collection(userId)
        .doc(id)
        .set(notesDetails);
  }

  Future<Stream<QuerySnapshot>> getNotesDetails() async {
    return await FirebaseFirestore.instance.collection(userId).snapshots();
  }

  Future updateNotesDetails(String id , Map<String , dynamic> updatedNotesDetails) async{
    return await FirebaseFirestore.instance.collection(userId).doc(id).update(updatedNotesDetails);
  }

  Future deleteNotes(String id) async{
    return await FirebaseFirestore.instance.collection(userId).doc(id).delete();
  }

  Future addNotesContent(String notesContent, String id) async {
    Map<String , dynamic> notesData={"notesContent" : notesContent};
    return await FirebaseFirestore.instance
        .collection(userId)
        .doc(id)
        .update(notesData);
  }
}