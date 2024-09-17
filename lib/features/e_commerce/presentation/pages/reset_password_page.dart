import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'contact_page.dart';

class ResetPasswordPage extends StatelessWidget {

  ResetPasswordPage({super.key});

  final globalKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reset Password",
          style: appTheme.textTheme.displayLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance.collection('users').doc(user!.uid).get(),
          builder: (context,snapshot) { 
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Text("No User Data Found");
            }
            return Form(
              key: globalKey,
              child: Column(
                children: [
                  buildTextField(oldPasswordController, 'Old Password',validator: (text){
                    if (text == null || text.isEmpty){
                      if (newPasswordController.text.isNotEmpty || confirmPasswordController.text.isNotEmpty){
                        return 'You must enter your old password';
                      }
                      return null;
                    }
                    return null;
                  }),
                  SizedBox(height: 20,),
                  buildTextField(newPasswordController, 'New Password', validator: (text) {
                    if (oldPasswordController.text.isEmpty){
                      return null;
                    }
                    if (text!.isEmpty) {
                      return 'field can not be null';
                    }
                    if (text.length < 8) {
                      return 'password must be strong';
                    } else {
                      return null;
                    }
                  },),
                  SizedBox(height: 20,),
                  buildTextField(confirmPasswordController, 'Confirm Password', validator: (text){
                    if (oldPasswordController.text.isEmpty || (text != null && text == newPasswordController.text)){
                      return null;
                    }
                    return "Password doesn't match";
                  }),
                  SizedBox(height: 20,),
                  Center(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [primaryColor, secondaryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          if (globalKey.currentState!.validate()) {
                            try{
                              await user.reauthenticateWithCredential(EmailAuthProvider.credential(email: user.email!, password: oldPasswordController.text));
                              await user.updatePassword(newPasswordController.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Password Changed Successfully'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                            catch(exception){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Old password is incorrect'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text(
                          'Reset',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}