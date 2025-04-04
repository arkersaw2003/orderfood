import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Thêm cho chức năng copy
import 'package:orderapp/widget/widget_support.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final List<String> amounts = [
    '100.000',
    '200.000', 
    '500.000',
    '1.000.000',
    '1.500.000',
    '2.000.000',
  ];

  final TextEditingController _amountController = TextEditingController();
  String? _selectedAmount;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Phần header (giữ nguyên)
              Material(
                elevation: 2.0,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Center(
                    child: Text(
                      "Ví của bạn",
                      style: Appwidget.Headlinetextfieldstyle(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              
              // Thông tin ví (giữ nguyên)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  border: Border.all(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7.0),
                        child: Image.asset(
                          "images/wallet.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ví của bạn", style: Appwidget.semiboldtextfieldstyle()),
                        Text("200.000 VND", style: Appwidget.boldtextfieldstyle()),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              
              // Tiêu đề nạp tiền (giữ nguyên)
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text("Nạp tiền", style: Appwidget.semiboldtextfieldstyle()),
              ),
              const SizedBox(height: 10.0),
              
              // Các lựa chọn nạp tiền (giữ nguyên)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: amounts.map((amount) => _buildAmountOption(amount)).toList(),
                ),
              ),
              const SizedBox(height: 20.0),
              
              // Nút nạp tiền (đã cập nhật)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      final amount = _selectedAmount ?? _amountController.text;
                      if (amount.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Vui lòng chọn hoặc nhập số tiền")),
                        );
                        return;
                      }
                      _showPaymentDialog(amount); // Gọi hiển thị popup mới
                    },
                    child: Text(
                      "NẠP TIỀN",
                      style: Appwidget.boldtextfieldstyle().copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  // Thêm hàm hiển thị popup thông tin chuyển khoản
  void _showPaymentDialog(String amount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("THÔNG TIN CHUYỂN KHOẢN"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Vui lòng chuyển khoản theo thông tin sau:"),
                const SizedBox(height: 20),
                _buildBankInfoRow("Ngân hàng", "Vietcombank"),
                _buildBankInfoRow("Số tài khoản", "1234567890", showCopy: true),
                _buildBankInfoRow("Chủ tài khoản", "cong ty abc"),
                const SizedBox(height: 15),
                _buildBankInfoRow("Số tiền", "$amount VND", isAmount: true),
                const SizedBox(height: 20),
                const Text(
                  "Lưu ý: Vui lòng ghi nội dung chuyển khoản theo cú pháp:\nNAPVI_[SỐ_ĐIỆN_THOẠI]",
                  style: TextStyle(fontSize: 16 , color: Colors.black),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("ĐÓNG"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _processPayment(amount);
              },
              child: const Text("ĐÃ CHUYỂN KHOẢN"),
            ),
          ],
        );
      },
    );
  }

  // Thêm hàm xây dựng dòng thông tin ngân hàng
  Widget _buildBankInfoRow(String label, String value, {bool isAmount = false, bool showCopy = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: Appwidget.semiboldtextfieldstyle(),
            ),
          ),
          const Text(": "),
          Expanded(
            child: Text(
              value,
              style: isAmount
                  ? TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    )
                  : Appwidget.boldtextfieldstyle(),
            ),
          ),
          if (showCopy)
            IconButton(
              icon: const Icon(Icons.copy, size: 20),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Đã sao chép số tài khoản"),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  // Giữ nguyên hàm _buildAmountOption
  Widget _buildAmountOption(String amount) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAmount = amount;
          _amountController.clear();
        });
      },
      child: SizedBox(
        width: 120,
        height: 45,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: _selectedAmount == amount ? Colors.green : Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
          ),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Appwidget.Headlinetextfieldstyle(),
              children: [
                TextSpan(
                  text: amount,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: " VND",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Giữ nguyên hàm xử lý thanh toán
  void _processPayment(String amount) {
    print("Đang nạp tiền: $amount VND");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Đã ghi nhận yêu cầu nạp $amount VND. Vui lòng chờ xử lý."),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}