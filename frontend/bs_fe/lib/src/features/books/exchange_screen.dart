import 'package:flutter/material.dart';
import 'package:book_manager/src/models/book.dart';

class ExchangeScreen extends StatelessWidget {
  ExchangeScreen({super.key}); // Removed `const`

  final List<Book> exchangedBooks = [
    Book(
      id: 'ex1',
      title: 'The Silent Patient',
      author: 'Alex Michaelides',
      status: 'Exchanged',
      borrower: 'Jane Doe',
      exchangeDate: '2023-05-15',
    ),
    Book(
      id: 'ex2',
      title: 'Atomic Habits',
      author: 'James Clear',
      status: 'Exchanged',
      borrower: 'John Smith',
      exchangeDate: '2023-06-20',
    ),
  ];

  // Dummy data for borrowed books
  final List<Book> borrowedBooks =  [
    Book(
      id: 'b1',
      title: 'Clean Code',
      author: 'Robert C. Martin',
      status: 'Borrowed',
      owner: 'Sarah Johnson',
      borrowDate: '2023-07-10',
      returnDate: '2023-08-10',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Book Exchange'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'My Exchanged Books'),
              Tab(text: 'Borrowed Books'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Exchanged Books Tab
            _buildBookList(
              context,
              exchangedBooks,
              'You have not exchanged any books yet',
            ),
            // Borrowed Books Tab
            _buildBookList(
              context,
              borrowedBooks,
              'You have not borrowed any books',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookList(BuildContext context, List<Book> books, String emptyMessage) {
    if (books.isEmpty) {
      return Center(
        child: Text(
          emptyMessage,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text('by ${book.author}'),
                const SizedBox(height: 8),
                if (book.status == 'Exchanged')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Borrower: ${book.borrower}'),
                      Text('Exchanged on: ${book.exchangeDate}'),
                    ],
                  )
                else if (book.status == 'Borrowed')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Owner: ${book.owner}'),
                      Text('Borrowed on: ${book.borrowDate}'),
                      Text('Due date: ${book.returnDate}'),
                    ],
                  ),
                const SizedBox(height: 16),
                if (book.status == 'Borrowed')
                  ElevatedButton(
                    onPressed: () {
                      // Implement return book functionality
                    },
                    child: const Text('Return Book'),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}