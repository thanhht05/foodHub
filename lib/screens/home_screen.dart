import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/food_item.dart';
import '../widgets/category_chip.dart';
import '../widgets/food_card.dart';
import 'cart_screen.dart';
import 'detail_screen.dart';

/// Màn hình Trang Chủ (Home Screen)
class HomeScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final ValueNotifier<ThemeMode> themeNotifier;

  const HomeScreen({
    super.key,
    required this.cartItems,
    required this.themeNotifier,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategoryId = 'all';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  // Dữ liệu món ăn quản lý trạng thái cục bộ
  late List<FoodItem> _foods;

  @override
  void initState() {
    super.initState();
    _foods = List.from(mockFoods);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Danh sách món ăn sau khi lọc theo Danh mục và Từ khóa tìm kiếm
  List<FoodItem> get _filteredFoods {
    return _foods.where((food) {
      final matchesCategory =
          _selectedCategoryId == 'all' || food.categoryId == _selectedCategoryId;
      final matchesSearch =
          food.name.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _toggleFavorite(FoodItem food) {
    setState(() {
      food.isFavorite = !food.isFavorite;
    });
  }

  void _addToCart(FoodItem food, int quantity) {
    setState(() {
      final existingIndex =
          widget.cartItems.indexWhere((item) => item.food.id == food.id);
      if (existingIndex >= 0) {
        widget.cartItems[existingIndex].quantity += quantity;
      } else {
        widget.cartItems.add(CartItem(food: food, quantity: quantity));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = widget.themeNotifier.value == ThemeMode.dark;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar tuỳ chỉnh
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16, color: theme.colorScheme.primary),
                            const SizedBox(width: 4),
                            Text(
                              'Giao hàng tới',
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Quận 1, TP. Hồ Chí Minh ▾',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode_outlined),
                      tooltip: 'Đổi chế độ sáng / tối',
                      onPressed: () {
                        widget.themeNotifier.value =
                            isDark ? ThemeMode.light : ThemeMode.dark;
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Tiêu đề chào mừng
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text(
                  'Hôm nay bạn muốn\nthưởng thức món gì? 🍔',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                    height: 1.25,
                  ),
                ),
              ),
            ),

            // Thanh tìm kiếm (Search Box)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() => _searchQuery = value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm bánh burger, pizza...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                  ),
                ),
              ),
            ),

            // Danh sách Danh Mục (Cuộn ngang)
            SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: mockCategories.length,
                  itemBuilder: (context, index) {
                    final category = mockCategories[index];
                    return CategoryChip(
                      category: category,
                      isSelected: _selectedCategoryId == category.id,
                      onTap: () {
                        setState(() {
                          _selectedCategoryId = category.id;
                        });
                      },
                    );
                  },
                ),
              ),
            ),

            // Tiêu đề danh sách món
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Món ăn phổ biến',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${_filteredFoods.length} món',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),

            // Danh sách Món ăn (Grid 2 cột)
            if (_filteredFoods.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        const Text(
                          'Không tìm thấy món ăn phù hợp',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Hãy thử tìm bằng từ khoá khác xem sao!',
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.72,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final food = _filteredFoods[index];
                      return FoodCard(
                        food: food,
                        onTap: () {
                          // Điều hướng sang màn hình Chi Tiết bằng Navigator.push
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FoodDetailScreen(
                                food: food,
                                onToggleFavorite: () => _toggleFavorite(food),
                                onAddToCart: _addToCart,
                              ),
                            ),
                          ).then((_) {
                            // Cập nhật lại UI khi quay về màn hình Home
                            setState(() {});
                          });
                        },
                        onToggleFavorite: () => _toggleFavorite(food),
                      );
                    },
                    childCount: _filteredFoods.length,
                  ),
                ),
              ),

            // Khoảng đệm đáy màn hình
            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
          ],
        ),
      ),
    );
  }
}
