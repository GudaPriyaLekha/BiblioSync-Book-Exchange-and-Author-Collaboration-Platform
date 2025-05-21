import 'package:book_manager/src/features/auth/forgot_password_screen.dart';
import 'package:book_manager/src/features/books/add_book_screen.dart';
import 'package:flutter/material.dart';
import 'package:book_manager/src/features/auth/login_screen.dart';
import 'package:book_manager/src/features/auth/register_screen.dart';
import 'package:book_manager/src/features/books/dashboard_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case '/forgot-password':
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case '/add-book':
        return MaterialPageRoute(builder: (_) => const AddBookScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}