class ProductModel {
  String? name;
  String? description;
  String? image;
  int? price;
  int? oldPrice;
  int? id;
  int? discount;

  ProductModel.fromJsom({required Map<String, dynamic> json}) {
    name = json['name'].toString();
    id = json['id'].toInt();
    description = json['description'].toString();
    price = json['price'].toInt();
    oldPrice = json['old_price'].toInt();
    discount = json['discount'].toInt();
    image = json['image'].toString();
  }
}
