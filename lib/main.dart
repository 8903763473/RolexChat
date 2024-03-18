import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_integration/homescreen/screens/homescreen.dart';
import 'package:firebase_integration/login/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'firebase_options.dart';
import 'login/cubit/logincubit.dart';
import 'login/screens/signup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  await Hive.openBox('userLogin');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final checkUser = Hive.box('userLogin');
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (BuildContext context) => LoginCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: checkUser.get(1) != null
            ? HomeScreen(userName: checkUser.get(1))
            : const LoginPage(),
      ),
    );
  }
}
