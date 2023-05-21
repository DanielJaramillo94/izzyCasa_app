import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:izzy_casa_app/firebase_options.dart';
import 'package:izzy_casa_app/my_router.dart';
import 'package:izzy_casa_app/screens/login.screen.dart';
import 'package:izzy_casa_app/providers/auth.provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var router = MyRouter(
      Provider.of<AuthProvider>(
        context,
        listen: false,
      ),
    ).router;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}
