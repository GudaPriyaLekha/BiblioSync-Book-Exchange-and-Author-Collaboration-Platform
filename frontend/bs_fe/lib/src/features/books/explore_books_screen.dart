// import 'package:book_manager/src/models/book.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:book_manager/src/stores/book_store.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:shimmer/shimmer.dart';

// class ExploreBooksScreen extends StatefulWidget {
//   const ExploreBooksScreen({super.key});

//   @override
//   State<ExploreBooksScreen> createState() => _ExploreBooksScreenState();
// }

// class _ExploreBooksScreenState extends State<ExploreBooksScreen> {
//   String _selectedCategory = 'All';
//   final TextEditingController _searchController = TextEditingController();
//   final List<String> _categories = [
//     'All',
//     'Fiction',
//     'Non-Fiction',
//     'Science',
//     'Biography',
//     'Technology',
//     'History',
//     'Fantasy',
//     'Romance',
//     'Mystery'
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Load books when screen initializes
//     Provider.of<BookStore>(context, listen: false).loadBooks();
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bookStore = Provider.of<BookStore>(context);
//     final filteredBooks = _filterBooks(bookStore.books);

//     return Scaffold(
//       // drawer: _buildSideNavBar(context),
//       appBar: AppBar(
//         title: const Text('Explore Books'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () => _showSearchDialog(context),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Categories chips
//           SizedBox(
//             height: 60,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: _categories.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 4),
//                   child: FilterChip(
//                     label: Text(_categories[index]),
//                     selected: _selectedCategory == _categories[index],
//                     onSelected: (bool selected) {
//                       setState(() {
//                         _selectedCategory = selected ? _categories[index] : 'All';
//                       });
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//           // Books list
//           Expanded(
//             child: bookStore.isLoading
//                 ? _buildShimmerLoader()
//                 : filteredBooks.isEmpty
//                     ? _buildEmptyState()
//                     : ListView.builder(
//                         padding: const EdgeInsets.all(16),
//                         itemCount: filteredBooks.length,
//                         itemBuilder: (context, index) {
//                           return _buildBookCard(filteredBooks[index], context);
//                         },
//                       ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget _buildSideNavBar(BuildContext context) {
//   //   return Drawer(
//   //     child: ListView(
//   //       padding: EdgeInsets.zero,
//   //       children: [
//   //         const DrawerHeader(
//   //           decoration: BoxDecoration(
//   //             color: Colors.blue,
//   //           ),
//   //           child: Text(
//   //             'Book Manager',
//   //             style: TextStyle(color: Colors.white, fontSize: 24),
//   //           ),
//   //         ),
//   //         ListTile(
//   //           leading: const Icon(Icons.explore),
//   //           title: const Text('Explore Books'),
//   //           onTap: () {
//   //             Navigator.pop(context);
//   //           },
//   //         ),
//   //         ListTile(
//   //           leading: const Icon(Icons.add),
//   //           title: const Text('Add New Book'),
//   //           onTap: () {
//   //             Navigator.pushNamed(context, '/add-book');
//   //           },
//   //         ),
//   //         ListTile(
//   //           leading: const Icon(Icons.collections_bookmark),
//   //           title: const Text('Manage My Books'),
//   //           onTap: () {
//   //             Navigator.pushNamed(context, '/manage-books');
//   //           },
//   //         ),
//   //         ListTile(
//   //           leading: const Icon(Icons.swap_horiz),
//   //           title: const Text('Book Exchange'),
//   //           onTap: () {
//   //             Navigator.pushNamed(context, '/exchange');
//   //           },
//   //         ),
//   //         const Divider(),
//   //         ListTile(
//   //           leading: const Icon(Icons.settings),
//   //           title: const Text('Settings'),
//   //           onTap: () {
//   //             Navigator.pushNamed(context, '/settings');
//   //           },
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   List<Book> _filterBooks(List<Book> books) {
//     return books.where((book) {
//       final matchesCategory = _selectedCategory == 'All' || 
//           (book.genres?.contains(_selectedCategory) ?? false);
//       final matchesSearch = _searchController.text.isEmpty ||
//           book.title.toLowerCase().contains(_searchController.text.toLowerCase()) ||
//           book.author.toLowerCase().contains(_searchController.text.toLowerCase());
//       return matchesCategory && matchesSearch;
//     }).toList();
//   }

//   Future<void> _showSearchDialog(BuildContext context) async {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Search Books'),
//           content: TextField(
//             controller: _searchController,
//             decoration: const InputDecoration(
//               hintText: 'Search by title or author...',
//             ),
//             onChanged: (value) {
//               setState(() {});
//               Navigator.pop(context);
//             },
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 _searchController.clear();
//                 setState(() {});
//                 Navigator.pop(context);
//               },
//               child: const Text('Clear'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildBookCard(Book book, BuildContext context) {
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.only(bottom: 16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(12),
//         onTap: () => _showBookDetails(context, book),
//         child: Padding(
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Book cover
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: CachedNetworkImage(
//                       imageUrl: book.coverUrl ?? '',
//                       width: 80,
//                       height: 120,
//                       fit: BoxFit.cover,
//                       placeholder: (context, url) => Container(
//                         width: 80,
//                         height: 120,
//                         color: Colors.grey[200],
//                       ),
//                       errorWidget: (context, url, error) => Container(
//                         width: 80,
//                         height: 120,
//                         color: Colors.grey[200],
//                         child: const Icon(Icons.book),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   // Book details
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           book.title,
//                           style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           'by ${book.author}',
//                           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                                 color: Colors.grey[600],
//                               ),
//                         ),
//                         const SizedBox(height: 8),
//                         if (book.genres != null && book.genres!.isNotEmpty)
//                           Wrap(
//                             spacing: 4,
//                             children: book.genres!
//                                 .map((genre) => Chip(
//                                       label: Text(genre),
//                                       padding: EdgeInsets.zero,
//                                       labelPadding: const EdgeInsets.symmetric(horizontal: 8),
//                                     ))
//                                 .toList(),
//                           ),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.star,
//                               color: Colors.amber[400],
//                               size: 16,
//                             ),
//                             const SizedBox(width: 4),
//                             Text(
//                               book.rating?.toStringAsFixed(1) ?? 'N/A',
//                               style: const TextStyle(fontSize: 14),
//                             ),
//                             const Spacer(),
//                             if (book.isAvailable)
//                               ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 12,
//                                     vertical: 4,
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                   // Handle borrow action
//                                 },
//                                 child: const Text('Borrow'),
//                               )
//                             else
//                               const Text(
//                                 'Checked Out',
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                   fontStyle: FontStyle.italic,
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               if (book.description != null && book.description!.isNotEmpty)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 12),
//                   child: Text(
//                     book.description!,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.search_off, size: 60, color: Colors.grey),
//           const SizedBox(height: 16),
//           Text(
//             'No books found',
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Try a different search or category',
//             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                   color: Colors.grey,
//                 ),
//           ),
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 _selectedCategory = 'All';
//                 _searchController.clear();
//               });
//             },
//             child: const Text('Reset filters'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildShimmerLoader() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: 6,
//       itemBuilder: (context, index) {
//         return Shimmer.fromColors(
//           baseColor: Colors.grey[300]!,
//           highlightColor: Colors.grey[100]!,
//           child: Card(
//             margin: const EdgeInsets.only(bottom: 16),
//             child: SizedBox(
//               height: 180,
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           width: 80,
//                           height: 120,
//                           color: Colors.white,
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 width: double.infinity,
//                                 height: 20,
//                                 color: Colors.white,
//                               ),
//                               const SizedBox(height: 10),
//                               Container(
//                                 width: 150,
//                                 height: 16,
//                                 color: Colors.white,
//                               ),
//                               const SizedBox(height: 20),
//                               Container(
//                                 width: 100,
//                                 height: 16,
//                                 color: Colors.white,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     Container(
//                       width: double.infinity,
//                       height: 16,
//                       color: Colors.white,
//                     ),
//                     const SizedBox(height: 4),
//                     Container(
//                       width: double.infinity,
//                       height: 16,
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
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
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: CachedNetworkImage(
//                     imageUrl: book.coverUrl ?? '',
//                     height: 200,
//                     fit: BoxFit.contain,
//                     placeholder: (context, url) => Container(
//                       height: 200,
//                       color: Colors.grey[200],
//                     ),
//                     errorWidget: (context, url, error) => Container(
//                       height: 200,
//                       color: Colors.grey[200],
//                       child: const Center(child: Icon(Icons.book, size: 60)),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 book.title,
//                 style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'by ${book.author}',
//                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                       color: Colors.grey[600],
//                     ),
//               ),
//               const SizedBox(height: 16),
//               if (book.genres != null && book.genres!.isNotEmpty)
//                 Wrap(
//                   spacing: 4,
//                   children: book.genres!
//                       .map((genre) => Chip(
//                             label: Text(genre),
//                           ))
//                       .toList(),
//                 ),
//               const SizedBox(height: 16),
//               if (book.description != null && book.description!.isNotEmpty)
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Description:',
//                       style: Theme.of(context).textTheme.titleMedium,
//                     ),
//                     const SizedBox(height: 8),
//                     Text(book.description!),
//                   ],
//                 ),
//               const SizedBox(height: 16),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     // Handle borrow action
//                   },
//                   child: Text(book.isAvailable ? 'Borrow Book' : 'Request Book'),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:book_manager/src/models/book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_manager/src/stores/book_store.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class ExploreBooksScreen extends StatefulWidget {
  const ExploreBooksScreen({super.key});

  @override
  State<ExploreBooksScreen> createState() => _ExploreBooksScreenState();
}

class _ExploreBooksScreenState extends State<ExploreBooksScreen> {
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  final List<String> _categories = [
    'All',
    'Fiction',
    'Non-Fiction',
    'Science',
    'Biography',
    'Technology',
    'History',
    'Fantasy',
    'Romance',
    'Mystery'
  ];

  @override
  void initState() {
    super.initState();
    // Load books when screen initializes
    Provider.of<BookStore>(context, listen: false).loadBooks();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookStore = Provider.of<BookStore>(context);
    final filteredBooks = _filterBooks(bookStore.books);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Books'),
        actions: [
          // Search TextField inside the AppBar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: 200,
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {}); // Rebuild to show filtered books
                },
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Categories chips
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    label: Text(_categories[index]),
                    selected: _selectedCategory == _categories[index],
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedCategory = selected ? _categories[index] : 'All';
                      });
                    },
                  ),
                );
              },
            ),
          ),
          // Books list
          Expanded(
            child: bookStore.isLoading
                ? _buildShimmerLoader()
                : filteredBooks.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredBooks.length,
                        itemBuilder: (context, index) {
                          return _buildBookCard(filteredBooks[index], context);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  List<Book> _filterBooks(List<Book> books) {
    return books.where((book) {
      final matchesCategory = _selectedCategory == 'All' || 
          (book.genres?.contains(_selectedCategory) ?? false);
      final matchesSearch = _searchController.text.isEmpty ||
          book.title.toLowerCase().contains(_searchController.text.toLowerCase()) ||
          book.author.toLowerCase().contains(_searchController.text.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  Widget _buildBookCard(Book book, BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showBookDetails(context, book),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Book cover
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: book.coverUrl ?? '',
                      width: 80,
                      height: 120,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 80,
                        height: 120,
                        color: Colors.grey[200],
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 80,
                        height: 120,
                        color: Colors.grey[200],
                        child: const Icon(Icons.book),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Book details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'by ${book.author}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey[600],
                              ),
                        ),
                        const SizedBox(height: 8),
                        if (book.genres != null && book.genres!.isNotEmpty)
                          Wrap(
                            spacing: 4,
                            children: book.genres!
                                .map((genre) => Chip(
                                      label: Text(genre),
                                      padding: EdgeInsets.zero,
                                      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                                    ))
                                .toList(),
                          ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber[400],
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              book.rating?.toStringAsFixed(1) ?? 'N/A',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const Spacer(),
                            if (book.isAvailable)
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () {
                                  // Handle borrow action
                                },
                                child: const Text('Borrow'),
                              )
                            else
                              const Text(
                                'Checked Out',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (book.description != null && book.description!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    book.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off, size: 60, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'No books found',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Try a different search or category',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _selectedCategory = 'All';
                _searchController.clear();
              });
            },
            child: const Text('Reset filters'),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoader() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              height: 180,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 120,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 20,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: 150,
                                height: 16,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: 100,
                                height: 16,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      height: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: book.coverUrl ?? '',
                    height: 200,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Container(
                      height: 200,
                      color: Colors.grey[200],
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: const Center(child: Icon(Icons.book, size: 60)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                book.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'by ${book.author}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 16),
              if (book.genres != null && book.genres!.isNotEmpty)
                Wrap(
                  spacing: 4,
                  children: book.genres!
                      .map((genre) => Chip(
                            label: Text(genre),
                          ))
                      .toList(),
                ),
              const SizedBox(height: 16),
              if (book.description != null && book.description!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(book.description!),
                  ],
                ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Handle borrow action
                  },
                  child: Text(book.isAvailable ? 'Borrow Book' : 'Request Book'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
