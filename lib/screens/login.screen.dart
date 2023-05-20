import 'package:flutter/material.dart';
import 'package:izzy_casa_app/providers/auth.provider.dart';
import 'package:izzy_casa_app/ui/custom_button.dart';
import 'package:izzy_casa_app/ui/custom_input.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                ),
                const Text(
                  'Ingresa para continuar.',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 50),
                CustomInput(
                  label: 'CORREO',
                  icon: Icons.email_outlined,
                  inputController: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa un correo';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomInput(
                  label: 'CONTRASEÑA',
                  icon: Icons.lock_outline,
                  inputController: passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa tu contraseña';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const AuthStatus(),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomButton(
                    onPressed: () async {
                      var authProvider = Provider.of<AuthProvider>(
                        context,
                        listen: false,
                      );
                      try {
                        await authProvider.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Ha ocurrido en el inicio de sesión.'),
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthStatus extends StatelessWidget {
  const AuthStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var userStatusStream = context.watch<AuthProvider>().userStatusStream;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Status'),
        StreamBuilder(
          stream: userStatusStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Text('Logged in');
            } else {
              return const Text('Not logged in');
            }
          },
        ),
      ],
    );
  }
}
