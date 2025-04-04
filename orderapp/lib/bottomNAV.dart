import 'package:flutter/material.dart';
import 'package:orderapp/home.dart';    // Giữ lại
import 'package:orderapp/order.dart';   // Giữ lại
import 'package:orderapp/profile.dart'; // Giữ lại
import 'package:orderapp/wallet.dart';  // Giữ lại
// Xóa tất cả import từ 'pages/...'

class BottomNAV extends StatefulWidget {
  const BottomNAV({super.key});

  @override
  State<BottomNAV> createState() => _BottomNAVState();
}

class _BottomNAVState extends State<BottomNAV> {
  int currentTabIndex = 0;
  late List<Widget> pages;
  late Widget currentPage;
  late Home homePage;
  late Profile profile;
  late Order order;
  late Wallet wallet;

  @override
  void initState() {
    homePage = const Home();
    profile = const Profile();
    order = const Order();
    wallet = const Wallet();
    pages = [homePage, order, wallet, profile];
    currentPage = homePage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabIndex,
        onTap: (index) {
          setState(() {
            currentTabIndex = index;
            currentPage = pages[index];
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 14, 103, 17),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Đơn đặt hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet_outlined),
            label: 'Ví',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Hồ sơ',
          ),
        ],
      ),
    );
  }
}