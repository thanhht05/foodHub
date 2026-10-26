/*

Nhiệm vụ của file này:

Nó giống như người quản lý nhà kho:

Lắng nghe các Event người dùng gửi đến (Thêm, Xoá, Đổi số lượng, Xoá hết).
Tính toán logic tương ứng.
emit (phát ra) một State mới chứa danh sách giỏ hàng đã được cập nhật.

🔑 Từ khoá quan trọng nhất: emit()
emit() trong BLoC giống như setState() trong StatefulWidget. 
Mỗi khi bạn gọi emit(CartState(...)),
 BLoC sẽ phát tín hiệu cho toàn bộ ứng dụng biết dữ liệu 
 vừa thay đổi và yêu cầu giao diện cập nhật.

*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/bloc/cart/cart_event.dart';
import 'package:my_first_app/bloc/cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  // Trạng thái khởi tạo ban đầu: Giỏ hàng rỗng (const CartState())
  CartBloc() : super(const CartState()) {
    // Đăng ký các hàm xử lý tương ứng với từng Event:
    on<AddToCartEvent>(_onAddToCart);
    on<UpdateQuantityEvent>(_onUpdateQuantity);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<ClearCartEvent>(_onClearCart);
  }

  // 1. Xử lý khi có sự kiện Thêm món vào giỏ
  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) {
    // Tạo bản sao của danh sách hiện tại
    final List<CartItem> updatedItems = List.from(state.items);

    // Kiểm tra xem món ăn này đã có trong giỏ chưa
    final existingIndex = updatedItems.indexWhere(
      (item) => item.food.id == event.food.id,
    );

    if (existingIndex >= 0) {
      // Nếu đã có: Dùng copyWith để cộng dồn số lượng!
      final currentItem = updatedItems[existingIndex];
      updatedItems[existingIndex] = currentItem.copyWith(
        quantity: currentItem.quantity + event.quantity,
      );
    } else {
      updatedItems.add(CartItem(food: event.food, quantity: event.quantity));
    }

    // Phát ra State mới với danh sách món đã cập nhật
    emit(CartState(items: updatedItems));
  }

  // 2. Xử lý khi tăng / giảm số lượng (+1 hoặc -1)
  void _onUpdateQuantity(UpdateQuantityEvent event, Emitter<CartState> emit) {
    final List<CartItem> updatedItems = List.from(state.items);

    final index = updatedItems.indexWhere(
      (item) => item.food.id == event.foodId,
    );

    if (index >= 0) {
      final currentItem = updatedItems[index];
      final newQuantity = currentItem.quantity + event.delta;

      if (newQuantity > 0) {
        // Nếu số lượng > 0 thì cập nhật số lượng mới
        updatedItems[index] = currentItem.copyWith(quantity: newQuantity);
      } else {
        // Nếu giảm về 0 thì tự động xoá món khỏi giỏ
        updatedItems.removeAt(index);
      }
    }
    emit(CartState(items: updatedItems));
  }

  // 3. Xử lý khi xoá hẳn một món
  void _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) {
    final updatedItems = state.items
        .where((item) => item.food.id != event.foodId)
        .toList();
    emit(CartState(items: updatedItems));
  }

  // 4. Xử lý khi bấm Xoá tất cả
  void _onClearCart(ClearCartEvent event, Emitter<CartState> emit) {
    // Phát ra giỏ hàng rỗng
    emit(const CartState(items: []));
  }
}
