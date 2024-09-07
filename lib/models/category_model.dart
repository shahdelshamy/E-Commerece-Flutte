class CategoryModel{
  String? image;
  String? name;
  int? id;

  CategoryModel({this.image,this.name, this.id});

  CategoryModel.fromJson(Map<String,dynamic> data){
    image=data['image'];
    name=data['name'];
    id=data['id'];
  }

}