import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  FireStoreHelper._();
  static final FireStoreHelper fireStoreHelper = FireStoreHelper._();
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addAuth({required String email}) async {
    bool isUserExists = false;

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await db.collection("users").get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs =
        querySnapshot.docs;

    allDocs.forEach((QueryDocumentSnapshot<Map<String, dynamic>> doc) async {
      Map<String, dynamic> docData = doc.data();

      if (docData['email'] == email) {
        isUserExists = true;
      }
    });
    if (isUserExists == false) {
      DocumentSnapshot<Map<String, dynamic>> qs =
          await db.collection("records").doc("users").get();

      Map<String, dynamic>? data = qs.data();

      int id = data!['id'];
      await db.collection("users").doc("$id").set({
        "email": email,
      });
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllUsers() {
    return db.collection("users").snapshots();
  }

  Future<void> deleteUser({required String docId}) async {
    await db.collection("users").doc(docId).delete();
  }
}
