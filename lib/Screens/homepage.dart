import 'package:adv_flutter_app/Models/DatabaseModel.dart';
import 'package:adv_flutter_app/helpers/Auth_helpers.dart';
import 'package:adv_flutter_app/helpers/databaseHelper.dart';
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
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
        onPressed: () {
          showAlert();
        },
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

  showAlert() {
    showDialog(
      context: context,
      builder: (BuildContext) {
        return AlertDialog(
          title: Text(
            "Add User",
          ),
          content: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Enter name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(),
                    labelText: "EnterName..",
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        if (key.currentState!.validate()) {
                          UserModel model = UserModel(
                              name: emailController.text,
                              password: passwordController.text);
                          int id =
                              await DbHelper.dbHelper.insertUser(model: model);

                          if (id >= 1) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "User Inserted Successfully...",
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "User Insertion failed...",
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                      label: const Text("Save"),
                      icon: const Icon(Icons.save),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        passwordController.clear();
                        setState(() {});
                      },
                      label: const Text("Cancel"),
                      icon: const Icon(Icons.cancel),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
