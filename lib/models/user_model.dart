class UserModel{
  String? name;
  String? phone;
  String? email;
  String? image;
  String? token;

  // UserModel._internal();
  //
  // // Static field that holds the single instance
  // static final UserModel _instance = UserModel._internal();
  //
  // // Factory constructor to return the single instance
  // factory UserModel() {
  //   return _instance;
  // }

  UserModel(){
  }

  UserModel.fromJson(Map<String,dynamic> data){
   this.name=data['name'];
   this.phone=data['phone'];
   this.email=data['email'];
   this.image=data['image'];
   this.token=data['token'];
  }


   Map<String,dynamic> toMap(){
   return {
   'name':name,
   'phone':phone,
    'email':email,
    'image':image,
    'token':token
   };




  }


}