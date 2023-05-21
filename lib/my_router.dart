import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izzy_casa_app/providers/auth.provider.dart';
import 'package:izzy_casa_app/screens/home.screen.dart';
import 'package:izzy_casa_app/screens/login.screen.dart';
import 'package:provider/provider.dart';

class MyRouter {
  MyRouter(this.authProvider);

  final AuthProvider authProvider;
  late final router = GoRouter(
    refreshListenable: authProvider,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return Consumer<AuthProvider>(
            builder: (BuildContext context, AuthProvider authProvider, _) {
              return authProvider.isAuthenticated
                  ? const HomeScreen()
                  : const LoginScreen();
            },
          );
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'details',
            builder: (BuildContext context, GoRouterState state) {
              return const HomeScreen();
            },
          ),
        ],
      ),
    ],
  );
}
