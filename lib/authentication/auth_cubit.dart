import 'dart:convert';


import 'package:e_commerece/constants.dart';
import 'package:e_commerece/authentication/cubit_state.dart';
import 'package:e_commerece/layout_cubit_screen/layout_cubit.dart';
import 'package:e_commerece/shared/local_data.dart';
import 'package:e_commerece/user_cubit/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';



class AuthCubit extends Cubit<CubitState> {

  AuthCubit():super(RegisterLoading());


  Future<void> register({required String name,required  String email,required  String phone,required  String password,String? image} )async {
      emit(RegisterLoading());

      try{
        Response response=  await http.post(
          Uri.parse('${ApiConfig.baseUrl}${ApiConfig.registerEndPoint}'),
          body: {
            'name':name,
            'image': image ?? 'https://student.valuxapps.com/storage/assets/defaults/user.jpg',
            'email':email,
            'phone':phone,
            'password':password
          },
          headers: {
            'lang':'en',
          }

        );
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var responseBody = jsonDecode(response.body);
        print('Parsed response: $responseBody');

          if(responseBody['status']==true){

            if (image != null) {
              await CacheData().setData(key:'image_$email', value: image);
            }

            emit(RegisterSuccess());
          }
          else{
            emit(RegisterError(error: responseBody['message'] ?? 'Unknown error'));
          }


    }catch(e){
       
    }

  }

  Future<void> login({required String email,required String password}) async {

    try{

       emit(LoginLoading());
       Response response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.loginEndPoint}'),
        body: {
          'email':email,
          'password':password
        },
        headers: {
          'lang':'en'
        }
      );

       if(response.statusCode==200) {

         var data = jsonDecode(response.body);

         if (data['status'] == true) {

           await CacheData().setData(
               key:'token',
               value:data['data']['token']
           );


           ApiConfig.tokenForSharedPref = await CacheData().getData('token');
           ApiConfig.imagePath=await CacheData().getData('image_$email');


           LayoutCubit().cartsId={};
           LayoutCubit().favoriteId={};
           // await LayoutCubit().getCarts();
           // await LayoutCubit().getProducts();
           // await LayoutCubit().getFavoriteProducts();
           await UserCubit().getUserData();



           emit(LoginSuccess());
         } else {
           emit(LoginError(error: data['message']));
         }
       }

    }catch(e){
        print('Failes to Login ${e.toString()}');
    }

  }


}