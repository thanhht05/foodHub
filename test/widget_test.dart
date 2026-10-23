import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/main.dart';

void main() {
  testWidgets('FoodHub smoke test - Hiển thị màn hình đăng nhập', (WidgetTester tester) async {
    // Khởi chạy ứng dụng
    await tester.pumpWidget(const FoodHubApp());

    // Kiểm tra tiêu đề FoodHub xuất hiện
    expect(find.text('FoodHub'), findsOneWidget);
    expect(find.text('Đăng Nhập'), findsOneWidget);
  });
}
