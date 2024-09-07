import 'package:e_commerece/layout_cubit_screen/layout_cubit.dart';
import 'package:e_commerece/layout_cubit_screen/layout_state.dart';
import 'package:e_commerece/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    PageController pagecontroller = PageController();

    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          cubit.getFilterProducts(value);
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Search',
                          suffixIcon: const Icon(Icons.clear),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff2d4569),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        height: 130,
                        child: PageView.builder(
                          controller: pagecontroller,
                          itemCount: 4,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return state is BannerLoading ||
                                cubit.bannersModel.isEmpty
                                ? Center(
                              child: CupertinoActivityIndicator(),
                            )
                                : Container(
                              margin: EdgeInsets.only(right: 15),
                              child: Image.network(
                                cubit.bannersModel[index].image!,
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: SmoothPageIndicator(
                          controller: pagecontroller,
                          count: 4,
                          axisDirection: Axis.horizontal,
                          effect: const SlideEffect(
                            spacing: 8.0,
                            radius: 15,
                            dotWidth: 15,
                            dotHeight: 15,
                            paintStyle: PaintingStyle.stroke,
                            strokeWidth: 1.5,
                            dotColor: Colors.grey,
                            activeDotColor: Color(0xff2d4569),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Categories',
                              style: TextStyle(
                                fontSize: 17,
                                color: Color(0xff2d4569),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'View All',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        child: ListView.builder(
                          itemCount: cubit.categoryModel.length,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return state is CategoryLoading ||
                                cubit.categoryModel.isEmpty
                                ? Center(
                              child: CupertinoActivityIndicator(),
                            )
                                : Container(
                              width: 70,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  cubit.categoryModel[index].image!,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Products',
                              style: TextStyle(
                                fontSize: 17,
                                color: Color(0xff2d4569),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'View All',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      cubit.productModel.isEmpty
                          ? Center(child: CupertinoActivityIndicator())
                          : GridView.builder(
                        itemCount: cubit.filteredProducts.isEmpty
                            ? cubit.productModel.length
                            : cubit.filteredProducts.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.6,
                        ),
                        itemBuilder: (context, index) {
                          return _getProduct(
                            cubit.filteredProducts.isEmpty
                                ? cubit.productModel[index]
                                : cubit.filteredProducts[index],
                            cubit,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              if (state is AddOrRemoveFavoriteLoading || state is AddOrRemoveCartsLoading )
                Center(
                  child: Container(
                    child: CupertinoActivityIndicator(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _getProduct(ProductModel model, LayoutCubit cubit) {
    return Stack(
      children:[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: SizedBox(
                    child: Image.network(
                      model.image!,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                model.name!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('${model.price!.toString()}\$'),
                      Text(
                        '${model.oldPrice!.toString()}\$',
                        style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      // Add or remove favorite
                      cubit.addOrRemovefavorite(model.id.toString());
                    },
                    icon: cubit.favoriteId.contains(model.id.toString())
                        ? Icon(Icons.favorite, color: Colors.red)
                        : Icon(Icons.favorite_border, color: Colors.grey),
                  ),
                ],
              ),
             SizedBox(height: 20),
            ],
          ),
        ),
        Positioned(
          bottom: 5,
          left: 70,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {
                cubit.addOrRemoveCarts(model.id.toString());
              },
              icon: Icon(
                Icons.shopping_cart,
                color: cubit.cartsId.contains(model.id.toString())? Colors.red : Colors.grey,
              ),
            ),
          ),
        )
      ]
    );
  }
}
