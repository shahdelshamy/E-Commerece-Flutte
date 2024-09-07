class BannerModel{
  String? image;
  int? id;

  BannerModel({this.image, this.id});

  BannerModel.fromJson(Map<String,dynamic> data){
    image=data['image'];
    id=data['id'];
  }

}