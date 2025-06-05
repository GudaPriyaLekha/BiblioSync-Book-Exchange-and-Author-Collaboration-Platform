// import 'package:flutter/material.dart';

// class ManageNetworkScreen extends StatelessWidget {
//   const ManageNetworkScreen({super.key});

//   final List<String> _requestsSent = const [
//     'Ananya Sharma',
//     'Amit Joshi',
//   ];

//   final List<String> _requestsReceived = const [
//     'Meena Gupta',
//     'Arjun Reddy',
//   ];

//   final List<Map<String, String>> _connections = const [
//     {
//       'name': 'Rohit Verma',
//       'email': 'rohit.verma@example.com',
//       'genres': 'Sci-Fi, Thriller',
//       'city': 'Delhi',
//     },
//     {
//       'name': 'Kavya Nair',
//       'email': 'kavya.nair@example.com',
//       'genres': 'Fantasy, Adventure',
//       'city': 'Bangalore',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Manage My Network')),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildSectionTitle('Requests Sent'),
//             ..._requestsSent.map((name) => ListTile(
//                   title: Text(name),
//                   trailing: TextButton(
//                     onPressed: () {},
//                     child: const Text('Withdraw'),
//                   ),
//                 )),

//             const Divider(height: 32),

//             _buildSectionTitle('Requests Received'),
//             ..._requestsReceived.map((name) => ListTile(
//                   title: Text(name),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       TextButton(onPressed: () {}, child: const Text('Accept')),
//                       TextButton(onPressed: () {}, child: const Text('Ignore')),
//                     ],
//                   ),
//                 )),

//             const Divider(height: 32),

