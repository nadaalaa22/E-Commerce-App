import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/app_theme.dart';
import '../../data/model/user_model.dart';
import '../bloc/auth_bloc/authentication_bloc.dart';
import '../bloc/user_data_bloc/user_data_bloc.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var email = TextEditingController();

  var name = TextEditingController();

  var password = TextEditingController();

  var GlobalKeyForm = GlobalKey<FormState>();

  String? userId;

  bool flag = false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: GlobalKeyForm,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child:  SvgPicture.asset(
                      'assets/images/login.svg',
                      width: 200.0,
                      height: 200.0,
                    ),
                  ),
                  const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold, fontFamily: 'MyFont'),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  TextFormField(
                    controller: name,
                    decoration: const InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(),
                      prefixIcon:  const Icon(
                        Icons.person,
                      ),
                    ),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return 'field can not be null';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon:  const Icon(
                        Icons.email,
                      ),
                    ),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return 'field can not be null';
                      }
                      if (text.length < 6 ||
                          !text.contains('@') ||
                          !text.endsWith('.com') ||
                          text.startsWith('@')) {
                        return 'Wrong data ';
                      } else
                        return null;
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: const OutlineInputBorder(),
                      prefixIcon:  const Icon(
                        Icons.lock,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            flag = !flag;
                          });
                        },
                        icon: Icon(
                          flag
                              ? Icons.visibility
                              : Icons.visibility_off, // Toggle icon
                        ),
                      ),
                    ),
                    validator: (text) {
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
                  const SizedBox(
                    height: 35.0,
                  ),
                  Container(
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
                        if (GlobalKeyForm.currentState!.validate()) {
                          UserModel userModel =
                          UserModel(name: name.text, id:'') ;
                          context.read<AuthenticationBloc>().add(SignUpEvent(
                              email: email.text, password: password.text , userModel));
                          // User? user = await FirebaseAuth.instance.currentUser;
                          context
                              .read<UserDataBloc>()
                              .add(SetUserEvent(userModel: userModel));
                        }
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'MyFont',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account ? ',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginPage()));
                        },
                        child: const Text('Login now ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff6C63FF),
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
