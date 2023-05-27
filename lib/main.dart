import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:izzy_casa_app/firebase_options.dart';
import 'package:izzy_casa_app/my_router.dart';
import 'package:izzy_casa_app/screens/login.screen.dart';
import 'package:izzy_casa_app/providers/auth.provider.dart';
import 'package:izzy_casa_app/utils/locator.dart';
import 'package:izzy_casa_app/utils/widgets/error_handling.widget.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
      ],
      child: Builder(builder: (context) {
        var authProvider = Provider.of<AuthProvider>(
          context,
          listen: false,
        );
        return MyApp(authProvider: authProvider);
      }),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({super.key, required this.authProvider});

  final AuthProvider authProvider;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final MyRouter goRouter;
  @override
  void initState() {
    super.initState();
    goRouter = MyRouter(widget.authProvider);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      routerConfig: goRouter.router,
      scaffoldMessengerKey: widget.scaffoldMessengerKey,
      builder: (_, child) {
        return ErrorHandlerWidget(
          SafeArea(child: child!),
          scaffoldMessengerKey: widget.scaffoldMessengerKey,
        );
      },
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
