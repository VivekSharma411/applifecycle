import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialLogin extends StatefulWidget {
  const SocialLogin({super.key});

  @override
  State<SocialLogin> createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  // Use the EvaIcons class for the IconData
                  icon: const Icon(EvaIcons.google),
                  onPressed: () async{

                   await signWithGoogle();

                  }),
              IconButton(
                  // Use the EvaIcons class for the IconData
                  icon: const Icon(EvaIcons.facebook),
                  onPressed: () async{
                    await signInWithFacebook();
                    print("Eva Icon heart Pressed");
                  }),
              IconButton(
                  // Use the EvaIcons class for the IconData
                  icon: const Icon(EvaIcons.twitter),
                  onPressed: () {
                    print("Eva Icon heart Pressed");
                  }),
            ],
          )
        ],
      ),
    );
  }

  Future<UserCredential?> signWithGoogle() async{
    final GoogleSignInAccount? googleSignInAccount =  await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleSignInAuth = await googleSignInAccount?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken:  googleSignInAuth?.accessToken,
      idToken: googleSignInAuth?.idToken,
    );
    UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
    if(userCredential.user != null){

    }
    print(userCredential.user?.email);

  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }



}
