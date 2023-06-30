import 'package:chat_app/widgets/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading=false;
  final _auth = FirebaseAuth.instance;
  void _submitAuthForm(
    String email, 
    String password, 
    String userName,
      bool isLogin, 
      BuildContext ctx) async {
    UserCredential userCredential;

    try {
      setState(() {
        _isLoading=true;
      });
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

           await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
              ' username': userName,
              'email': email
            });
      }
    } on PlatformException catch (err) {
      var message = 'An error Occured, check your Credentials!';

      if (err.message != null) {
        message = err.message!;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      setState(() {
        _isLoading=false;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(
          _submitAuthForm,
          _isLoading,
          ));
  }
}
