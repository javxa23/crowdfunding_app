import 'package:flutter/material.dart';
import 'dart:math' as math;

class CreditCard extends StatelessWidget {
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;
  final Color cardColor;
  final String cardType;

  const CreditCard({
    Key? key,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
    this.cardColor = const Color(0xFF1E1E99),
    this.cardType = 'VISA',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 340,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Card chip
                Container(
                  height: 30,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: CustomPaint(painter: ChipPainter()),
                  ),
                ),
                // Card type logo
                Text(
                  cardType,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // Card number
            Text(
              _formatCardNumber(cardNumber),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Card holder details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CARD HOLDER',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      cardHolderName.toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
                // Expiry date
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'EXPIRES',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      expiryDate,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatCardNumber(String number) {
    String cleanNumber = number.replaceAll(RegExp(r'\D'), '');
    List<String> chunks = [];

    for (int i = 0; i < cleanNumber.length; i += 4) {
      int end = (i + 4 < cleanNumber.length) ? i + 4 : cleanNumber.length;
      chunks.add(cleanNumber.substring(i, end));
    }

    return chunks.join(' ');
  }
}

// Chip design painter
class ChipPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..color = Colors.amber.shade800
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

    // Draw chip lines
    for (int i = 1; i < 4; i++) {
      double y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    for (int i = 1; i < 3; i++) {
      double x = size.width * i / 3;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Example of how to use the credit card widget
class CreditCardExample extends StatelessWidget {
  const CreditCardExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Credit Card Demo')),
      body: Center(
        child: CreditCard(
          cardNumber: '1234567890123456',
          cardHolderName: 'John Doe',
          expiryDate: '12/25',
          cvv: '123',
          cardColor: const Color(0xFF1E1E99),
          cardType: 'VISA',
        ),
      ),
    );
  }
}
