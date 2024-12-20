import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'login_screen_1.dart';
import 'login_screen_2.dart';
import 'login_screen_3.dart';
import 'login_screen_4.dart';
import 'login_screen_5.dart';
import 'login_screen_6.dart';

class LoginScreenShowcase extends StatelessWidget {
  void _launchGitHub() async {
    const url = 'https://github.com/The-Young-Programer/FlutterScreens';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen Examples'),
        actions: [
          ElevatedButton.icon(
            onPressed: _launchGitHub,
            icon: Icon(Icons.code),
            label: Text('View Code'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildScreenCard(
            context,
            'Login Screen 1',
            'Classic design with curved header and social login',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LoginScreen1(
                  primaryColor: Colors.blue,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ),
          _buildScreenCard(
            context,
            'Login Screen 2',
            'Dark theme with gradient background and circular avatar',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LoginScreen2(),
              ),
            ),
          ),
          _buildScreenCard(
            context,
            'Login Screen 3',
            'Swipeable pages with sign-in and sign-up options',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LoginScreen3(),
              ),
            ),
          ),
          _buildScreenCard(
            context,
            'Login Screen 4',
            'Modern design with custom color scheme',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LoginScreen4(),
              ),
            ),
          ),
          _buildScreenCard(
            context,
            'Login Screen 5',
            'Stylish design with avatar and sliding panel',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LoginScreen5(
                  avatarImage: 'assets/images/avatar.png',
                  onLoginClick: () {},
                  googleSignIn: () {},
                  navigatePage: () {},
                ),
              ),
            ),
          ),
          _buildScreenCard(
            context,
            'Login Screen 6',
            'Minimalist design with background image',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LoginScreen6(
                  onLoginClick: () {},
                  navigatePage: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreenCard(
    BuildContext context,
    String title,
    String description,
    VoidCallback onTap,
  ) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onTap,
                    child: Text('VIEW DEMO'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
