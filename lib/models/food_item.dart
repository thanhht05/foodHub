/// Model đại diện cho một món ăn trong ứng dụng FoodHub
class FoodItem {
  final String id;
  final String name;
  final String categoryId;
  final String description;
  final double price;
  final double rating;
  final int reviewsCount;
  final String imageUrl;
  final String deliveryTime; // Ví dụ: "20-25 min"
  final int calories;
  bool isFavorite;

  FoodItem({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.description,
    required this.price,
    required this.rating,
    required this.reviewsCount,
    required this.imageUrl,
    required this.deliveryTime,
    required this.calories,
    this.isFavorite = false,
  });
}

