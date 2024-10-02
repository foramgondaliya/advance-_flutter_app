import 'package:adv_flutter_app/helpers/Auth_helpers.dart';
import 'package:adv_flutter_app/helpers/firebaseHelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    // Map<String, dynamic> data =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "homePage",
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () async {
              await AuthHelpers.authHelpers.SignOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (routs) => false);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: StreamBuilder(
      //     stream: FireStoreHelper.fireStoreHelper.fetchAllUsers(),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasError) {
      //         return Center(
      //           child: Text("ERROR : ${snapshot.error}"),
      //         );
      //       } else if (snapshot.hasData) {
      //         QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;
      //
      //         List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs =
      //             (data == null) ? [] : data.docs;
      //
      //         return ListView.separated(
      //           separatorBuilder: (context, i) {
      //             return Divider();
      //           },
      //           itemCount: allDocs.length,
      //           itemBuilder: (context, i) {
      //             String receiverEmail = allDocs[i].data()['email'];
      //
      //             return (AuthHelpers.firebaseAuth.currentUser!.email ==
      //                     receiverEmail)
      //                 ? Container()
      //                 : Card(
      //                     elevation: 4,
      //                     child: ListTile(
      //                       leading: CircleAvatar(
      //                         radius: 25,
      //                       ),
      //                       title: Text(receiverEmail),
      //                       trailing: IconButton(
      //                         icon: Icon(Icons.delete),
      //                         onPressed: () async {
      //                           await FireStoreHelper.fireStoreHelper
      //                               .deleteUser(docId: allDocs[i].id);
      //                         },
      //                       ),
      //                       onTap: () {
      //                         Navigator.of(context).pushNamed(
      //                           "ChatApp",
      //                           arguments: allDocs[i].data(),
      //                         );
      //                       },
      //                     ),
      //                   );
      //           },
      //         );
      //       }
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     },
      //   ),
      // ),
    );
  }
}
