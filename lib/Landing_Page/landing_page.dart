import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker_app_interview/Home_Page/home_pagee.dart';
import 'package:weight_tracker_app_interview/Sign_In/sign_in_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){

        if(snapshot.connectionState == ConnectionState.active){
          User? user = snapshot.data;

          if (user == null )
            {
              return SignInPage();

            }
          return HomePage();

        } else
          {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

        }

        },

    );
  }
}
