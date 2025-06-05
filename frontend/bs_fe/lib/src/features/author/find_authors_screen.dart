import 'package:flutter/material.dart';

class FindAuthorsScreen extends StatefulWidget {
  const FindAuthorsScreen({super.key});

  @override
  _FindAuthorsScreenState createState() => _FindAuthorsScreenState();
}

class _FindAuthorsScreenState extends State<FindAuthorsScreen> {
  final List<Map<String, dynamic>> _authors = const [
    {
      'name': 'Ananya Sharma',
      'genres': ['Romance', 'Drama'],
      'city': 'Mumbai',
    },
    {
      'name': 'Rohit Verma',
      'genres': ['Science Fiction', 'Thriller'],
      'city': 'Delhi',
    },
    {
      'name': 'Kavya Nair',
      'genres': ['Fantasy', 'Adventure'],
      'city': 'Bangalore',
    },
    {
      'name': 'Amit Joshi',
      'genres': ['Non-Fiction', 'History'],
      'city': 'Pune',
    },
    {
      'name': 'Pooja Patel',
      'genres': ['Mystery', 'Crime'],
      'city': 'Ahmedabad',
    },
  ];

  final Map<String, bool> _requestStatus = {}; // Track request status for each author

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Find Authors')),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Menu')),
            ListTile(
              title: const Text('BiblioSync'),
              onTap: () {
                // Navigate to Manage Network
                Navigator.pushNamed(context, '/manageNetwork');
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
      body: ListView.builder(
        itemCount: _authors.length,
        itemBuilder: (context, index) {
          final author = _authors[index];
          bool isRequestSent = _requestStatus[author['name']] ?? false;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(author['name']),
              subtitle: Text('Genres: ${author['genres'].join(', ')}'),
              trailing: ElevatedButton(
                onPressed: isRequestSent
                    ? null // Disable if request is already sent
                    : () {
                        setState(() {
                          _requestStatus[author['name']] = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Collaboration request sent to ${author['name']}'),
                        ));
                      },
                child: Text(isRequestSent ? 'Request Sent' : 'Send Request'),
              ),
            ),
          );
        },
      ),
    );
  }
}
