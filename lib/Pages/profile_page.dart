import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerece/Pages/change_data_page.dart';
import 'package:e_commerece/Pages/change_password_page.dart';
import 'package:e_commerece/Pages/login_page.dart';
import 'package:e_commerece/Pages/splash_page.dart';
import 'package:e_commerece/constants.dart';
import 'package:e_commerece/layout_cubit_screen/layout_cubit.dart';
import 'package:e_commerece/user_cubit/user_cubit.dart';
import 'package:e_commerece/user_cubit/user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<UserCubit,UserState>(
        listener: (context, state)  {
         if(state is logoutSuccess){
           BlocProvider.of<LayoutCubit>(context).currecntIndex=0;
           Navigator.pushAndRemoveUntil(
             context,
             MaterialPageRoute(builder: (context) => SplashPage()),
                 (Route<dynamic> route) => true,
           );

         }

        },
        builder: (context, state) {
          var userCubit = BlocProvider.of<UserCubit>(context);
          var cubit1 = BlocProvider.of<LayoutCubit>(context);
          var userModel = userCubit.userModel;
          return Scaffold(
                body: userModel != null
                ? SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    child: Column(
                      children: [
                      state is GetUserLoading
                      ?Center(child: CupertinoActivityIndicator(),)
                      :
                      CircleAvatar(
                        radius: 50,
                         backgroundImage: (ApiConfig.imagePath !='' && ApiConfig.imagePath != null) ? FileImage(File(ApiConfig.imagePath)):NetworkImage(userModel.image!)
                      ),
                       SizedBox(height: 15,),
                       Center(
                         child: Text(userModel.name!,style: TextStyle(color: Color(0xff2d4569) ,fontSize: 20,fontWeight: FontWeight.bold),),
                       ),
                       Container(
                         child: Column(
                           children: [

                             ListTile(
                               leading: Icon(Icons.email,color: Colors.blueAccent,),
                               title: Text('Your Email:'),
                               subtitle: Text(userModel.email!,style: TextStyle(color: Colors.grey ,fontSize: 15),),
                             ),

                             divider(),

                             ListTile(
                              leading: Icon(Icons.phone,color: Colors.green,),
                              title: Text('Your Phone:'),
                              subtitle: Text(userModel.phone!,style: TextStyle(color: Colors.grey ,fontSize: 15),),
                            ),

                             divider(),

                             ListTile(
                               leading: Icon(Icons.favorite,color: Colors.red,),
                               title: Text('Number Of Favorite Products: ${cubit1.favoriteId.length.toString()}'),
                             ),

                             divider(),

                             ListTile(
                               leading: Icon(Icons.shopping_cart,color:Colors.greenAccent,),
                               title: Text('Number Of Crads Products: ${cubit1.cartsId.length.toString()}'),
                             ),

                             divider(),

                             ListTile(
                               leading: Icon(Icons.lock,color:Colors.grey[700],),
                               title: Text('Change Your Password'),
                               onTap: () {
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordPage() ,));
                               } ,
                             ),

                             divider(),

                             ListTile(
                               leading: Icon(Icons.edit,color:Color(0xffAA5151FF),),
                               title: Text('Change Your Data'),
                               onTap: () {
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeDataPage() ,));
                               } ,
                             ),

                             divider(),

                             ListTile(
                               leading: Icon(Icons.logout,color:Colors.red,),
                               title: Text('Logout'),
                               onTap: () {
                                 userCubit.logout();
                                 } ,
                             ),

                           ],
                         ),
                       ),


                    ],
                                ),
                  ),
                )

            : Center(child: CupertinoActivityIndicator(),),
          );
        },

    );
  }


  Widget divider(){
    return Divider(
      color: Colors.grey,
      thickness: 1,
    );
  }

}
