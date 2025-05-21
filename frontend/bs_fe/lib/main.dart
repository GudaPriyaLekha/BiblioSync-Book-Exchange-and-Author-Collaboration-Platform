import 'package:book_manager/src/features/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:book_manager/src/core/routing/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblio Sync',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Option 1: Use home + onGenerateRoute (recommended)
      home: const LoginScreen(), // Initial screen
      onGenerateRoute: AppRouter.generateRoute, // Your custom route generator
      
      // Option 2: OR use initialRoute + onGenerateRoute
      // initialRoute: '/login',
      // onGenerateRoute: AppRouter.generateRoute,
      
      // Optional: Handle unknown routes (already handled in your AppRouter)
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      ),
    );
  }
}