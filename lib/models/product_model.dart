class ProductModel {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  ProductModel.fromJson(Map<String,dynamic>data){
    id=data['id'].toInt();
    price=data['price'].toInt();
    oldPrice=data['old_price'].toInt();
    discount=data['discount'].toInt();
    image=data['image'];
    name=data['name'];
    description=data['description'];
  }





}