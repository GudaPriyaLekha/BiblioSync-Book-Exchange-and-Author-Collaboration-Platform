// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:book_manager/src/stores/book_store.dart';
// import 'package:book_manager/src/models/book.dart';

// class ManageBooksScreen extends StatelessWidget {
//   const ManageBooksScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final bookStore = Provider.of<BookStore>(context);
//     final myBooks = bookStore.books.where((book) => book.owner == 'You').toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Manage My Books'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: myBooks.length,
//         itemBuilder: (context, index) {
//           final book = myBooks[index];
//           return Card(
//             margin: const EdgeInsets.only(bottom: 16),
//             elevation: 2,
//             child: ListTile(
//               leading: const Icon(Icons.book, size: 40),
//               title: Text(book.title),
//               subtitle: Text('by ${book.author}'),
//               trailing: IconButton(
//                 icon: const Icon(Icons.delete, color: Colors.red),
//                 onPressed: () {
//                   _showDeleteDialog(context, bookStore, book);
//                 },
//               ),
//               onTap: () {
//                 _showBookDetails(context, book);
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }

//   void _showDeleteDialog(BuildContext context, BookStore bookStore, Book book) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Delete Book'),
//           content: Text('Are you sure you want to delete "${book.title}"?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 bookStore.removeBook(book.id);
//                 Navigator.pop(context);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('"${book.title}" has been deleted'),
//                     behavior: SnackBarBehavior.floating,
//                   ),
//                 );
//               },
//               child: const Text('Delete', style: TextStyle(color: Colors.red)),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showBookDetails(BuildContext context, Book book) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Text(
//                   book.title,
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text('Author: ${book.author}'),
//               const SizedBox(height: 8),
//               Text('Status: ${book.status}'),
//               const SizedBox(height: 8),
//               if (book.genres != null && book.genres!.isNotEmpty)
//                 Text('Genres: ${book.genres!.join(', ')}'),
//               const SizedBox(height: 8),
//               if (book.publishYear != null)
//                 Text('Published: ${book.publishYear}'),
//               const SizedBox(height: 16),
//               if (book.description != null)
//                 Text(
//                   'Description: ${book.description}',
//                   style: const TextStyle(fontSize: 14),
//                 ),
//               const SizedBox(height: 24),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text('Close'),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_manager/src/stores/book_store.dart';
import 'package:book_manager/src/models/book.dart';
import 'package:book_manager/src/stores/auth_store.dart';

class ManageBooksScreen extends StatelessWidget {
  const ManageBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookStore = Provider.of<BookStore>(context);
    final authStore = Provider.of<AuthStore>(context);
    final userEmail = authStore.userEmail ?? '';

    final myBooks = bookStore.books
        .where((book) => book.owner == userEmail)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage My Books'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: myBooks.isEmpty
          ? const Center(child: Text('No books added yet.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: myBooks.length,
              itemBuilder: (context, index) {
                final book = myBooks[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  child: ListTile(
                    leading: const Icon(Icons.book, size: 40),
                    title: Text(book.title),
                    subtitle: Text('by ${book.author}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _showDeleteDialog(context, bookStore, book);
                      },
                    ),
                    onTap: () {
                      _showBookDetails(context, book);
                    },
                  ),
                );
              },
            ),
    );
  }

  void _showDeleteDialog(BuildContext context, BookStore bookStore, Book book) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Book'),
          content: Text('Are you sure you want to delete "${book.title}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                bookStore.removeBook(book.id);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('"${book.title}" has been deleted'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _showBookDetails(BuildContext context, Book book) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  book.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 16),
              Text('Author: ${book.author}'),
              const SizedBox(height: 8),
              Text('Status: ${book.status}'),
              const SizedBox(height: 8),
              if (book.genres != null && book.genres!.isNotEmpty)
                Text('Genres: ${book.genres!.join(', ')}'),
              const SizedBox(height: 8),
              if (book.publishYear != null)
                Text('Published: ${book.publishYear}'),
              const SizedBox(height: 16),
              if (book.description != null)
                Text(
                  'Description: ${book.description}',
                  style: const TextStyle(fontSize: 14),
                ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
