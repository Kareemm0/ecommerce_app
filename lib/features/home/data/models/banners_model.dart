class BannersModel {
  int? id;
  String? imageUrl;

  BannersModel.fromJson({required Map<String, dynamic> json}) {
    id = json['id'];
    imageUrl = json['image'];
  }
}
