import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  String _selectedRole = 'reader';
  String? _selectedGenre;
  final List<String> _favoriteBooks = [];
  final List<String> _favoriteAuthors = [];
  final _bookInputController = TextEditingController();
  final _authorInputController = TextEditingController();

  // Define genres list here
  final List<String> genres = [
    'Fiction',
    'Non-Fiction',
    'Science Fiction',
    'Fantasy',
    'Mystery',
    'Romance',
    'Thriller',
    'Biography',
    'History',
    'Self-Help'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _bookInputController.dispose();
    _authorInputController.dispose();
    super.dispose();
  }

  void _addFavoriteBook() {
    if (_bookInputController.text.trim().isNotEmpty) {
      setState(() {
        _favoriteBooks.add(_bookInputController.text.trim());
        _bookInputController.clear();
      });
    }
  }

  void _addFavoriteAuthor() {
    if (_authorInputController.text.trim().isNotEmpty) {
      setState(() {
        _favoriteAuthors.add(_authorInputController.text.trim());
        _authorInputController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Confirm Password'),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                items: const [
                  DropdownMenuItem(value: 'reader', child: Text('Reader')),
                  DropdownMenuItem(value: 'author', child: Text('Author')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Role'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedGenre,
                items: genres.map((genre) => DropdownMenuItem(
                  value: genre,
                  child: Text(genre),
                )).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGenre = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Favorite Genre'),
                hint: const Text('Select a genre'),
              ),
              const SizedBox(height: 24),
              const Text('Favorite Books:', style: TextStyle(fontWeight: FontWeight.bold)),
              ..._favoriteBooks.map((book) => ListTile(
                title: Text(book),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () {
                    setState(() {
                      _favoriteBooks.remove(book);
                    });
                  },
                ),
              )),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _bookInputController,
                      decoration: const InputDecoration(labelText: 'Add favorite book'),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    onPressed: _addFavoriteBook,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Favorite Authors:', style: TextStyle(fontWeight: FontWeight.bold)),
              ..._favoriteAuthors.map((author) => ListTile(
                title: Text(author),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () {
                    setState(() {
                      _favoriteAuthors.remove(author);
                    });
                  },
                ),
              )),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _authorInputController,
                      decoration: const InputDecoration(labelText: 'Add favorite author'),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    onPressed: _addFavoriteAuthor,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle registration logic
                    Navigator.pop(context); // Return to login screen
                  }
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}