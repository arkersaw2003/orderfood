import 'package:flutter/material.dart';
import 'package:orderapp/bottomNAV.dart';
import 'package:orderapp/widget/widget_support.dart';
import 'home.dart'; // Import the home.dart file

class Details extends StatefulWidget {
  const Details({super.key, required Map<String, dynamic> items});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a = 1;
  String selectedCrust = "Dày"; // Mặc định chọn đế dày
  String selectedSize = "Nhỏ 6\"";
  TextEditingController noteController = TextEditingController();

  // Danh sách lựa chọn đế theo size
  final Map<String, List<String>> crustOptions = {
    "Nhỏ 6\"": ["Dày"],
    "Vừa 9\"": ["Dày", "Mỏng", "Viền phô mai", "Viền giăm bông phô mai","Viền phô mai xúc xích"],
    "Lớn 12\"": ["Dày", "Mỏng", "Viền phô mai", "Viền giăm bông phô mai", "Viền phô mai xúc xích"],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigate to the Home screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BottomNAV()),
                  );
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                ),
              ),
              Image.asset(
                "images/pizza1.png",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 25.0),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pizza Hải Sản Pesto Xanh",
                        style: Appwidget.boldtextfieldstyle(),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          "Kích thước ${selectedSize} - Đế ${selectedCrust}",
                          style: Appwidget.greenboldtextfieldstyle(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      if (a > 1) {
                        a--;
                        setState(() {});
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 14, 103, 17),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  Text(a.toString(), style: Appwidget.boldtextfieldstyle()),
                  const SizedBox(width: 15.0),
                  GestureDetector(
                    onTap: () {
                      a++;
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 14, 103, 17),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Text(
                "Tôm, thanh cua, mực và bông cải xanh tươi ngon trên nền sốt Pesto Xanh",
                style: Appwidget.Lighttextfieldstyle(),
              ),
              const SizedBox(height: 20.0),
              
              // Phần Kích thước
              Text("KÍCH THƯỚC", style: Appwidget.boldtextfieldstyle()),
              const SizedBox(height: 10.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildSizeOption("Nhỏ 6\"", "", isSelected: selectedSize == "Nhỏ 6\""),
                    const SizedBox(width: 10),
                    _buildSizeOption("Vừa 9\"", "+80.000đ", isSelected: selectedSize == "Vừa 9\""),
                    const SizedBox(width: 10),
                    _buildSizeOption("Lớn 12\"", "+190.000đ", isSelected: selectedSize == "Lớn 12\""),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              
              // Phần Chọn đế
              Text("ĐẾ", style: Appwidget.boldtextfieldstyle()),
              const SizedBox(height: 10.0),
              // Hiển thị các lựa chọn đế theo size được chọn
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: crustOptions[selectedSize]!.map((crust) {
                  return ChoiceChip(
                    label: Text(crust),
                    selected: selectedCrust == crust,
                    onSelected: (selected) {
                      setState(() {
                        selectedCrust = crust;
                      });
                    },
                    selectedColor: const Color.fromARGB(255, 14, 103, 17),
                    labelStyle: TextStyle(
                      color: selectedCrust == crust ? Colors.white : Colors.black,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20.0),
              
              // Phần Ghi chú
              Text("GHI CHÚ", style: Appwidget.boldtextfieldstyle()),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: noteController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Nhập ghi chú của bạn tại đây",
                  ),
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 30.0),
              
              // Nút Thêm vào giỏ hàng
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      _addToCart();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 14, 103, 17),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          "THÊM VÀO GIỎ HÀNG",
                          style: Appwidget.boldtextfieldstyle().copyWith(
                              color: Colors.white,
                              fontSize: 16.0),
                        ),
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

  Widget _buildSizeOption(String size, String price, {required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = size;
          // Reset lựa chọn đế khi thay đổi size
          selectedCrust = crustOptions[size]!.first;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color.fromARGB(255, 14, 103, 17) : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Text(size, style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            )),
            Text(price, style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            )),
          ],
        ),
      ),
    );
  }

  void _addToCart() {
    final orderDetails = {
      'name': 'Pizza Hải Sản Pesto Xanh',
      'size': selectedSize,
      'crust': selectedCrust,
      'quantity': a,
      'note': noteController.text,
    };
    
    print('Đã thêm vào giỏ hàng: $orderDetails');
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã thêm vào giỏ hàng'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
