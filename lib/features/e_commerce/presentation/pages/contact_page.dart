import 'package:e_commerce_app/features/auth/data/model/user_model.dart';
import 'package:e_commerce_app/features/auth/presentation/bloc/auth_bloc/authentication_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/app_theme.dart';

class ContactPage extends StatefulWidget{
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  bool editable = false;
  Icon editIcon = const Icon(Icons.edit);
  String editToolTip = "Edit Info";

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
            final globalKeyForm = GlobalKey<FormState>();
            final userModel = UserModel(name: "Omar",id: "123");
            final nameController = TextEditingController(text: userModel?.name);
            final emailController = TextEditingController(text: /*"${user?.email}"*/"Omar@anything.com");
            final oldPasswordController = TextEditingController();
            final newPasswordController = TextEditingController();
            final confirmPasswordController = TextEditingController();
            final addressController = TextEditingController(text: userModel?.address);
            final ageController = TextEditingController(text: userModel?.age?.toString());
            final phoneController = TextEditingController(text: userModel?.phone);


            return userModel != null? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Welcome, ${userModel.name}",style: appTheme.textTheme.bodyLarge),
                      const Spacer(),
                      IconButton(
                        icon: editIcon,
                        onPressed: (){
                          setState((){
                            editable = !editable;
                            editIcon = editable? const Icon(Icons.cancel_outlined):const Icon(Icons.edit);
                            editToolTip = editable? "Cancel":"Edit Info";
                          });
                        },
                        tooltip: editToolTip,
                      ),
                    ],
                  ),
                  const SizedBox(height: 25.0,),
                  Form(
                    key: globalKeyForm,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: nameController,
                          enabled: false,
                          decoration: InputDecoration(
                            label: Text("Full Name",style: appTheme.textTheme.bodyMedium,),
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

                        TextFormField(
                          controller: emailController,
                          // readOnly: true,
                          enabled: false,
                          decoration: InputDecoration(
                            label: Text("Email",style: appTheme.textTheme.bodyMedium,),
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
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child:TextFormField(
                                keyboardType: TextInputType.number,
                                controller: ageController,
                                enabled: editable,
                                decoration: InputDecoration(
                                  label: Text("Age",style: appTheme.textTheme.bodyMedium,),
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
                            ),
                            const SizedBox(width: 10.0,),
                            Expanded(
                              flex: 7,
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                controller: phoneController,
                                enabled: editable,
                                decoration: InputDecoration(
                                  label: Text("Phone Number",style: appTheme.textTheme.bodyMedium,),
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
                                  if (text!.isNotEmpty && text.length != 11) {
                                    return 'phone number must be 11 digits';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25.0,),
                        TextFormField(
                          controller: addressController,
                          enabled: editable,
                          decoration: InputDecoration(
                            label: Text("Address",style: appTheme.textTheme.bodyMedium,),
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

                        TextFormField(
                          controller: oldPasswordController,
                          enabled: editable,
                          decoration: InputDecoration(
                            label: Text("Old Password",style: appTheme.textTheme.bodyMedium,),
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
                              if (newPasswordController.text.isNotEmpty || confirmPasswordController.text.isNotEmpty){
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

                        TextFormField(
                          controller: newPasswordController,
                          enabled: editable,
                          decoration: InputDecoration(
                            label: Text("New Password",style: appTheme.textTheme.bodyMedium,),
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

                        TextFormField(
                          controller: confirmPasswordController,
                          enabled: editable,
                          decoration: InputDecoration(
                            label: Text("Confirm Password",style: appTheme.textTheme.bodyMedium,),
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
                        
                        Visibility(
                          visible: editable,
                          child: Center(
                            child: ElevatedButton(
                              onPressed: (){
                                if (globalKeyForm.currentState!.validate()){
                                  if (newPasswordController.text.isNotEmpty){
                                    user?.updatePassword(newPasswordController.text);
                                  }
                                  print(user);
                                  if (ageController.text.isNotEmpty){
                                    userModel.age = int.parse(ageController.text);
                                  }
                                  if (phoneController.text.isNotEmpty){
                                    userModel.phone = phoneController.text;
                                  }
                                  if (addressController.text.isNotEmpty){
                                    userModel.address = addressController.text;
                                  }
                                  print(userModel.age);
                                  // update in firebase
                                  // context.read<UserDataBloc>().add(SetUserEvent(userModel: userModel));
                                  
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ):const Text("No Data");
          },
        ),
      ),
    );
  }
}