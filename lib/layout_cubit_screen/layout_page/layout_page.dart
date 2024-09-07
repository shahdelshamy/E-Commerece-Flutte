import 'package:e_commerece/Pages/cards_page.dart';
import 'package:e_commerece/layout_cubit_screen/layout_cubit.dart';
import 'package:e_commerece/layout_cubit_screen/layout_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';


class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit=BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit,LayoutState>(
        listener: (context, state) {
            if(state is LayoutLoading){
             const Center(
                child: CircularProgressIndicator(),
              );
            }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
             title: SvgPicture.asset("images/logo.svg",height: 40,width: 40,),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade100, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              elevation: 0,
              actions: [
                Container(
                  padding: const EdgeInsets.only(right: 40),
                  child: Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_cart,size: 27,color: Color(0xff2d4569),),
                        onPressed: () {
                          cubit.currecntIndex=3;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  LayoutPage()),
                          );
                        },
                      ),
                      Positioned(
                        right:0,
                        top: 0,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            cubit.cartsId.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex:cubit.currecntIndex ,
                  onTap: (value) {
                    cubit.changeIndex(value);
                  },
                  items:const[
                    BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
                    BottomNavigationBarItem(icon: Icon(Icons.category),label: "Category"),
                    BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favorite"),
                    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Carts"),
                    BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
                  ],
                selectedItemColor:  Color(0xff2d4569),
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
              ),
            body: cubit.pages[cubit.currecntIndex],

          );
        },
       );
  }
}


