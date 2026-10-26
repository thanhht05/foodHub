/*
  Nhiệm vụ của file này:
  Nghĩ xem người dùng có thể làm những hành động gì với giỏ hàng:

  Thêm món ăn vào giỏ (AddToCartEvent).
  Tăng/giảm số lượng của một món (UpdateQuantityEvent).
  Xoá một món khỏi giỏ (RemoveFromCartEvent).
  Xoá sạch toàn bộ giỏ hàng (ClearCartEvent).
*/

import 'package:equatable/equatable.dart';
import 'package:my_first_app/models/food_item.dart';

/// Lớp cơ sở (Base Class) cho tất cả các sự kiện của giỏ hàng

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

/// 1. Sự kiện: Thêm món ăn vào giỏ hàng
class AddToCartEvent extends CartEvent {
  final FoodItem food;
  final int quantity;

  const AddToCartEvent({required this.food, this.quantity = 1});

  @override
  List<Object?> get props => [food.id, quantity];
}

/// 2. Sự kiện: Tăng hoặc giảm số lượng 1 món
/// delta = 1 (tăng), delta = -1 (giảm)
///
class UpdateQuantityEvent extends CartEvent {
  final String foodId;
  final int delta;
  const UpdateQuantityEvent({required this.foodId, required this.delta});
  @override
  List<Object?> get props => [foodId, delta];
}

/// 3. Sự kiện: Xoá hẳn một món ra khỏi giỏ
class RemoveFromCartEvent extends CartEvent {
  final String foodId;
  const RemoveFromCartEvent({required this.foodId});
  @override
  List<Object?> get props => [foodId];
}

/// 4. Sự kiện: Xoá sạch toàn bộ giỏ hàng
class ClearCartEvent extends CartEvent {
  const ClearCartEvent();
}
