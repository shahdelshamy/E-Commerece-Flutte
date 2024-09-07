import 'package:e_commerece/layout_cubit_screen/layout_cubit.dart';
import 'package:e_commerece/layout_cubit_screen/layout_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
   var cubit= BlocProvider.of<LayoutCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
      child: Scaffold(
          body:BlocConsumer<LayoutCubit,LayoutState>(
            listener:(context, state) {
              if(state is CategoryLoading ){
                CupertinoActivityIndicator();
              }
            },
            builder: (context, state) {
              return GridView.builder(
                itemCount: cubit.categoryModel.length,
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 10
                ) ,
                itemBuilder: (context, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            child: Image.network(cubit.categoryModel[index].image!,fit: BoxFit.fill,),
                        ),
                        SizedBox(height: 10,),
                        Text(cubit.categoryModel[index].name!,style: TextStyle(fontSize:16,color: Color(0xff2d4569),fontWeight: FontWeight.w400) )
                      ],
                    ),
                  );
                },
              );
            },


          )
      ),
    );
  }
}