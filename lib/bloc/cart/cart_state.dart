/*
  👉 Nhiệm vụ của file này:

Nghĩ xem Giao diện (UI) cần những dữ liệu gì từ Giỏ hàng để hiển thị:

Danh sách các món đang có trong giỏ (items).
  
Một con số tổng để hiển thị lên Badge (totalCount).
  
Tổng số tiền tạm tính để hiển thị ở trang thanh toán (subtotal).

Kiểm tra giỏ hàng có rỗng không (isEmpty).

⚠️ Quy tắc quan trọng trong BLoC: Tính Bất Biến (Immutability)

  Trong setState(), bạn có thể sửa trực tiếp danh sách: cart.add(...)
   hay item.quantity++.

  Nhưng trong BLoC, dữ liệu State luôn là hằng số (const / bất biến). 
  Mỗi khi có thay đổi, BLoC sẽ sinh ra một State mới tinh để Equatable so sánh. 
  Đó là lý do chúng ta có hàm copyWith().
*/

import 'package:equatable/equatable.dart';
import 'package:my_first_app/models/food_item.dart';

/// Đại diện cho 1 món hàng nằm trong giỏ (Kèm số lượng mua)
class CartItem extends Equatable {
  final FoodItem food;
  final int quantity;
  const CartItem({required this.food, required this.quantity});

  // Hàm tạo bản sao mới khi cần đổi số lượng (Immutability)

  CartItem copyWith({int? quantity}) {
    return CartItem(food: food, quantity: quantity ?? this.quantity);
  }

  @override
  List<Object?> get props => [food.id, quantity];
}

// Trạng thái (State) chứa toàn bộ dữ liệu giỏ hàng
class CartState extends Equatable {
  final List<CartItem> items;
  const CartState({this.items = const []});

  // Tổng số lượng món ăn (dùng cho icon Badge ở thanh điều hướng)
  int get totalCount => items.fold(0, (sum, item) => sum + item.quantity);

  // Tổng tiền tạm tính của giỏ hàng
  double get subTotal =>
      items.fold(0.0, (sum, item) => sum + (item.food.price * item.quantity));

  // Kiểm tra giỏ hàng có rỗng không
  bool get isEmpty => items.isEmpty;
  @override
  List<Object?> get props => [items];
}