//             _buildSectionTitle('My Connections'),
//             ..._connections.map((conn) => Card(
//                   margin: const EdgeInsets.symmetric(vertical: 8),
//                   child: ListTile(
//                     leading: const CircleAvatar(child: Icon(Icons.person)),
//                     title: Text(conn['name']!),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Email: ${conn['email']}'),
//                         Text('Genres: ${conn['genres']}'),
//                         Text('City: ${conn['city']}'),
//                       ],
//                     ),
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title) => Padding(
//         padding: const EdgeInsets.symmetric(vertical: 12.0),
//         child: Text(
//           title,
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//       );
// }
//workig
// import 'package:flutter/material.dart';

// class ManageNetworkScreen extends StatefulWidget {
//   const ManageNetworkScreen({super.key});

//   @override
//   _ManageNetworkScreenState createState() => _ManageNetworkScreenState();
// }

// class _ManageNetworkScreenState extends State<ManageNetworkScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   final List<String> _requestsSent = const ['Ananya Sharma', 'Amit Joshi'];
//   final List<String> _requestsReceived = const ['Meena Gupta', 'Arjun Reddy'];
//   final List<Map<String, String>> _connections = const [
//     {
//       'name': 'Rohit Verma',
//       'email': 'rohit.verma@example.com',
//       'genres': 'Sci-Fi, Thriller',
//       'city': 'Delhi',
//     },
//     {
//       'name': 'Kavya Nair',
//       'email': 'kavya.nair@example.com',
//       'genres': 'Fantasy, Adventure',
//       'city': 'Bangalore',
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   void _withdrawRequest(String name) {
//     setState(() {
//       _requestsSent.remove(name);
//     });
//   }

//   void _acceptRequest(String name) {
//     setState(() {
//       _requestsReceived.remove(name);
//       _connections.add({
//         'name': name,
//         'email': '$name@example.com',
//         'genres': 'Genre example',
//         'city': 'City example',
//       });
//     });
//   }

//   void _ignoreRequest(String name) {
//     setState(() {
//       _requestsReceived.remove(name);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Manage My Network'),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: const [
//             Tab(text: 'Requests Sent'),
//             Tab(text: 'Requests Received'),
//             Tab(text: 'My Connections'),
//           ],
//         ),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             const DrawerHeader(child: Text('Menu')),
//             ListTile(
//               title: const Text('Find Authors'),
//               onTap: () {
//                 Navigator.pushNamed(context, '/findAuthors');
//               },
//             ),
//             ListTile(
//               title: const Text('Settings'),
//               onTap: () {
//                 // Navigate to Settings
//               },
//             ),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildRequestsSent(),
//           _buildRequestsReceived(),
//           _buildConnections(),
//         ],
//       ),
//     );
//   }

//   Widget _buildRequestsSent() {
//     return ListView(
//       children: _requestsSent.map((name) {
//         return ListTile(
//           title: Text(name),
//           trailing: TextButton(
//             onPressed: () => _withdrawRequest(name),
//             child: const Text('Withdraw'),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildRequestsReceived() {
//     return ListView(
//       children: _requestsReceived.map((name) {
//         return ListTile(
//           title: Text(name),
//           trailing: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextButton(
//                 onPressed: () => _acceptRequest(name),
//                 child: const Text('Accept'),
//               ),
//               TextButton(
//                 onPressed: () => _ignoreRequest(name),
//                 child: const Text('Ignore'),
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildConnections() {
//     return ListView(
//       children: _connections.map((conn) {
//         return Card(
//           margin: const EdgeInsets.symmetric(vertical: 8),
//           child: ListTile(
//             leading: const CircleAvatar(child: Icon(Icons.person)),
//             title: Text(conn['name']!),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Email: ${conn['email']}'),
//                 Text('Genres: ${conn['genres']}'),
//                 Text('City: ${conn['city']}'),
//               ],
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ManageNetworkScreen extends StatefulWidget {
  const ManageNetworkScreen({super.key});

  @override
  _ManageNetworkScreenState createState() => _ManageNetworkScreenState();
}

class _ManageNetworkScreenState extends State<ManageNetworkScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Making lists mutable by removing the 'const' keyword
  List<String> _requestsSent = ['Ananya Sharma', 'Amit Joshi'];
  List<String> _requestsReceived = ['Meena Gupta', 'Arjun Reddy'];
  List<Map<String, String>> _connections = [
    {
      'name': 'Rohit Verma',
      'email': 'rohit.verma@example.com',
      'genres': 'Sci-Fi, Thriller',
      'city': 'Delhi',
    },
    {
      'name': 'Kavya Nair',
      'email': 'kavya.nair@example.com',
      'genres': 'Fantasy, Adventure',
      'city': 'Bangalore',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Function to withdraw a sent request
  void _withdrawRequest(String name) {
    setState(() {
      _requestsSent.remove(name); // Remove from sent requests
    });
  }

  // Function to accept a received request
  void _acceptRequest(String name) {
    setState(() {
      _requestsReceived.remove(name); // Remove from received requests
      _connections.add({
        'name': name,
        'email': '$name@example.com',
        'genres': 'Genre example',
        'city': 'City example',
      }); // Add to connections
    });
  }

  // Function to ignore a received request
  void _ignoreRequest(String name) {
    setState(() {
      _requestsReceived.remove(name); // Remove from received requests
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage My Network'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Requests Sent'),
            Tab(text: 'Requests Received'),
            Tab(text: 'My Connections'),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Menu')),
            ListTile(
              title: const Text('Find Authors'),
              onTap: () {
                Navigator.pushNamed(context, '/findAuthors');
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                // Navigate to Settings
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRequestsSent(),
          _buildRequestsReceived(),
          _buildConnections(),
        ],
      ),
    );
  }

  // Build the Sent Requests tab
  Widget _buildRequestsSent() {
    return ListView(
      children: _requestsSent.map((name) {
        return ListTile(
          title: Text(name),
          trailing: TextButton(
            onPressed: () => _withdrawRequest(name),
            child: const Text('Withdraw'),
          ),
        );
      }).toList(),
    );
  }

  // Build the Received Requests tab
  Widget _buildRequestsReceived() {
    return ListView(
      children: _requestsReceived.map((name) {
        return ListTile(
          title: Text(name),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () => _acceptRequest(name),
                child: const Text('Accept'),
              ),
              TextButton(
                onPressed: () => _ignoreRequest(name),
                child: const Text('Ignore'),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // Build the My Connections tab
  Widget _buildConnections() {
    return ListView(
      children: _connections.map((conn) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(conn['name']!),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email: ${conn['email']}'),
                Text('Genres: ${conn['genres']}'),
                Text('City: ${conn['city']}'),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
