import 'dart:io';

import 'package:e_commerece/Pages/home_page.dart';
import 'package:e_commerece/Pages/login_page.dart';
import 'package:e_commerece/authentication/auth_cubit.dart';
import 'package:e_commerece/authentication/cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerece/Pages/common_widget/alert_dialog.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController controllerUserName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerImagePath = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  String registerValue = 'Register';

  bool _isPasswordVisible = false;

  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(),),
      ],

      child: BlocConsumer<AuthCubit, CubitState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return LoginPage();
                })
            );
          } else if (state is RegisterError) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ShowAlertDialog(
                    errorMessage: state.error ?? 'No error message available');
              },
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('images/registerImage.png'),
                      ),
                      SizedBox(height: 20),
                      const Text(
                        'Register Account',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          // color: Colors.deepPurple,
                        ),
                      ),
                      SizedBox(height: 4),
                      const Text(
                        'Please complete your details',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 20),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            _TextFormWidget('UserName:*', controllerUserName,
                                Icon(Icons.person), false),
                            SizedBox(height: 20),
                            _TextFormWidget(
                                'Select Image:', controllerImagePath,
                                Icon(Icons.image), false, true, () =>
                                _pickImage()),
                            SizedBox(height: 20),
                            _TextFormWidget(
                                'Email:*', controllerEmail, Icon(Icons.email),
                                false),
                            SizedBox(height: 20),
                            _TextFormWidget(
                                'Phone:*', controllerPhone, Icon(Icons.phone),
                                false),
                            SizedBox(height: 20),
                            _TextFormWidget('Password:*', controllerPassword,
                                Icon(Icons.lock), true),
                            SizedBox(height: 40),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    BlocProvider.of<AuthCubit>(context)
                                        .register(
                                      name: controllerUserName.text,
                                      image: controllerImagePath.text,
                                      email: controllerEmail.text,
                                      password: controllerPassword.text,
                                      phone: controllerPhone.text,
                                    );
                                    if (state is RegisterLoading) {
                                      registerValue = 'Loading...';
                                    }
                                  }
                                },
                                child: Text(registerValue, style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff2d4569),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Aleardy have an account?'),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage(),)
                                        );
                                      },
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(
                                            color: Color(0xff2d4569),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            decoration: TextDecoration
                                                .underline),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _TextFormWidget(String name, TextEditingController controller,
      Widget icon, bool isSecure, [bool? redOnly, Function? onTap]) {
    return TextFormField(
        controller: controller,
        readOnly: redOnly ?? false,
        onTap: onTap != null ? () => onTap() : null,
      validator: (value) {
        if (redOnly != true && (value == null || value.isEmpty)) {
          return 'This field is required';
        }
        return null;
      },

    obscureText: isSecure && !_isPasswordVisible,
    decoration: InputDecoration(
    prefixIcon: icon,
    labelText: name,
    prefixIconColor: Colors.grey,


    suffixIcon: isSecure
    ? IconButton(
    icon: !_isPasswordVisible ? Icon(Icons.visibility_off,) :Icon(Icons.visibility),
    onPressed: () {
    setState(() {
    _isPasswordVisible=!_isPasswordVisible;
    });
    }
    )
        :null,

    suffixIconColor: Colors.grey,

    focusColor: Color(0xff2d4569),
    errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.red),
    ),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color:Color(0xff2d4569)),
    ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.grey),
    ),
    ),
    );
  }

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() async {
        // await CacheData().setData(key: 'image', value:image.path);
        // ApiConfig.imagePath=await CacheData().getData('image');
        controllerImagePath.text = image.path;
      });
    }
  }


}
