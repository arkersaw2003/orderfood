import 'package:flutter/material.dart';
import 'package:orderapp/admin/home_admin.dart';
import 'package:orderapp/bottomNAV.dart';
import 'package:orderapp/home.dart';
import 'package:orderapp/signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();

  // Constants
  static const Color primaryColor = Color.fromARGB(255, 3, 146, 48);
  static const double defaultPadding = 20.0;
  static const double defaultMargin = 10.0;
  static const double defaultRadius = 10.0;
  static const double defaultElevation = 5.0;
  static const double defaultFontSize = 16.0;
  static const double defaultButtonHeight = 50.0;
  static const double defaultSpacing = 8.0;
  static const double defaultTextFormFieldHeight = 14.0;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Simulate login (replace with your actual login logic)
  Future<void> _login() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() => _isLoading = true);

  // Simulate a login delay
  await Future.delayed(const Duration(seconds: 2));

  // Check for admin credentials
  if (_usernameController.text == "admin@gmail.com" && _passwordController.text == "123") {
    // Admin login - chuyển đến trang admin
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeAdmin()),
    );
  } 
  // Check for normal user credentials
  else if (_usernameController.text == "tranquanghuy465@gmail.com" && _passwordController.text == "123") {
    // Normal user login - chuyển đến BottomNAV
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BottomNAV()),
    );
  } else {
    // Failed login
    _showErrorDialog("Tên đăng nhập hoặc mật khẩu không đúng.");
  }

  setState(() => _isLoading = false);
}

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Lỗi"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.grey[500],
        fontSize: defaultTextFormFieldHeight,
      ),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: defaultPadding / 2,
        vertical: defaultPadding / 1.5,
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: primaryColor,
      ),
      suffixIcon: suffixIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: Stack(
            children: [
              // Background Gradient
              Container(
                width: screenWidth,
                height: screenHeight / 2.5,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryColor,
                      primaryColor,
                    ],
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    "images/logo1.png",
                    width: screenWidth / 1.5,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // White Container with Rounded Corners
              Positioned(
                top: screenHeight / 3,
                child: Container(
                  height: screenHeight / 1.5,
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(defaultPadding * 2),
                      topRight: Radius.circular(defaultPadding * 2),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: defaultPadding * 3),
                          Text(
                            "Tên đăng nhập",
                            style: TextStyle(
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: defaultSpacing),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(defaultRadius),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: defaultElevation,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: _usernameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập tên đăng nhập';
                                }
                                if (!value.contains('@')) {
                                  return 'Vui lòng nhập đúng định dạng email';
                                }
                                return null;
                              },
                              decoration: _buildInputDecoration(
                                hintText: "Nhập Email",
                                prefixIcon: Icons.email,
                              ),
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          Text(
                            "Mật khẩu",
                            style: TextStyle(
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: defaultSpacing),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(defaultRadius),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: defaultElevation,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập mật khẩu';
                                }
                                return null;
                              },
                              decoration: _buildInputDecoration(
                                hintText: "Nhập mật khẩu",
                                prefixIcon: Icons.lock,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                    color: Colors.grey[500],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: defaultMargin),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // Xử lý quên mật khẩu
                              },
                              child: const Text(
                                "Quên mật khẩu?",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          SizedBox(
                            width: double.infinity,
                            height: defaultButtonHeight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(defaultRadius),
                                ),
                                elevation: defaultElevation,
                              ),
                              onPressed: _isLoading ? null : _login,
                              child: _isLoading
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : const Text(
                                "ĐĂNG NHẬP",
                                style: TextStyle(
                                  fontSize: defaultFontSize + 2,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Chưa có tài khoản? ",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const SignUp()),
                                  );
                                },
                                child: const Text(
                                  "Đăng ký ngay",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
