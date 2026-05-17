import 'package:flutter/material.dart';

Widget buildCreateIcon() {
  return Container(
    width: 62,
    height: 62,
    decoration: BoxDecoration(
      color: const Color(0xFF1A3A2A),
      borderRadius: BorderRadius.circular(14),
    ),
    child: const Icon(
      Icons.group_add_outlined,
      color: Color(0xFF2ECC71),
      size: 30,
    ),
  );
}