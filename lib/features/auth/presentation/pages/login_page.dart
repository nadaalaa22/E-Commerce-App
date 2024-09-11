import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app_theme.dart';
import '../../../e_commerce/presentation/pages/controller_page.dart';
import '../../data/model/auth_model.dart';
import '../bloc/auth_bloc/authentication_bloc.dart';
import 'sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var email = TextEditingController();

  var password = TextEditingController();

  GlobalKey<FormState> keyLogin = GlobalKey();
   bool  flag = false ;

  @override
  void initState() {
    context.read<AuthenticationBloc>().add(CheckIfAuthEvent());
    super.initState();
  }

  String? userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (BuildContext context, AuthenticationState state) {
          if (state is Authorized ) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ControllerPage()));
          }
          if (state is AuthError) {
            // showToast("An error occurred: ${state.error}");
          }
        },
        builder: (context, state) {
          print(state);
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

            return Form(
              key: keyLogin,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: SvgPicture.asset(
                            'assets/images/login.svg', // Replace with the actual path to your SVG file
                            width: 200.0, // Adjust the width as needed
                            height: 200.0, // Adjust the height as needed
                          ),
                        ),
                        const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'MyFont'),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
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
                          keyboardType: TextInputType.emailAddress,
                          obscureText: !flag,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(
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
                            onPressed: () {
                              if (keyLogin.currentState!.validate()) {
                                context.read<AuthenticationBloc>().add(
                                    SignInEvent(
                                        email: email.text,
                                        password: password.text));
                              }
                            },
                            child: const Text(
                              'Login',
                              style:
                              TextStyle(color: Colors.white, fontSize: 24),
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
                              'Don\'t have an account?',
                              style:
                              TextStyle(fontSize: 18, fontFamily: 'MyFont'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => SignUpPage()));
                              },
                              child: Text('Register now ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: primaryColor,
                                      fontFamily: 'MyFont')),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );

        },
      ),
    );
  }
}
