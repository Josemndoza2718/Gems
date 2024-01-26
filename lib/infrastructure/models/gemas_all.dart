class GemAll {
  final int id;
  final bool available;
  final String image;
  final int gemPropertiesId;
  final String gemType;
  final double price;
  final double size;
  final String color;
  final int clarity;
  int quantity;

  GemAll({
    required this.id,
    required this.available,
    required this.image,
    required this.gemPropertiesId,
    required this.gemType,
    required this.price,
    required this.size,
    required this.color,
    required this.clarity,
    required this.quantity,
  });

  factory GemAll.fromJson(Map<String, dynamic> json) {
    return GemAll(
      id: json['gem']['id'],
      available: json['gem']['available'],
      image: json['gem']['image'],
      gemPropertiesId: json['gem']['gem_properties_id'],
      gemType: json['gem']['gem_type'],
      price: json['gem']['price'].toDouble(),
      size: json['props']['size'].toDouble(),
      color: json['props']['color'],
      clarity: json['props']['clarity'],
      quantity: json["gem"]["quantity"],
    );
  }
}
