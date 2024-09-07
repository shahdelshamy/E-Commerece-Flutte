import 'package:e_commerece/layout_cubit_screen/layout_cubit.dart';
import 'package:e_commerece/layout_cubit_screen/layout_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);

    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          body:  cubit.cartsId.isEmpty
              ?Center(child: Text('No Products In Carts 💸',style: TextStyle(fontSize: 20,color: Color(0xff2d4569))))
              : Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                     padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                      child: Column(
                      children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cubit.carts.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            margin: EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.all(Radius.circular(10),)
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Image.network(
                                    cubit.carts[index].image!,
                                    height: 100,
                                  ),
                                ),
                                SizedBox(width:5),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(cubit.carts[index].name!,style: TextStyle(overflow:TextOverflow.ellipsis,color: Color(0xff2d4569),fontSize: 16 ),),
                                      SizedBox(height: 7),
                                      Row(
                                        children: [
                                          Text('${cubit.carts[index].price.toString()}\$'
                                              ,style: TextStyle(fontSize: 15),),
                                          SizedBox(width: 10),
                                          if (cubit.carts[index].price !=
                                              cubit.carts[index].oldPrice)
                                            Text(
                                              cubit.carts[index].oldPrice
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationColor: Colors.grey
                                              ),
                                            ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              cubit.addOrRemovefavorite(
                                                  cubit.carts[index].id
                                                      .toString());
                                            },
                                            icon: cubit.favoriteId
                                                .contains(cubit
                                                .carts[index].id
                                                .toString())
                                                ? Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                              size: 28,
                                            )
                                                : Icon(
                                              Icons
                                                  .favorite_border_rounded,
                                              color: Colors.grey,
                                              size: 28,
                                            ),
                                          ),

                                          IconButton(
                                            onPressed: () {
                                              cubit.addOrRemoveCarts(cubit
                                                  .carts[index].id
                                                  .toString());
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 28,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      if (cubit.carts.isNotEmpty)
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 10,top: 10),
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50),)
                          ,color: Color(0xffE6D1DFFF),
                        ),
                        child: Text(
                          'The Total Price is: ${cubit.totalPrice}\$',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xff2d4569),fontSize: 17,fontWeight: FontWeight.bold),
                        ),
                      ),


                    ],
                  ),
                ),
              ),

                 if(state is AddOrRemoveCartsLoading || state is CartsLoading)
                   Center(child: CupertinoActivityIndicator(),)
            ],
          )


        );
      },
    );
  }
}
