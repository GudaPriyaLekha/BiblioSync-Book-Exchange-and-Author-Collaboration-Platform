// import 'package:flutter/material.dart';
// import 'package:book_manager/src/models/book.dart';

// class BookStore extends ChangeNotifier {
//   List<Book> _books = [];
//   bool _isLoading = false;

//   List<Book> get books => _books;
//   bool get isLoading => _isLoading;

//   Future<void> loadBooks() async {
//     _isLoading = true;
//     notifyListeners();
    
//     await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    
//     _books = [
//       Book(
//         id: '1',
//         title: 'Flutter in Action',
//         author: 'Eric Windmill',
//         coverUrl: 'https://m.media-amazon.com/images/I/51F3u-9Yv8L._SY425_.jpg',
//         rating: 4.5,
//         genres: ['Technology', 'Programming'],
//         description: 'A hands-on guide to building cross-platform mobile applications with Flutter.',
//       ),
//       Book(
//         id: '2',
//         title: 'Clean Code',
//         author: 'Robert C. Martin',
//         coverUrl: 'https://m.media-amazon.com/images/I/41xShlnTZTL._SY425_.jpg',
//         rating: 4.7,
//         genres: ['Programming', 'Software Development'],
//         description: 'A handbook of agile software craftsmanship with practical advice for writing clean code.',
//       ),
//       Book(
//         id: '3',
//         title: 'The Silent Patient',
//         author: 'Alex Michaelides',
//         coverUrl: 'https://m.media-amazon.com/images/I/51y6XHiLthL._SY425_.jpg',
//         rating: 4.3,
//         genres: ['Mystery', 'Thriller', 'Fiction'],
//         description: 'A psychological thriller about a woman who shoots her husband and then stops speaking.',
//         isAvailable: false,
//       ),
//       Book(
//         id: '4',
//         title: 'Sapiens: A Brief History of Humankind',
//         author: 'Yuval Noah Harari',
//         coverUrl: 'https://m.media-amazon.com/images/I/51K8ZRfCjRL._SY425_.jpg',
//         rating: 4.6,
//         genres: ['History', 'Non-Fiction', 'Anthropology'],
//         description: 'Explores the history of humankind from the evolution of Homo sapiens to the present.',
//       ),
//       Book(
//         id: '5',
//         title: 'Dune',
//         author: 'Frank Herbert',
//         coverUrl: 'https://m.media-amazon.com/images/I/41UZeCEKOBL._SY425_.jpg',
//         rating: 4.7,
//         genres: ['Science Fiction', 'Fantasy'],
//         description: 'A science fiction novel about the son of a noble family entrusted with the protection of the most valuable asset in the galaxy.',
//       ),
//       Book(
//         id: '6',
//         title: 'Atomic Habits',
//         author: 'James Clear',
//         coverUrl: 'https://m.media-amazon.com/images/I/51B7kuFwQFL._SY425_.jpg',
//         rating: 4.8,
//         genres: ['Self-Help', 'Non-Fiction', 'Psychology'],
//         description: 'A guide to building good habits and breaking bad ones with proven strategies.',
//       ),
//       Book(
//         id: '7',
//         title: 'The Hobbit',
//         author: 'J.R.R. Tolkien',
//         coverUrl: 'https://m.media-amazon.com/images/I/41aQPTCmeVL._SY425_.jpg',
//         rating: 4.8,
//         genres: ['Fantasy', 'Adventure', 'Fiction'],
//         description: 'A fantasy novel about the quest of home-loving Bilbo Baggins to win a share of the treasure guarded by the dragon Smaug.',
//       ),
//       Book(
//         id: '8',
//         title: 'Educated',
//         author: 'Tara Westover',
//         coverUrl: 'https://m.media-amazon.com/images/I/51VkBx8jA6L._SY425_.jpg',
//         rating: 4.7,
//         genres: ['Biography', 'Memoir', 'Non-Fiction'],
//         description: 'A memoir about a woman who leaves her survivalist family and goes on to earn a PhD from Cambridge University.',
//       ),
//     ];
    
//     _isLoading = false;
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:book_manager/src/models/book.dart';

