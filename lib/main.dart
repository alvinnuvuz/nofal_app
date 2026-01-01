import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/counter_provider.dart';
import 'pages/home_page.dart';
import 'pages/explore_page.dart';
import 'pages/profile_page.dart';
import 'pages/page_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider()),
      ],
      child: MaterialApp(
        title: 'My Beautiful App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        home: const MainNavigationScreen(),
      ),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  final PageState _pageState = PageState();

  void _updateCategory(String category) {
    setState(() {
      _pageState.updateCategory(category);
    });
  }

  void _updateItemCount(int count) {
    setState(() {
      _pageState.updateItemCount(count);
    });
  }

  void _updatePreferences(Map<String, dynamic> prefs) {
    setState(() {
      _pageState.updatePreferences(prefs);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = <Widget>[
      HomePage(
        pageState: _pageState,
        onCategorySelected: _updateCategory,
      ),
      ExplorePage(
        pageState: _pageState,
        updateItemCount: _updateItemCount,
      ),
      ProfilePage(
        pageState: _pageState,
        updatePreferences: _updatePreferences,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}