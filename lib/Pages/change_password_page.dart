import 'package:e_commerece/Pages/common_widget/slide_dialog.dart';
import 'package:e_commerece/Pages/profile_page.dart';
import 'package:e_commerece/layout_cubit_screen/layout_cubit.dart';
import 'package:e_commerece/layout_cubit_screen/layout_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerece/Pages/common_widget/slide_dialog.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> with SingleTickerProviderStateMixin {

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

  TextEditingController currentController = TextEditingController();
  TextEditingController newController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool isvisiable = false;
  bool isvisiable1 = false;

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
        title: const Text('Update Your Password'),
        backgroundColor: Color(0xfffdfbda),
      ),
      body: BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            _showSlideDialog('Password updated successfully!', true);
          } else if (state is ChangePasswordError && currentController.text.length > 6) {
            _showSlideDialog('Your Current Password Not Correct, Try Again!', false);
          } else if (state is ChangePasswordError) {
            _showSlideDialog(state.message, false);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        obscureText: true && !isvisiable,
                        controller: currentController,
                        validator: (value) {
                          return currentController.text.isEmpty ? 'Current Password is required' : null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          label: Text('Current Password:'),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isvisiable = !isvisiable;
                              });
                            },
                            icon: Icon(
                              isvisiable ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true && !isvisiable1,
                        controller: newController,
                        validator: (value) {
                          return newController.text.isEmpty ? 'New Password is required' : null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          label: const Text('New Password:'),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isvisiable1 = !isvisiable1;
                              });
                            },
                            icon: Icon(
                              isvisiable1 ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState?.validate() ?? false) {
                            cubit.changePassword(
                              currentPassword: currentController.text.trim(),
                              newPassword: newController.text.trim(),
                            );
                          }
                        },
                        child: Text(
                          state is ChangePasswordLoading ? 'Loading...' : 'Update',
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
                  ),
                ),
              ),
              if (state is ChangePasswordLoading)
                Center(
                  child: CupertinoActivityIndicator(
                    color: Colors.grey[400],
                    radius: 20,
                  ),
                ),
            ],
          );
        },
      ),
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




}
