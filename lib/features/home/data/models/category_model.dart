class CategoriesModel {
  int? id;
  String? imageUrl;
  String? title;

  CategoriesModel.fromJson({required Map<String, dynamic> json}) {
    id = json['id'];
    imageUrl = json['image'];
    title = json['name'];
  }
}
