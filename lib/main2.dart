import 'package:flutter/material.dart';
import 'buttons/buttons.dart';
import 'misc/rating.dart';
import 'loaders/loaders.dart';
import 'misc/graph.dart';
import 'screens/login_screen/login_screen.dart';
import 'screens/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Template',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MobileTemplate(),
    );
  }
}

class Item {
  final int id;
  final String title1;
  final String title2;
  final String description1;
  final String description2;
  final String category;

  Item({
    required this.id,
    required this.title1,
    required this.title2,
    required this.description1,
    required this.description2,
    required this.category,
  });
}

class MobileTemplate extends StatefulWidget {
  const MobileTemplate({Key? key}) : super(key: key);

  @override
  State<MobileTemplate> createState() => _MobileTemplateState();
}

class _MobileTemplateState extends State<MobileTemplate>
    with SingleTickerProviderStateMixin {
  late AnimationController _menuController;
  bool _isMenuOpen = false;
  String? selectedCategory;

  final List<Item> items = [
    Item(
      id: 1,
      title1: 'Splash Screen',
      title2: 'Login Screen',
      description1: 'Initial loading screen with app branding',
      description2: 'User authentication interface',
      category: 'Authentication',
    ),
    Item(
      id: 2,
      title1: 'Sign-Up Screen',
      title2: 'Home Screen',
      description1: 'New user registration interface',
      description2: 'Main app dashboard view',
      category: 'Authentication',
    ),
    Item(
      id: 3,
      title1: 'Buttons',
      title2: 'Loaders',
      description1: 'Various button styles and designs',
      description2: 'Loading animations and indicators',
      category: 'Components',
    ),
    Item(
      id: 4,
      title1: 'Misc',
      title2: 'Experiment',
      description1: 'Miscellaneous UI components',
      description2: 'Interactive graph experiment',
      category: 'Experimental',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  void toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _menuController.forward();
      } else {
        _menuController.reverse();
      }
    });
  }

  String searchTerm = '';
  String filterTerm = '';

  List<Item> get filteredItems {
    return items.where((item) {
      final matchesSearch = item.title1
              .toLowerCase()
              .contains(searchTerm.toLowerCase()) ||
          item.title2.toLowerCase().contains(searchTerm.toLowerCase()) ||
          item.description1.toLowerCase().contains(searchTerm.toLowerCase()) ||
          item.description2.toLowerCase().contains(searchTerm.toLowerCase());

      final matchesFilter = filterTerm.isEmpty ||
          item.title1.toLowerCase().contains(filterTerm.toLowerCase()) ||
          item.title2.toLowerCase().contains(filterTerm.toLowerCase());

      final matchesCategory =
          selectedCategory == null || item.category == selectedCategory;

      return matchesSearch && matchesFilter && matchesCategory;
    }).toList();
  }

  List<String> get categories {
    return items.map((item) => item.category).toSet().toList();
  }

  void navigateToScreen(BuildContext context, String screenName) {
    switch (screenName) {
      case 'Buttons':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ButtonExample()),
        );
        break;
      case 'Loaders':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoadersExample()),
        );
        break;
      case 'Misc':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MiscShowcase()),
        );
        break;
      case 'Experiment':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Graph()),
        );
        break;
      case 'Login Screen':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreenShowcase()),
        );
        break;
      case 'Home Screen':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      default:
        final path = screenName.replaceAll(' ', '').replaceAll('/', '');
        final routePath =
            'lib/screens/${path.toLowerCase()}/${path.toLowerCase()}.dart';
        print('Navigating to: $routePath');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Would navigate to: $routePath'),
            duration: const Duration(seconds: 2),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[900]),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
        title: Text(
          'Flutter UI Screens',
          style: TextStyle(
            color: Colors.grey[900],
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _menuController,
              color: Colors.grey[900],
            ),
            onSelected: (String category) {
              setState(() {
                selectedCategory = category == 'All' ? null : category;
              });
              toggleMenu();
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'All',
                child: Text('All Categories'),
              ),
              ...categories.map((category) => PopupMenuItem<String>(
                    value: category,
                    child: Text(category),
                  )),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) => setState(() => searchTerm = value),
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      onChanged: (value) => setState(() => filterTerm = value),
                      decoration: InputDecoration(
                        hintText: 'Filter...',
                        prefixIcon:
                            Icon(Icons.filter_list, color: Colors.grey[400]),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (selectedCategory != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Text(
                        'Category: $selectedCategory',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[900],
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectedCategory = null;
                          });
                        },
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: filteredItems.length * 2,
                  itemBuilder: (context, index) {
                    final itemIndex = index ~/ 2;
                    final item = filteredItems[itemIndex];
                    final isTitle1 = index % 2 == 0;

                    return InkWell(
                      onTap: () {
                        navigateToScreen(
                            context, isTitle1 ? item.title1 : item.title2);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isTitle1 ? item.title1 : item.title2,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[900],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              isTitle1 ? item.description1 : item.description2,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
