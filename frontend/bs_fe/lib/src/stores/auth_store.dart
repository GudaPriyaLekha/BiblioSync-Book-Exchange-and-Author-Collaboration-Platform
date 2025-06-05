// import 'package:flutter/material.dart';

// class AuthStore extends ChangeNotifier {
//   // Hardcoded user accounts (username/email : password)
//   final Map<String, String> _validUsers = {
//     'priyalekhaguda2710@gmail.com': 'Admin@123',
//     'lekhaguda@gmail.com': 'User@123',
//   };

//   bool _isAuthenticated = false;
//   String? _authError;

//   bool get isAuthenticated => _isAuthenticated;
//   String? get authError => _authError;

//   Future<bool> login(String email, String password) async {
//     // Reset previous error
//     _authError = null;
    
//     // Validate email format
//     if (!email.contains('@')) {
//       _authError = 'Please enter a valid email address';
//       notifyListeners();
//       return false;
//     }

//     // Check if user exists
//     if (!_validUsers.containsKey(email)) {
//       _authError = 'User does not exist';
//       notifyListeners();
//       return false;
//     }

//     // Check password
//     if (_validUsers[email] != password) {
//       _authError = 'Wrong password';
//       notifyListeners();
//       return false;
//     }

//     // Successful login
//     _isAuthenticated = true;
//     notifyListeners();
//     return true;
//   }

//   Future<bool> googleSignIn() async {
//     // For demo purposes, treat Google login as admin
//     _isAuthenticated = true;
//     notifyListeners();
//     return true;
//   }

//   void logout() {
//     _isAuthenticated = false;
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';

class AuthStore extends ChangeNotifier {
  // Hardcoded user accounts (username/email : password)
  final Map<String, String> _validUsers = {
    'priyalekhaguda2710@gmail.com': 'Admin@123',
    'lekhaguda@gmail.com': 'User@123',
  };

  bool _isAuthenticated = false;
  String? _authError;
  String? _currentUserEmail; // <- NEW

  bool get isAuthenticated => _isAuthenticated;
  String? get authError => _authError;
  String? get userEmail => _currentUserEmail; // <- NEW getter

  Future<bool> login(String email, String password) async {
    _authError = null;

    if (!email.contains('@')) {
      _authError = 'Please enter a valid email address';
      notifyListeners();
      return false;
    }

    if (!_validUsers.containsKey(email)) {
      _authError = 'User does not exist';
      notifyListeners();
      return false;
    }

    if (_validUsers[email] != password) {
      _authError = 'Wrong password';
      notifyListeners();
      return false;
    }

    // Successful login
    _isAuthenticated = true;
    _currentUserEmail = email; // <- Set the logged-in user
    notifyListeners();
    return true;
  }

  Future<bool> googleSignIn() async {
    _isAuthenticated = true;
    _currentUserEmail = 'google_user@example.com'; // simulate
    notifyListeners();
    return true;
  }

  void logout() {
    _isAuthenticated = false;
    _currentUserEmail = null;
    notifyListeners();
  }
}
