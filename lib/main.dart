import 'package:flutter/material.dart';
import 'login.dart';
import 'info.dart';
import 'agenda.dart';
import 'galeri.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '4 Gallery App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF121212),  // Dark background color
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
          primarySwatch: Colors.blueGrey,
        ).copyWith(
          secondary: const Color(0xFF1E88E5),  // Bright blue for accents
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),  // Dark background
        tabBarTheme: const TabBarTheme(
          labelColor: Color(0xFF1E88E5),  // Bright blue for selected tab
          unselectedLabelColor: Color(0xFFBBE1FA),  // Light blue for unselected tabs
          indicatorColor: Color(0xFF1E88E5),  // Bright blue indicator
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Center(
          child: Text(
            '4 Gallery App',
            style: TextStyle(color: Color(0xFF1E88E5)),  // Light blue text color
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF1E88E5)),  // Bright blue icon color
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        backgroundColor: const Color(0xFF121212),  // Dark background color
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF1E88E5),  // Bright blue background color for drawer header
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Color(0xFFBBE1FA)),  // Light blue text color
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFF1E88E5)),  // Bright blue icon color
              title: const Text('Logout', style: TextStyle(color: Color(0xFFBBE1FA))),  // Light blue text color
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: <Widget>[
            TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: 'Home',
                  iconMargin: const EdgeInsets.only(bottom: 0),  // Remove space below icon
                ),
                Tab(
                  icon: Icon(Icons.info),
                  text: 'Info',
                ),
                Tab(
                  icon: Icon(Icons.photo_library),
                  text: 'Gallery',
                ),
                Tab(
                  icon: Icon(Icons.calendar_today),
                  text: 'Agenda',
                ),
              ],
              labelColor: const Color(0xFF1E88E5),  // Bright blue for selected tab
              unselectedLabelColor: const Color(0xFFBBE1FA),  // Light blue for unselected tabs
              indicator: BoxDecoration(
                color: Colors.transparent,  // Remove underline
              ),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.zero,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    color: const Color(0xFF121212),  // Dark background color
                    child: const HomeTab(),
                  ),
                  Container(
                    color: const Color(0xFF121212),  // Dark background color
                    child: const InfoTab(),
                  ),
                  Container(
                    color: const Color(0xFF121212),  // Dark background color
                    child: const GalleryTab(),
                  ),
                  Container(
                    color: const Color(0xFF121212),  // Dark background color
                    child: const AgendaTab(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Welcome to Home Tab',
        style: TextStyle(fontSize: 18, color: Color(0xFFBBE1FA)),  // Light blue text color
      ),
    );
  }
}
