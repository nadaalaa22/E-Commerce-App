import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/auth/data/model/user_model.dart';
import 'package:e_commerce_app/features/auth/presentation/bloc/auth_bloc/authentication_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/app_theme.dart';
import 'package:lottie/lottie.dart';

class ContactPage extends StatefulWidget {
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
    final user = FirebaseAuth.instance.currentUser;
    final globalKeyForm = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Contact Information",
            style: appTheme.textTheme.displayLarge,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance.collection('users').doc(user!.uid).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Text("No User Data Found");
            }
            final userModel = UserModel.fromDocumentSnapshot(snapshot.data!);
            final nameController = TextEditingController(text: userModel.name);
            final emailController = TextEditingController(text: userModel.email);
            final phoneController = TextEditingController(text: userModel.phone);
            final addressController = TextEditingController(text: userModel.address);
            final ageController = TextEditingController(text: userModel.age?.toString());

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Welcome, ${userModel.name}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      IconButton(
                        icon: editIcon,
                        onPressed: () {
                          setState(() {
                            editable = !editable;
                            editIcon = editable ? const Icon(Icons.cancel_outlined) : const Icon(Icons.edit);
                            editToolTip = editable ? "Cancel" : "Edit Info";
                          });
                        },
                        tooltip: editToolTip,
                      ),
                    ],
                  ),
                  const SizedBox(height: 25.0),
                  Center(
                    child: Lottie.asset(
                        'assets/images/Animation - 1725374754294.json', // Path to your Lottie JSON file
                        width: 200,
                        height: 200,
                        fit: BoxFit.fill),
                  ),
                  Form(
                    key: globalKeyForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTextField(nameController, "Full Name", enabled: editable),
                        const SizedBox(height: 25.0),
                        buildTextField(emailController, "Email", enabled: false),
                        const SizedBox(height: 25.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: buildTextField(ageController, "Age", enabled: editable, keyboardType: TextInputType.number),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              flex: 7,
                              child: buildTextField(phoneController, "Phone Number", enabled: editable, keyboardType: TextInputType.phone, validator: (text) {
                                if (text!.isNotEmpty && text.length != 11) {
                                  return 'Phone number must be 11 digits';
                                }
                                return null;
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25.0),
                        buildTextField(addressController, "Address", enabled: editable),
                        const SizedBox(height: 25.0),
                        Visibility(
                          visible: editable,
                          child: Center(
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
                                  if (globalKeyForm.currentState!.validate()) {
                                    UserModel updatedUser = userModel.copyWith(
                                      name: nameController.text,
                                      phone: phoneController.text.isNotEmpty ? phoneController.text : null,
                                      address: addressController.text.isNotEmpty ? addressController.text : null,
                                      age: ageController.text.isNotEmpty ? int.parse(ageController.text) : null,
                                    );

                                    // Update user data in Firestore
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(updatedUser.userId)
                                        .update(updatedUser.toMap());

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Changes Saved Successfully'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );

                                    setState(() {
                                      editable = false;
                                      editIcon = const Icon(Icons.edit);
                                      editToolTip = "Edit Info";
                                    });
                                  }
                                },
                                child: const Text(
                                  'Save',
                                  style: TextStyle(color: Colors.white, fontSize: 24),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label, {bool enabled = true, TextInputType keyboardType = TextInputType.text, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        label: Text(label, style: appTheme.textTheme.bodyMedium),
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
      validator: validator,
    );
  }
}
