import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  Future<void> _signInAnonymously() async {

    try{

      await FirebaseAuth.instance.signInAnonymously();
    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: _signInAnonymously,
          child: Text('Sign in anonymously'),
        ),
      ),
    );
  }
}
