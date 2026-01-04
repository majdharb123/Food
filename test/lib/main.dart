import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'listView.dart';
import 'Details.dart';
import 'Login.dart';
import 'Register.dart';
import 'Admin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const ListviewPage(),
        ),
        GoRoute(
          path: '/details',
          builder: (context, state) {
            final data = state.extra as Map<String, String>;
            return Details(
              title: data['title']!,
              subtitle: data['subtitle']!,
              image: data['image']!,
              calories: data['calories']!,
            );
          },
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => Register(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => Login(),
        ),
        GoRoute(
          path: '/admin',
          builder: (context, state) => const Admin(),
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Moto Store",
      routerConfig: _router,
    );
  }
}
