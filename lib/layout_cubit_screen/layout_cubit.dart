import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:e_commerece/Pages/Home_Page.dart';
import 'package:e_commerece/Pages/cards_page.dart';
import 'package:e_commerece/Pages/category_page.dart';
import 'package:e_commerece/Pages/favorite_page.dart';
import 'package:e_commerece/Pages/profile_page.dart';
import 'package:e_commerece/constants.dart';
import 'package:e_commerece/layout_cubit_screen/layout_state.dart';
import 'package:e_commerece/models/banner_model.dart';
import 'package:e_commerece/models/category_model.dart';
import 'package:e_commerece/models/product_model.dart';
import 'package:e_commerece/shared/local_data.dart';
import 'package:e_commerece/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class LayoutCubit extends Cubit<LayoutState>{

 //LayoutCubit():super(LayoutLoading());

  LayoutCubit._internal() : super(LayoutLoading());

  //Static field to hold the single instance
  static final LayoutCubit _instance = LayoutCubit._internal();

  factory LayoutCubit() {
    return _instance;
  }


  int currecntIndex=0;

  List<Widget>pages=[
    HomePage(),
    CategoryPage(),
    FavoritePage(),
    CardsPage(),
    ProfilePage()
  ];

  void changeIndex(int index){
    currecntIndex=index;
    emit(LayoutPageChanged());
  }


  List<BannerModel> bannersModel=[];
  Future<void> getBannerData() async {
    try{
      emit(BannerLoading());
      Response response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.bannerEndPoint}'),
        headers: {
          'lang':'en',
        }
      );
      var responseBody=jsonDecode(response.body);
      if(responseBody['status']==true){
         for(var item in responseBody['data']){
           BannerModel object=BannerModel.fromJson(item);
           bannersModel.add(object);
         }
         emit(BannerSuccess());
      }else{
        emit(BannerError(error:responseBody['message']));
      }

      
    }catch(e){
      print('failed to fetch the banners');
    }
    
    
  }


  List<CategoryModel> categoryModel=[];
  Future<void> getCategoryData() async {
    try{
      emit(CategoryLoading());
      Response response = await http.get(
          Uri.parse('${ApiConfig.baseUrl}${ApiConfig.categoryEndPoint}'),
          headers: {
            'lang':'en',
          }
      );
      var responseBody=jsonDecode(response.body);
      if(responseBody['status']==true){
        for(var item in responseBody['data']['data']){
          CategoryModel object=CategoryModel.fromJson(item);
          categoryModel.add(object);
        }
        emit(CategorySuccess());
      }else{
        emit(CategoryError(error:responseBody['message']));
      }


    }catch(e){
      print('failed to fetch the categories');
    }


  }

  List<ProductModel>productModel=[];
  Future<void> getProducts() async {
    try{
    Response response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}${ApiConfig.productEndPoint}'),
      headers: {
        'lang':'en',
        'Authorization':ApiConfig.tokenForSharedPref
      }
    );

   var responseBody=jsonDecode(response.body);

    if(responseBody['status']==true){
      print('doneasasa');
      for(var product in responseBody['data']['products']){
        productModel.add(ProductModel.fromJson(product));
      }
        emit(ProductSuccess());
    }else{
      emit(ProductError(error: responseBody['message']));
    }

    }catch(e){
      print('failed to fetch the products');
    }


  }

  List<ProductModel>filteredProducts=[];
  void getFilterProducts(String input){
    filteredProducts= productModel.where((element) {
      return element.name!.toLowerCase().contains(input.toLowerCase());
    }).toList();
    emit(FilterProductSuccess());    //for update ui
  }


  List<ProductModel>favoriteProducts=[];
  Set favoriteId={};
  Future<void> getFavoriteProducts() async {
    try{
      emit(FavoriteProductLoading());
      favoriteProducts.clear();
      Response response = await http.get(
          Uri.parse('${ApiConfig.baseUrl}${ApiConfig.favoriteEndPoint}'),
          headers: {
            'lang':'en',
            'Authorization':ApiConfig.tokenForSharedPref
          }
      );

      var responseBody=jsonDecode(response.body);

      if(responseBody['status']==true){
        for(var product in responseBody['data']['data']){
          favoriteProducts.add(ProductModel.fromJson(product['product']));
          favoriteId.add(product['product']['id'].toString());
        }
        emit(FavoriteProductSuccess());
      }else{
        emit(FavoriteProductError());
      }

    }catch(e){
      print('failed to fetch the favorite products');
    }


  }


  Future<void> addOrRemovefavorite(String id) async {
    emit(AddOrRemoveFavoriteLoading());
    Response response= await http.post(
      Uri.parse('${ApiConfig.baseUrl}${ApiConfig.favoriteEndPoint}'),
      body: {
        'product_id':id
      },
      headers: {
        'lang':'en',
        'Authorization':ApiConfig.tokenForSharedPref

    }
    );

    var responsebody=jsonDecode(response.body);
    if(responsebody['status']==true){

        if(favoriteId.contains(id)){
          favoriteId.remove(id);
        }else{
          favoriteId.add(id);
        }
        await getFavoriteProducts();
        emit(AddOrRemoveFavoriteSuccess());
    }
    else{
      emit(AddOrRemoveFavoriteError());
    }


  }


  List <ProductModel>carts=[];
  Set cartsId = {};
  int totalPrice=0;
  Future<void> getCarts() async {
    emit(CartsLoading());
    carts.clear();
   Response response=await  http.get(
      Uri.parse('${ApiConfig.baseUrl}${ApiConfig.cartEndPoint}'),
      headers: {
        'lang':'en',
        'Authorization':ApiConfig.tokenForSharedPref
      }
    );

   var responseBody=jsonDecode(response.body);

   if(responseBody['status']=true){
     totalPrice=responseBody['data']['total'].toInt();
     for(var item in responseBody['data']['cart_items']){
       carts.add(ProductModel.fromJson(item['product']));
       cartsId.add(item['product']['id'].toString());
     }
     emit(CartsSuccess());
   }else{
        emit(CartsError());
   }

  }

  Future<void> addOrRemoveCarts(String id) async {
    emit(AddOrRemoveCartsLoading());
    Response response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}${ApiConfig.cartEndPoint}'),
      body: {
        'product_id':id
      },
      headers: {
        'lang':'en',
        'Authorization':ApiConfig.tokenForSharedPref
      }
    );

    var responseBody=jsonDecode(response.body);
    if(responseBody['status']==true){
        if(cartsId.contains(id)){
          cartsId.remove(id);
        }else{
          cartsId.add(id);
        }
      await getCarts();
       emit(AddOrRemoveCartsSuccess());
    }else{
      emit(AddOrRemoveCartsError());
    }



  }

  Future<void> changePassword({required String currentPassword,required String newPassword}) async {
     
    emit(ChangePasswordLoading());

     Response response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.changePasswordEndPoint}'),
       body: {
          'current_password':currentPassword,
         'new_password':newPassword
       },
       headers: {
          'lang':'en',
         'Authorization':ApiConfig.tokenForSharedPref
       }
     );

     var responseBody=jsonDecode(response.body);
     if(responseBody['status']==true){
       CacheData().setData(key: 'password', value:newPassword);
       emit(ChangePasswordSuccess());
     }else{
       emit(ChangePasswordError(responseBody['message']));
     }
     
     
     
  }

  Future<void> changeData({required String name, required String email, required String phone, String? image}) async {
    try {
      emit(ChangeDataLoading());

      Response response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.changeDataEndPoint}'),
        body: {
          'name': name,
          'phone': phone,
          'email': email,
          'image': image
        },
        headers: {
          'lang': 'en',
          'Authorization': ApiConfig.tokenForSharedPref
        },
      );

      print(ApiConfig.tokenForSharedPref);

      var responseBody = jsonDecode(response.body);

      if (responseBody['status'] == true) {
        await CacheData().setData(key: 'image', value: image!);
        ApiConfig.imagePath = CacheData().getData('image');
        await UserCubit().getUserData();  // Refresh user data after successful change
        emit(ChangeDataSuccess());
      } else {
        emit(ChangeDataError(responseBody['message']));
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      emit(ChangeDataError('Failed to change data.'));
    }
  }





}