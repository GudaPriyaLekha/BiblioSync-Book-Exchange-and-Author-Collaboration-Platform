// // lib/src/features/books/dashboard_screen.dart
// import 'package:flutter/material.dart';
// import 'package:book_manager/src/features/books/explore_books_screen.dart';
// import 'package:book_manager/src/features/books/add_book_screen.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   int _selectedIndex = 0;

//   static final List<Widget> _screens = [
//     const ExploreBooksScreen(), // Default landing page
//     const AddBookScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Book Manager')),
//       body: _screens[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.explore),
//             label: 'Explore',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             label: 'Add Book',
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:book_manager/src/features/books/explore_books_screen.dart';
import 'package:book_manager/src/features/books/add_book_screen.dart';
import 'package:book_manager/src/features/author/author_collab_screen.dart';
import 'package:book_manager/src/features/profile/ProfileScreen.dart';
import 'package:provider/provider.dart';
import 'package:book_manager/src/stores/auth_store.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    const ExploreBooksScreen(),
    const AddBookScreen(),
    const AuthorCollabScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideNavigation(context),
      appBar: AppBar(
        title: const Text('BiblioSync'),
       
      ),
      body: _screens[_selectedIndex],
    );
  }

  Widget _buildSideNavigation(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BiblioSync',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Book Management System',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // Book Management Section
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Text(
              'Book Management',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.explore),
            title: const Text('Explore Books'),
            selected: _selectedIndex == 0,
            onTap: () {
              setState(() => _selectedIndex = 0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add New Book'),
            selected: _selectedIndex == 1,
            onTap: () {
              setState(() => _selectedIndex = 1);
              Navigator.pop(context);
            },
          ),
          ListTile(
  leading: const Icon(Icons.collections_bookmark),
  title: const Text('Manage My Books'),
  onTap: () {
    Navigator.pushNamed(context, '/manage-books');
  },
),
ListTile(
  leading: const Icon(Icons.swap_horiz),
  title: const Text('Book Exchange'),
  onTap: () {
    Navigator.pushNamed(context, '/exchange');
  },
),
          const Divider(),
const Padding(
  padding: EdgeInsets.only(left: 16, top: 16),
  child: Text(
    'Author Collaboration',
    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
  ),
),
ListTile(
  leading: const Icon(Icons.search),
  title: const Text('Find Authors'),
  onTap: () {
    Navigator.pushNamed(context, '/find-authors');
  },
),
ListTile(
  leading: const Icon(Icons.group),
  title: const Text('Manage My Network'),
  onTap: () {
    Navigator.pushNamed(context, '/my-network');
  },
),
          const Divider(),
          // Profile Section
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            selected: _selectedIndex == 3,
            onTap: () {
              setState(() => _selectedIndex = 3);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Provider.of<AuthStore>(context, listen: false).logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}