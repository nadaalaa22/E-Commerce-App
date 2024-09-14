import 'package:e_commerce_app/features/auth/data/model/user_model.dart';
import 'package:e_commerce_app/features/auth/presentation/bloc/auth_bloc/authentication_bloc.dart';
import 'package:e_commerce_app/features/auth/presentation/bloc/user_data_bloc/user_data_bloc.dart';
import 'package:e_commerce_app/features/auth/presentation/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/app_theme.dart';

class ContactPage extends StatelessWidget {
  ContactPage({super.key});

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: context.read<AuthenticationBloc>().usersDBModel.getUsers(),
          builder: (context, snapshot){
            // var userModel = snapshot.data?.firstWhere((element) => element.id == FirebaseAuth.instance.currentUser!.uid);
            final user = FirebaseAuth.instance.currentUser;
            var globalKeyForm = GlobalKey<FormState>();
            var userModel = UserModel(name: "Omar",id: "123");
            final nameController = TextEditingController(text: userModel?.name);
            final emailController = TextEditingController(text: /*"${user?.email}"*/"Omar@anything.com");
            final oldPasswordController = TextEditingController();
            final newPasswordController = TextEditingController();
            final confirmNewPasswordController = TextEditingController();
            return userModel != null? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome, ${userModel.name}",style: appTheme.textTheme.bodyLarge),
                  Text(/*"${user?.email}"*/"Omar@anything.com", style: appTheme.textTheme.bodyMedium),
                  const SizedBox(height: 25.0,),
                  Form(
                    key: globalKeyForm,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Your Full Name",style: appTheme.textTheme.bodyLarge),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            floatingLabelStyle: TextStyle(color: primaryColor),
                            iconColor: secondaryColor,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: secondaryColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25.0,),
                        Text("Your Email",style: appTheme.textTheme.bodyLarge),

                        TextFormField(
                          controller: emailController,
                          readOnly: true,
                          decoration: InputDecoration(
                            floatingLabelStyle: TextStyle(color: primaryColor),
                            iconColor: secondaryColor,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: secondaryColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25.0,),
                        Text("Old Password",style: appTheme.textTheme.bodyLarge),
                        TextFormField(
                          controller: oldPasswordController,
                          decoration: InputDecoration(
                            floatingLabelStyle: TextStyle(color: primaryColor),
                            iconColor: secondaryColor,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: secondaryColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (text){
                            if (text == null || text.isEmpty){
                              if (newPasswordController.text.isNotEmpty || confirmNewPasswordController.text.isNotEmpty){
                                return 'You must enter your old password';
                              }
                              return null;
                            }
                            try{
                              user?.reauthenticateWithCredential(EmailAuthProvider.credential(email: user.email!, password: text));
                              return null;
                            }
                            catch(exception){
                              return "Old Password is incorrect";
                            }
                          },
                        ),
                        const SizedBox(height: 25.0,),
                        Text("New Password",style: appTheme.textTheme.bodyLarge),
                        TextFormField(
                          controller: newPasswordController,
                          decoration: InputDecoration(
                            floatingLabelStyle: TextStyle(color: primaryColor),
                            iconColor: secondaryColor,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: secondaryColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (text) {
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
                          },
                        ),
                        const SizedBox(height: 25.0,),
                        Text("Confirm New Password",style: appTheme.textTheme.bodyLarge),
                        TextFormField(
                          controller: confirmNewPasswordController,
                          decoration: InputDecoration(
                            floatingLabelStyle: TextStyle(color: primaryColor),
                            iconColor: secondaryColor,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: secondaryColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (text){
                            if (oldPasswordController.text.isEmpty || (text != null && text == newPasswordController.text)){
                              return null;
                            }
                            return "Password doesn't match";
                          }
                        ),
                        const SizedBox(height: 25.0,),
                        Center(
                          child: ElevatedButton(
                            onPressed: (){
                              if (globalKeyForm.currentState!.validate()){
                                user?.updatePassword(newPasswordController.text);
                                print(user);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Changes Saved Successfully'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            style: appTheme.elevatedButtonTheme.style,
                            child: const Text("Save"),
                          ),
                        ),
                      ],
                    )
                  )
                ],
              ),
            ):const Text("No Data");
          }
        ),
      )
    );
  }
}