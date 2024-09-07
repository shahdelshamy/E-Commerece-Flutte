import 'package:e_commerece/Pages/common_widget/slide_dialog.dart';
import 'package:e_commerece/constants.dart';
import 'package:e_commerece/layout_cubit_screen/layout_cubit.dart';
import 'package:e_commerece/layout_cubit_screen/layout_state.dart';
import 'package:e_commerece/shared/local_data.dart';
import 'package:e_commerece/user_cubit/user_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ChangeDataPage extends StatefulWidget {
  const ChangeDataPage({super.key});

  @override
  State<ChangeDataPage> createState() => _ChangeDataPageState();
}

class _ChangeDataPageState extends State<ChangeDataPage> with SingleTickerProviderStateMixin {

  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController imageController=TextEditingController();


  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    var cubit = BlocProvider.of<LayoutCubit>(context);
    var cubitUser = BlocProvider.of<UserCubit>(context);

    nameController.text=cubitUser.userModel!.name!;
    emailController.text=cubitUser.userModel!.email!;
    phoneController.text=cubitUser.userModel!.phone!;
    imageController.text=cubitUser.userModel!.image!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
        title: const Text('Update Your Data'),
        backgroundColor: Color(0xfffdfbda),
      ),
      body: BlocConsumer<LayoutCubit,LayoutState >(
        listener: (context, state) {
          if(state is ChangeDataSuccess){
            _showSlideDialog('Updated Successfully',true);

          }else if(state is ChangeDataError){
            _showSlideDialog(state.message,false);
          }
        },
        builder: (context, state) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              child:SingleChildScrollView(
                child: Stack(
                  children: [
                    Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: 'Name:',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.grey)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Color(0xff2d4569))
                                ),

                              ),


                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                labelText: 'Phone:',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.grey)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Color(0xff2d4569))
                                ),

                              ),


                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'Email:',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.grey)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Color(0xff2d4569))
                                ),

                              ),


                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              controller: imageController,
                              onTap:()=> _pickImage(),
                              decoration: InputDecoration(
                                labelText: 'Image:',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.grey)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Color(0xff2d4569))
                                ),
                                prefixIcon: Icon(Icons.image,),
                                prefixIconColor: Colors.grey

                              ),


                            ),
                            SizedBox(height: 20,),

                            ElevatedButton(
                              onPressed: () {
                                if (nameController.text.isNotEmpty &&phoneController.text.isNotEmpty &&emailController.text.isNotEmpty) {
                                  cubit.changeData(
                                      name:nameController.text ,
                                      email: emailController.text,
                                      phone: phoneController.text,
                                      image: imageController.text
                                  );
                                }

                              },
                              child: Text(
                                state is ChangeDataLoading ? 'Loading...' : 'Update',
                                style: const TextStyle(fontSize: 20, color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff2d4569),
                                minimumSize: Size(400, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                '⬅ Back To Profile',
                                style: TextStyle(fontSize: 20, color: Color(0xff2d4569)),
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(400, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),

                          ],
                        )

                    ),

                    if (state is ChangeDataLoading)
                     const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(child:CupertinoActivityIndicator(),)
                        ],
                      )


                  ],
                )
              )
          );
        },
      )
    );
  }



  void _showSlideDialog(String message, bool isSuccess) {
    showDialog(
      context: context,
      builder: (context) {
        return SlideDialog(
          message: message,
          isSuccess: isSuccess,
          controller: _controller,
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);



    if (image != null) {
      await CacheData().setData(key: 'image', value:image.path);
      ApiConfig.imagePath=await CacheData().getData('image');
        imageController.text = image.path;
    }
  }



}
