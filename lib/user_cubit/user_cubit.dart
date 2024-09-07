import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:e_commerece/constants.dart';
import 'package:e_commerece/models/user_model.dart';
import 'package:e_commerece/shared/local_data.dart';
import 'package:e_commerece/user_cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class UserCubit extends Cubit<UserState>{

  //UserCubit():super(GetUserLoading());

  UserCubit._internal() : super(GetUserLoading());

   //Static field to hold the single instance
  static final UserCubit _instance = UserCubit._internal();

  factory UserCubit() {
    return _instance;
  }

  UserModel? userModel;

  Future<void> getUserData() async {
    try{
      emit(GetUserLoading());
      Response response=await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.profileEndPoint}'),
        headers: {
          'lang':'en',
          'Authorization':ApiConfig.tokenForSharedPref
        }
      ) ;

      var responseData=jsonDecode(response.body);
      if(responseData['status']==true){
        userModel=UserModel.fromJson(responseData['data']);
          emit(GetUserSucess());
      }else{
        emit(GetUserError(error:responseData['message']));
      }

    }catch(e){
        print('Failed request${e.toString()}');
    }



  }


  Future<void> logout() async {
    print(UserModel().email);
    await CacheData().initializeShared();
    await CacheData().deleteData('token');
    await CacheData().deleteData('image_${userModel!.email!}');
    ApiConfig.tokenForSharedPref='';
    ApiConfig.imagePath='';
    emit(logoutSuccess());
  }

}
