class Menu {
  final int id;
  final String name;
  final double price;

  Menu({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }
}
