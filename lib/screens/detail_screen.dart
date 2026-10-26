import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/bloc/cart/cart_bloc.dart';
import 'package:my_first_app/bloc/cart/cart_event.dart';

import '../models/food_item.dart';
import '../widgets/custom_button.dart';

/// Màn hình Chi tiết Món Ăn (Áp dụng Stack, Positioned, StatefulWidget & setState)
class FoodDetailScreen extends StatefulWidget {
  final FoodItem food;
  final VoidCallback onToggleFavorite;
  final Function(FoodItem food, int quantity)? onAddToCart;

  const FoodDetailScreen({
    super.key,
    required this.food,
    required this.onToggleFavorite,
    this.onAddToCart,
  });

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int _quantity = 1;

  void _increaseQuantity() {
    setState(() => _quantity++);
  }

  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() => _quantity--);
    }
  }

  String _formatCurrency(double price) {
    final intPrice = price.toInt().toString();
    final formatted = intPrice.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
    return '$formatted đ';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final food = widget.food;
    final totalPrice = food.price * _quantity;

    return Scaffold(
      body: Stack(
        children: [
          // Nội dung có thể cuộn
          CustomScrollView(
            slivers: [
              // Header ảnh với nút Back và Thả tim
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    // Ảnh món ăn lớn
                    AspectRatio(
                      aspectRatio: 1.15,
                      child: Image.network(
                        food.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade300,
                            child: const Icon(
                              Icons.fastfood,
                              size: 60,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                    // Nút Back
                    Positioned(
                      top: 48,
                      left: 20,
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withValues(alpha: 0.9),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black87,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    // Nút Yêu thích
                    Positioned(
                      top: 48,
                      right: 20,
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withValues(alpha: 0.9),
                        child: IconButton(
                          icon: Icon(
                            food.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: food.isFavorite
                                ? Colors.redAccent
                                : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              widget.onToggleFavorite();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Nội dung chi tiết
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 110),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tên & Giá
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              food.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _formatCurrency(food.price),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Chỉ số: Đánh giá, Thời gian, Lượng Calo
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.grey.withValues(alpha: 0.12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildInfoBadge(
                              Icons.star,
                              '${food.rating}',
                              'Đánh giá',
                              Colors.amber,
                            ),
                            _buildVerticalDivider(),
                            _buildInfoBadge(
                              Icons.access_time,
                              food.deliveryTime,
                              'Giao hàng',
                              Colors.blue,
                            ),
                            _buildVerticalDivider(),
                            _buildInfoBadge(
                              Icons.local_fire_department,
                              '${food.calories} Kcal',
                              'Năng lượng',
                              Colors.orange,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Chọn số lượng
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Số lượng:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Colors.grey.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: _decreaseQuantity,
                                  icon: const Icon(Icons.remove, size: 18),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Text(
                                    '$_quantity',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: _increaseQuantity,
                                  icon: const Icon(Icons.add, size: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Mô tả món ăn
                      const Text(
                        'Mô tả món ăn',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        food.description,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Thanh cố định ở đáy: Hiển thị tổng tiền và nút Thêm vào giỏ hàng
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tổng thanh toán:',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          _formatCurrency(totalPrice),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomButton(
                        text: 'Thêm vào giỏ',
                        icon: Icons.shopping_bag_outlined,
                        onPressed: () {
                          // 👈 Bắn Event AddToCartEvent vào CartBloc:
                          context.read<CartBloc>().add(
                            AddToCartEvent(food: food, quantity: _quantity),
                          );
                          widget.onAddToCart?.call(food, _quantity);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green.shade700,
                              content: Text(
                                'Đã thêm $_quantity x "${food.name}" vào giỏ!',
                              ),
                              action: SnackBarAction(
                                label: 'Đóng',
                                textColor: Colors.white,
                                onPressed: () {},
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBadge(
    IconData icon,
    String value,
    String label,
    Color iconColor,
  ) {
    return Column(
      children: [
        Icon(icon, size: 20, color: iconColor),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 30,
      color: Colors.grey.withValues(alpha: 0.2),
    );
  }
}
