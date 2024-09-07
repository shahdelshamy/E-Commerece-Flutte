import 'package:e_commerece/constants.dart';
import 'package:e_commerece/layout_cubit_screen/layout_cubit.dart';
import 'package:e_commerece/layout_cubit_screen/layout_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        // Handle any side effects here if needed
      },
      builder: (context, state) {
        return Scaffold(
          body: cubit.favoriteId.isEmpty
              ? Center(
                  child: Text('No favorite products 🥺',
                      style: TextStyle(fontSize: 20, color: Color(0xff2d4569))))
              : Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: ListView.builder(
                        itemCount: cubit.favoriteProducts.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[200],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        100, // Set desired width for the image
                                    height:
                                        100, // Set desired height for the image
                                    child: Image.network(
                                      cubit.favoriteProducts[index].image!,
                                      fit: BoxFit
                                          .fill, // Ensures the image fills the SizedBox completely
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  // Space between image and text content
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cubit.favoriteProducts[index].name!,
                                          style: TextStyle(
                                              color: Color(0xff2d4569),
                                            fontSize: 16
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text(
                                              '${cubit.favoriteProducts[index].price.toString()}\$',
                                              style:
                                                  TextStyle(color: Colors.red, fontSize: 15),

                                            ),
                                            SizedBox(width: 10),
                                            if (cubit.favoriteProducts[index]
                                                    .price !=
                                                cubit.favoriteProducts[index]
                                                    .oldPrice)
                                              Text(
                                                '${cubit.favoriteProducts[index].oldPrice.toString()}\$',
                                                style: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                cubit.addOrRemovefavorite(cubit
                                                    .favoriteProducts[index].id
                                                    .toString());
                                              },
                                              child:Text(
                                                'Remove',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                padding:const EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                shape:const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                backgroundColor:
                                                    Color(0xff2d4569),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Show loading indicator on top of the list if the state is loading
                    if (state is AddOrRemoveFavoriteLoading ||
                        state is FavoriteProductLoading)
                      Center(child: CupertinoActivityIndicator()),
                  ],
                ),
        );
      },
    );
  }
}
