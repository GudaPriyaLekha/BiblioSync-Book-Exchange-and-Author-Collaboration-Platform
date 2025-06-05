import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController(text: 'John Doe');
  final _emailController = TextEditingController(text: 'john@example.com');
  final _passwordController = TextEditingController();
  final _cityController = TextEditingController(text: 'Mumbai');
  final _phoneController = TextEditingController(text: '1234567890');

  File? _profileImage;
  bool _interestedInCollab = true;

  final _genres = ['Romance', 'Thriller', 'Fantasy', 'Sci-Fi', 'Drama', 'Mystery'];
  final _authors = ['Author A', 'Author B', 'Author C', 'Author D'];
  final _books = ['Book X', 'Book Y', 'Book Z'];

  List<String> _selectedGenres = [];
  List<String> _selectedAuthors = [];
  List<String> _selectedBooks = [];

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _profileImage = File(picked.path);
      });
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Save logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Profile Picture
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : const AssetImage('assets/default_avatar.jpg') as ImageProvider,
                  child: _profileImage == null
                      ? const Icon(Icons.camera_alt, size: 30, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(height: 16),

              // Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
              ),

              // Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value!.contains('@') ? null : 'Enter a valid email',
              ),

              // Password
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),

              // Phone Number
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
              ),

              // City
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'City'),
              ),

              const SizedBox(height: 16),

              // Multi-select Genres
              MultiSelectDialogField<String>(
                items: _genres.map((genre) => MultiSelectItem(genre, genre)).toList(),
                title: const Text('Favorite Genres'),
                buttonText: const Text('Select Genres'),
                listType: MultiSelectListType.CHIP,
                initialValue: _selectedGenres,
                onConfirm: (values) {
                  setState(() {
                    _selectedGenres = values;
                  });
                },
              ),

              const SizedBox(height: 12),

              // Multi-select Authors
              MultiSelectDialogField<String>(
                items: _authors.map((author) => MultiSelectItem(author, author)).toList(),
                title: const Text('Favorite Authors'),
                buttonText: const Text('Select Authors'),
                listType: MultiSelectListType.CHIP,
                initialValue: _selectedAuthors,
                onConfirm: (values) {
                  setState(() {
                    _selectedAuthors = values;
                  });
                },
              ),

              const SizedBox(height: 12),

              // Multi-select Books
              MultiSelectDialogField<String>(
                items: _books.map((book) => MultiSelectItem(book, book)).toList(),
                title: const Text('Favorite Books'),
                buttonText: const Text('Select Books'),
                listType: MultiSelectListType.CHIP,
                initialValue: _selectedBooks,
                onConfirm: (values) {
                  setState(() {
                    _selectedBooks = values;
                  });
                },
              ),

              const SizedBox(height: 16),

              // Collaboration Toggle
              SwitchListTile(
                title: const Text('Interested in Author Collaboration'),
                value: _interestedInCollab,
                onChanged: (value) {
                  setState(() {
                    _interestedInCollab = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              // Save Button
              ElevatedButton.icon(
                onPressed: _saveProfile,
                icon: const Icon(Icons.save),
                label: const Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
