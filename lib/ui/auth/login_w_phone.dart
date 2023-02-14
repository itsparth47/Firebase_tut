import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tut/ui/auth/verify_code.dart';
import 'package:firebase_tut/utils/utils.dart';
import 'package:firebase_tut/widgets/round_button.dart';
import 'package:flutter/material.dart';

class LoginWPhoneNo extends StatefulWidget {
  const LoginWPhoneNo({Key? key}) : super(key: key);

  @override
  State<LoginWPhoneNo> createState() => _LoginWPhoneNoState();
}

class _LoginWPhoneNoState extends State<LoginWPhoneNo> {
  bool loading = false;
  final auth = FirebaseAuth.instance;
  final phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: '+1 234 2653 6763'
              ),
            ),
            SizedBox(height: 30,),
            RoundButton(title: 'Login',
                loading: loading,
                onTap: (){
              setState(() {
                loading = true;
              });
              auth.verifyPhoneNumber(
                phoneNumber: phoneNumberController.text,
                  verificationCompleted: (_){
                    setState(() {
                      loading = false;
                    });
                  },
                  verificationFailed: (e){
                    setState(() {
                      loading = false;
                    });
                  Utils().toastMessage(e.toString());
                  },
                  codeSent: (String verificationId, int? token){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => VerifyCodeScreen(verificationId: verificationId,)));
                  setState(() {
                    loading = false;
                  });
                  },
                  codeAutoRetrievalTimeout: (e){
                    Utils().toastMessage(e.toString());
                    setState(() {
                      loading = false;
                    });
                  });
            }),
          ],
        ),
      ),
    );
  }
}
