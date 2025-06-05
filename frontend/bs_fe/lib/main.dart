// lib/main.dart
import 'package:book_manager/src/features/author/find_authors_screen.dart';
import 'package:book_manager/src/features/author/manage_network_screen.dart';
import 'package:book_manager/src/stores/book_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_manager/src/stores/auth_store.dart';
import 'package:book_manager/src/features/auth/login_screen.dart';
import 'package:book_manager/src/features/books/dashboard_screen.dart';
import 'package:book_manager/src/features/books/manage_books_screen.dart';
import 'package:book_manager/src/features/books/exchange_screen.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthStore()),
        ChangeNotifierProvider(create: (_) => BookStore()..loadBooks()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  title: 'Book Manager',
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primarySwatch: Colors.blue,
  ),
  routes: {
    '/manage-books': (context) => const ManageBooksScreen(),
    '/exchange': (context) =>  ExchangeScreen(),
    '/find-authors': (context) => const FindAuthorsScreen(),
  '/my-network': (context) => const ManageNetworkScreen(),
  },
  home: Consumer<AuthStore>(
    builder: (context, authStore, child) {
      return authStore.isAuthenticated
          ? const DashboardScreen()
          : const LoginScreen();
    },
  ),
);

  }
}