class BookStore extends ChangeNotifier {
  List<Book> _books = [];
  bool _isLoading = false;

  List<Book> get books => _books;
  bool get isLoading => _isLoading;

  // Method to remove a book by its ID
  void removeBook(String id) {
    _books.removeWhere((book) => book.id == id);
    notifyListeners();
  }

  Future<void> loadBooks() async {
    _isLoading = true;
    notifyListeners();
    
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    
    // Updated books list with all the necessary fields
    _books = [
      Book(
        id: '1',
        title: 'Flutter in Action',
        author: 'Eric Windmill',
        coverUrl: 'https://m.media-amazon.com/images/I/51F3u-9Yv8L._SY425_.jpg',
        rating: 4.5,
        genres: ['Technology', 'Programming'],
        description: 'A hands-on guide to building cross-platform mobile applications with Flutter.',
      ),
      Book(
        id: '2',
        title: 'Clean Code',
        author: 'Robert C. Martin',
        coverUrl: 'https://m.media-amazon.com/images/I/41xShlnTZTL._SY425_.jpg',
        rating: 4.7,
         owner: 'priyalekhaguda2710@gmail.com',
        genres: ['Programming', 'Software Development'],
        description: 'A handbook of agile software craftsmanship with practical advice for writing clean code.',
      ),
      Book(
        id: '3',
        title: 'The Silent Patient',
        author: 'Alex Michaelides',
        coverUrl: 'https://m.media-amazon.com/images/I/51y6XHiLthL._SY425_.jpg',
        rating: 4.3,
         owner: 'priyalekhaguda2710@gmail.com',
        genres: ['Mystery', 'Thriller', 'Fiction'],
        description: 'A psychological thriller about a woman who shoots her husband and then stops speaking.',
        // `status` is not specified, so default will be 'Available'.
      ),
      Book(
        id: '4',
        title: 'Sapiens: A Brief History of Humankind',
        author: 'Yuval Noah Harari',
         owner: 'priyalekhaguda2710@gmail.com',
        coverUrl: 'https://m.media-amazon.com/images/I/51K8ZRfCjRL._SY425_.jpg',
        rating: 4.6,
        genres: ['History', 'Non-Fiction', 'Anthropology'],
        description: 'Explores the history of humankind from the evolution of Homo sapiens to the present.',
      ),
      Book(
        id: '5',
        title: 'Dune',
        author: 'Frank Herbert',
        coverUrl: 'https://m.media-amazon.com/images/I/41UZeCEKOBL._SY425_.jpg',
        rating: 4.7,
        genres: ['Science Fiction', 'Fantasy'],
        description: 'A science fiction novel about the son of a noble family entrusted with the protection of the most valuable asset in the galaxy.',
      ),
      Book(
        id: '6',
        title: 'Atomic Habits',
        author: 'James Clear',
        coverUrl: 'https://m.media-amazon.com/images/I/51B7kuFwQFL._SY425_.jpg',
        rating: 4.8,
        genres: ['Self-Help', 'Non-Fiction', 'Psychology'],
        description: 'A guide to building good habits and breaking bad ones with proven strategies.',
      ),
      Book(
        id: '7',
        title: 'The Hobbit',
        author: 'J.R.R. Tolkien',
        coverUrl: 'https://m.media-amazon.com/images/I/41aQPTCmeVL._SY425_.jpg',
        rating: 4.8,
        genres: ['Fantasy', 'Adventure', 'Fiction'],
        description: 'A fantasy novel about the quest of home-loving Bilbo Baggins to win a share of the treasure guarded by the dragon Smaug.',
      ),
      Book(
        id: '8',
        title: 'Educated',
        author: 'Tara Westover',
        coverUrl: 'https://m.media-amazon.com/images/I/51VkBx8jA6L._SY425_.jpg',
        rating: 4.7,
         owner: 'priyalekhaguda2710@gmail.com',
        genres: ['Biography', 'Memoir', 'Non-Fiction'],
        description: 'A memoir about a woman who leaves her survivalist family and goes on to earn a PhD from Cambridge University.',
      ),
    ];
    
    _isLoading = false;
    notifyListeners();
  }
}
