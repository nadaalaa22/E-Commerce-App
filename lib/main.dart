import 'package:e_commerce_app/features/auth/presentation/pages/login_page.dart';
import 'package:e_commerce_app/features/auth/presentation/pages/splash_page.dart';
import 'package:e_commerce_app/features/e_commerce/presentation/pages/product_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/db_helper.dart';
import 'features/auth/data/datasorce/authentication_remote_ds/authentication.dart';
import 'features/auth/data/datasorce/user_remote_ds/user_remote_ds.dart';
import 'features/auth/presentation/bloc/auth_bloc/authentication_bloc.dart';
import 'features/auth/presentation/bloc/user_data_bloc/user_data_bloc.dart';
import 'features/e_commerce/presentation/pages/controller_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(AuthenticationImp(),
              UserDBModelImp(dbHelper: RemoteDbHelperImpl()))),
      BlocProvider<UserDataBloc>(
          create: (context) =>
              UserDataBloc(UserDBModelImp(dbHelper: RemoteDbHelperImpl()))),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: ProductPage());
  }
}
