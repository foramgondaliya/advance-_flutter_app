import 'package:adv_flutter_app/helpers/Auth_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;
  GlobalKey<FormState> SignUpKey = GlobalKey<FormState>();
  GlobalKey<FormState> SignInKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login Page",
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('home_Page');
        },
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 280,
              child: ElevatedButton(
                onPressed: () {
                  validateAndSignUpUser();
                },
                child: Text("SignUp"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: 280,
              child: ElevatedButton(
                onPressed: () {
                  validateAndSignInUser();
                },
                child: Text("SignIn"),
              ),
            )
          ],
        ),
      ),
    );
  }

  validateAndSignUpUser() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Sign In",
          ),
          content: Form(
            key: SignUpKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Email First...";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    email = val;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Email Here",
                    labelText: "Email",
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Password First...";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    password = val;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Password Here",
                    labelText: "Password",
                    prefixIcon: Icon(
                      Icons.security,
                    ),
                  ),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                emailController.clear();
                passwordController.clear();
                email = null;
                password = null;
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
              ),
            ),
            TextButton(
              onPressed: () async {
                if (SignUpKey.currentState!.validate()) {
                  SignUpKey.currentState!.save();

                  Map<String, dynamic> res = await AuthHelpers.authHelpers
                      .SignInWithEmailAndPassword(
                          email: email!, password: password!);

                  if (res['user'] != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Sign up Successfully..."),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Navigator.of(context)
                        .pushNamed('home_Page', arguments: res['user']);
                  } else if (res['error'] != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${res['error']}"),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Sign up Successfully..."),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Navigator.of(context)
                        .pushNamed('home_Page', arguments: res['user']);
                  }

                  emailController.clear();
                  passwordController.clear();
                  email = null;
                  password = null;
                }
              },
              child: Text(
                "Sign Un",
              ),
            ),
          ],
        );
      },
    );
  }

  validateAndSignInUser() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Sign In",
          ),
          content: Form(
            key: SignInKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Email First...";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    email = val;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Email Here",
                    labelText: "Email",
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Password First...";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    password = val;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Password Here",
                    labelText: "Password",
                    prefixIcon: Icon(
                      Icons.security,
                    ),
                  ),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                emailController.clear();
                passwordController.clear();
                email = null;
                password = null;
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
              ),
            ),
            TextButton(
              onPressed: () async {
                if (SignInKey.currentState!.validate()) {
                  SignInKey.currentState!.save();

                  Map<String, dynamic> res = await AuthHelpers.authHelpers
                      .SignInWithEmailAndPassword(
                          email: email!, password: password!);

                  if (res['user'] != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Sign up Successfully..."),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Navigator.of(context)
                        .pushNamed('home_Page', arguments: res['user']);
                  } else if (res['error'] != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${res['error']}"),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Sign up Failed..."),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Navigator.of(context).pop();
                  }

                  emailController.clear();
                  passwordController.clear();
                  email = null;
                  password = null;
                }
              },
              child: Text(
                "Sign In",
              ),
            ),
          ],
        );
      },
    );
  }
}
