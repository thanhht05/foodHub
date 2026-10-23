import 'package:flutter/material.dart';

/// Model đại diện cho danh mục món ăn (Burger, Pizza, Đồ uống...)
class CategoryItem {
  final String id;
  final String title;
  final IconData icon;

  const CategoryItem({
    required this.id,
    required this.title,
    required this.icon,
  });
}

