
class CartModel {
  CartModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.totalItem,
  });

  int id;
  String title;
  double price;
  String description;
  String image;
  int totalItem;

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "image": image,
  };

}

