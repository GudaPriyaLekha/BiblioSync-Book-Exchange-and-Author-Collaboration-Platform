import 'package:flutter/material.dart';

// Add this Book class definition (create in a separate file if preferred)
class Book {
  final String id;
  final String title;
  final String author;
  final String status;
  final String? coverUrl;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.status,
    this.coverUrl,
  });
}

class ExploreBooksScreen extends StatelessWidget {
  // Sample book data
  final List<Book> books = [
    Book(
      id: '1',
      title: 'Flutter for Beginners',
      author: 'John Doe',
      status: 'Available',
      coverUrl: null,
    ),
    Book(
      id: '2',
      title: 'Advanced Dart Programming',
      author: 'Jane Smith',
      status: 'Borrowed',
      coverUrl: null,
    ),
    Book(
      id: '3',
      title: 'Clean Architecture',
      author: 'Robert Martin',
      status: 'Available',
      coverUrl: null,
    ),
  ];

  ExploreBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explore Books')),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: book.coverUrl != null
                  ? Image.network(book.coverUrl!)
                  : const Icon(Icons.book, size: 40),
              title: Text(book.title),
              subtitle: Text('${book.author} • ${book.status}'),
              trailing: book.status == 'Available'
                  ? ElevatedButton(
                      onPressed: () => _lendBook(context, book),
                      child: const Text('Lend'),
                    )
                  : null,
              onTap: () => _showBookDetails(context, book),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddBook(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _lendBook(BuildContext context, Book book) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lend Book'),
        content: Text('Are you sure you want to lend "${book.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Implement lending logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${book.title} lent successfully')),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showBookDetails(BuildContext context, Book book) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(book.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Author: ${book.author}'),
            const SizedBox(height: 8),
            Text('Status: ${book.status}'),
            const SizedBox(height: 16),
            if (book.coverUrl != null)
              Image.network(book.coverUrl!, height: 150),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToAddBook(BuildContext context) {
    Navigator.pushNamed(context, '/add-book');
  }
}