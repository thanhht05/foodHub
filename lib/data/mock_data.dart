import 'package:flutter/material.dart';
import '../models/category_item.dart';
import '../models/food_item.dart';

/// Danh sách danh mục món ăn mẫu
final List<CategoryItem> mockCategories = [
  const CategoryItem(id: 'all', title: 'Tất cả', icon: Icons.restaurant_menu),
  const CategoryItem(id: 'burger', title: 'Burger', icon: Icons.lunch_dining),
  const CategoryItem(id: 'pizza', title: 'Pizza', icon: Icons.local_pizza),
  const CategoryItem(id: 'drink', title: 'Đồ uống', icon: Icons.local_cafe),
  const CategoryItem(id: 'dessert', title: 'Tráng miệng', icon: Icons.icecream),
];

/// Danh sách món ăn mẫu
final List<FoodItem> mockFoods = [
  FoodItem(
    id: 'f1',
    name: 'Bò Phô Mai Burger',
    categoryId: 'burger',
    description:
        'Bánh burger bò Úc thượng hạng nướng than hoa, kèm 2 lớp phô mai cheddar tan chảy, xà lách tươi giòn và sốt đặc biệt thơm lừng.',
    price: 69000,
    rating: 4.8,
    reviewsCount: 142,
    imageUrl:
        'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600&auto=format&fit=crop&q=80',
    deliveryTime: '20-25 phút',
    calories: 520,
    isFavorite: true,
  ),
  FoodItem(
    id: 'f2',
    name: 'Pizza Hải Sản Pesto',
    categoryId: 'pizza',
    description:
        'Đế bánh giòn rụm phủ sốt húng tây Pesto xanh mát, tôm tươi sú, mực giòn cùng lớp phô mai Mozzarella kéo sợi béo ngậy.',
    price: 149000,
    rating: 4.9,
    reviewsCount: 230,
    imageUrl:
        'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=600&auto=format&fit=crop&q=80',
    deliveryTime: '30-35 phút',
    calories: 780,
    isFavorite: false,
  ),
  FoodItem(
    id: 'f3',
    name: 'Burger Gà Giòn Cay',
    categoryId: 'burger',
    description:
        'Thịt ức gà tẩm bột chiên giòn rụm bên ngoài mọng nước bên trong, hòa quyện với sốt ớt cay ngọt Hàn Quốc và dưa chuột muối.',
    price: 59000,
    rating: 4.6,
    reviewsCount: 88,
    imageUrl:
        'https://images.unsplash.com/photo-1625813506062-0aeb1d7a094b?w=600&auto=format&fit=crop&q=80',
    deliveryTime: '15-20 phút',
    calories: 460,
    isFavorite: false,
  ),
  FoodItem(
    id: 'f4',
    name: 'Pizza Phô Mai 4 Vị',
    categoryId: 'pizza',
    description:
        'Sự kết hợp hoàn hảo giữa 4 loại phô mai hảo hạng: Mozzarella, Gorgonzola thơm nồng, Parmesan đậm đà và Ricotta thanh nhẹ.',
    price: 139000,
    rating: 4.7,
    reviewsCount: 95,
    imageUrl:
        'https://images.unsplash.com/photo-1573821663912-569905455b1c?w=600&auto=format&fit=crop&q=80',
    deliveryTime: '25-30 phút',
    calories: 690,
    isFavorite: true,
  ),
  FoodItem(
    id: 'f5',
    name: 'Trà Sữa Trân Châu Đường Đen',
    categoryId: 'drink',
    description:
        'Trà sữa ô long thơm ngát kết hợp sữa tươi thanh trùng và trân châu đường đen nóng dẻo nấu thủ công.',
    price: 35000,
    rating: 4.9,
    reviewsCount: 310,
    imageUrl:
        'https://images.unsplash.com/photo-1558857563-b371033873b8?w=600&auto=format&fit=crop&q=80',
    deliveryTime: '10-15 phút',
    calories: 320,
    isFavorite: false,
  ),
  FoodItem(
    id: 'f6',
    name: 'Bánh Kem Dâu Tây Tươi',
    categoryId: 'dessert',
    description:
        'Cốt bánh bông lan mềm mịn như mây, phủ lớp kem whipping béo nhẹ và những lát dâu tây Đà Lạt tươi mọng.',
    price: 45000,
    rating: 4.8,
    reviewsCount: 77,
    imageUrl:
        'https://images.unsplash.com/photo-1565958011703-44f9829ba187?w=600&auto=format&fit=crop&q=80',
    deliveryTime: '15-20 phút',
    calories: 280,
    isFavorite: false,
  ),
];

/// Tài khoản mẫu dùng để kiểm tra đăng nhập (Mock Auth)
class MockUserAccount {
  final String email;
  final String fullName;
  final String password;

  const MockUserAccount({
    required this.email,
    required this.fullName,
    required this.password,
  });
}

final List<MockUserAccount> mockUserAccounts = [
  const MockUserAccount(
    email: 'demo@foodhub.com',
    fullName: 'Nguyễn Văn A',
    password: 'password123',
  ),
  const MockUserAccount(
    email: 'admin@foodhub.com',
    fullName: 'Trần Thị B',
    password: 'admin123',
  ),
];


