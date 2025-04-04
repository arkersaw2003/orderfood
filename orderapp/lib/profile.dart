import 'package:flutter/material.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Constants for better readability and maintainability
  static const double _profileImageSize = 120.0;
  static const double _profileImageMarginTop = 6.5;
  static const double _profileHeaderHeightRatio = 4.3;
  static const double _profileHeaderBottomRadius = 105.0;
  static const double _defaultPadding = 20.0;
  static const double _defaultSpacing = 20.0;
  static const double _defaultRadius = 10.0;
  static const double _defaultElevation = 2.0;
  static const double _defaultFontSize = 16.0;
  static const double _defaultIconSize = 24.0;
  static const Color _primaryColor = Color.fromARGB(255, 3, 146, 48);

  // Example user data (replace with actual data from your app)
  String _username = "user";
  String _email = "user@gmail.com";

  // Logout function
  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  // Show confirmation dialog
  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to close
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Xác nhận đăng xuất'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bạn có chắc chắn muốn đăng xuất?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Đăng xuất'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
                _logout(context); // Perform logout
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Stack(
              children: [
                // Green background container
                Container(
                  padding: const EdgeInsets.only(
                      top: 45, left: _defaultPadding, right: _defaultPadding),
                  height: screenHeight / _profileHeaderHeightRatio,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: _primaryColor,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          screenWidth, _profileHeaderBottomRadius),
                    ),
                  ),
                ),
                // Profile image
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: screenHeight / _profileImageMarginTop),
                    child: Material(
                      elevation: 10.0,
                      borderRadius: BorderRadius.circular(_profileImageSize / 2),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(_profileImageSize / 2),
                        child: Image.asset(
                          "images/user.png",
                          height: _profileImageSize,
                          width: _profileImageSize,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                // Username display
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "@$_username",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: _defaultSpacing),
            // User Info Card
            _buildInfoCard(
              icon: Icons.person,
              title: "Tên người dùng",
              value: "@$_username",
            ),
            const SizedBox(height: _defaultSpacing),
            // Email Info Card
            _buildInfoCard(
              icon: Icons.email,
              title: "Email",
              value: _email,
            ),
            const SizedBox(height: _defaultSpacing),
            // Terms of Use Card
            _buildInfoCard(
              icon: Icons.description,
              title: "Điều khoản người dùng",
              value: "",
            ),
            const SizedBox(height: _defaultSpacing),
            // Logout Card
            GestureDetector(
              onTap: () => _showLogoutConfirmationDialog(context),
              child: _buildInfoCard(
                icon: Icons.logout,
                title: "Đăng xuất",
                value: "",
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build info cards
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: _defaultPadding),
      child: Material(
        borderRadius: BorderRadius.circular(_defaultRadius),
        elevation: _defaultElevation,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(_defaultRadius),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.black,
                size: _defaultIconSize,
              ),
              const SizedBox(width: _defaultSpacing),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: _defaultFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (value.isNotEmpty)
                    Text(
                      value,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: _defaultFontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
