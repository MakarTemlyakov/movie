import 'package:flutter/material.dart';

class RateInfo extends StatelessWidget {
  final String rate;
  const RateInfo({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      children: [
        Icon(
          Icons.star_border,
          size: 16,
          color: Color.fromRGBO(255, 135, 0, 1),
        ),
        Text(
          rate,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(255, 135, 0, 1),
          ),
        ),
      ],
    );
  }
}
