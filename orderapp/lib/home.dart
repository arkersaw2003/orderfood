import 'package:flutter/material.dart';
import 'package:orderapp/widget/widget_support.dart';
import 'details.dart'; // Import file details.dart

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedCategory = '';
  String userName = "Trần Huy"; // Replace with actual user name
  List<Map<String, dynamic>> cartItems = []; // List to store cart items

  final Map<String, List<Map<String, dynamic>>> menuItems = {
    'pizza': [
      {
        'name': 'Pizza Hải Sản Pesto Xanh',
        'price': '169.000đ',
        'image': 'images/pizza1.png',
        'description': 'Tôm, thanh cua, mực và bông cải xanh tươi ngon trên nền sốt Pesto Xanh'
      },
      {'name': 'Pizza Thịt Xông Khói', 'price': '149.000đ', 'image': 'images/pizza2.png'},
      {'name': 'Pizza 5 Loại Thịt Đặc Biệt Và Rau Củ', 'price': '149.000đ', 'image': 'images/pizza3.png'},
      {'name': 'Pizza phô mai', 'price': '139.000đ', 'image': 'images/pizza4.png'},
    ],
    'garan': [
      {'name': 'Gà Nướng BBQ (2 miếng)', 'price': '119.000đ', 'image': 'images/garan1.png'},
      {'name': 'Cánh gà nướng BBQ (6 miếng)', 'price': '149.000đ', 'image': 'images/garan2.jpeg'},
      {'name': 'Da Gà Rộp Rộp Xốt Hàn - Truyền Thống', 'price': '79.000đ', 'image': 'images/garan3.png'},
      {'name': 'Gà Giòn Xốt Hàn - Truyền Thống (2 miếng)', 'price': '119.000đ', 'image': 'images/garan4.png'},
      {'name': 'Gà Giòn Xốt Hàn - Cay (2 miếng)', 'price': '119.000đ', 'image': 'images/garan6.png'},
      {'name': 'Gà Giòn Xốt Tương Tỏi Hàn Quốc (5 miếng)', 'price': '249.000đ', 'image': 'images/garan5.png'},
    ],
    'salad': [
      {'name': 'Salad Đặc sắc', 'price': '89.000đ', 'image': 'images/salad1.png'},
      {'name': 'Salad Tôm Xốt Kem Chanh', 'price': '89.000đ', 'image': 'images/salad2.png'},
    ],
    'miy': [
      {'name': 'Mỳ Ý thịt bò bằm', 'price': '139.000đ', 'image': 'images/miy1.png'},
      {'name': 'Mỳ Ý Giăm Bông Và Nấm Sốt Kem', 'price': '119.000đ', 'image': 'images/miy2.png'},
    ],
    'drinks': [
      {'name': 'Pepsi', 'price': '17.000đ', 'image': 'images/drink1.png'},
      {'name': 'Miranda', 'price': '17.000đ', 'image': 'images/drink2.png'},
    ],
  };

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  // Loại bỏ phần thêm vào giỏ hàng
  void addToCart(Map<String, dynamic> item) {
    setState(() {
      cartItems.add(item);
    });
    // Loại bỏ thông báo snackbar
  }

  Widget buildFoodItem(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(items: item),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                item['image'],
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item['price'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Loại bỏ IconButton
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Xin chào $userName", style: Appwidget.boldtextfieldstyle()),
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 14, 103, 17),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.shopping_cart, color: Colors.white),
                  )
                ],
              ),
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bạn đã đói chưa", style: Appwidget.Headlinetextfieldstyle()),
                  const SizedBox(height: 5),
                  Text("Hãy đặt đồ ăn nhé", style: Appwidget.Lighttextfieldstyle()),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildCategoryButton('pizza', 'images/pizza.png'),
                        const SizedBox(width: 20),
                        _buildCategoryButton('garan', 'images/garan.png'),
                        const SizedBox(width: 20),
                        _buildCategoryButton('salad', 'images/salad.png'),
                        const SizedBox(width: 20),
                        _buildCategoryButton('miy', 'images/miy.png'),
                        const SizedBox(width: 20),
                        _buildCategoryButton('drinks', 'images/drinks.png'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (selectedCategory.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Danh sách món ăn",
                          style: Appwidget.boldtextfieldstyle(),
                        ),
                        const SizedBox(height: 15),
                        ...menuItems[selectedCategory]!.map((item) => buildFoodItem(item)).toList(),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String category, String imagePath) {
    bool isSelected = selectedCategory == category;

    return GestureDetector(
      onTap: () => selectCategory(category),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? const Color.fromARGB(255, 14, 103, 17) : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(10),
          child: Image.asset(
            imagePath,
            height: 40,
            width: 40,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}