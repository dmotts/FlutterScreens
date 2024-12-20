import 'package:flutter/material.dart';
import 'main2.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Screens',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/main2': (context) =>
            const MobileTemplate(), // Changed from Main2Screen to MobileTemplate
      },
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int stars = 0;
  int forks = 0;
  int issues = 0;

  @override
  void initState() {
    super.initState();
    fetchGitHubStats();
  }

  Future<void> fetchGitHubStats() async {
    final repo = 'The-Young-Programer/FlutterScreens';
    final response = await http.get(
      Uri.parse('https://api.github.com/repos/$repo'),
      headers: {'Accept': 'application/vnd.github.v3+json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        stars = data['stargazers_count'] ?? 0;
        forks = data['forks_count'] ?? 0;
        issues = data['open_issues_count'] ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Flutter Logo
                FlutterLogo(
                  size: 120,
                  style: FlutterLogoStyle.markOnly,
                ),
                const SizedBox(height: 30),
                Text(
                  'Flutter Screens',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'A collection of beautifully designed Flutter UI screens',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/main2');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        launchUrl(Uri.parse(
                            'https://github.com/The-Young-Programer/FlutterScreens'));
                      },
                      icon: const Icon(Icons.code),
                      label: const Text('Contribute'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // GitHub Stats Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildGithubStat(
                      icon: Icons.star_border,
                      label: 'Star',
                      count: stars,
                      onTap: () => launchUrl(Uri.parse(
                          'https://github.com/The-Young-Programer/FlutterScreens/stargazers')),
                    ),
                    const SizedBox(width: 16),
                    _buildGithubStat(
                      icon: Icons.call_split,
                      label: 'Fork',
                      count: forks,
                      onTap: () => launchUrl(Uri.parse(
                          'https://github.com/The-Young-Programer/FlutterScreens/fork')),
                    ),
                    const SizedBox(width: 16),
                    _buildGithubStat(
                      icon: Icons.bug_report_outlined,
                      label: 'Issues',
                      count: issues,
                      onTap: () => launchUrl(Uri.parse(
                          'https://github.com/The-Young-Programer/FlutterScreens/issues')),
                    ),
                  ],
                ),
                const SizedBox(height: 72),
                // Footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Created with '),
                    Icon(Icons.favorite, color: Colors.red, size: 16),
                    const Text(' by '),
                    InkWell(
                      onTap: () => launchUrl(
                          Uri.parse('https://github.com/The-Young-Programer')),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Nemonet TYP '),
                          const Icon(Icons.code, color: Colors.grey, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGithubStat({
    required IconData icon,
    required String label,
    required int count,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 4),
            Text('$label ($count)', style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
