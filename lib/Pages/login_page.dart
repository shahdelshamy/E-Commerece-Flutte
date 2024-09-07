import 'package:e_commerece/Pages/Home_Page.dart';
import 'package:e_commerece/Pages/Register_page.dart';
import 'package:e_commerece/Pages/common_widget/alert_dialog.dart';
import 'package:e_commerece/authentication/auth_cubit.dart';
import 'package:e_commerece/authentication/cubit_state.dart';
import 'package:e_commerece/layout_cubit_screen/layout_cubit.dart';
import 'package:e_commerece/layout_cubit_screen/layout_page/layout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  String _loginStatue = 'Login';

  bool visiablePasswprd = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration:const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/auth_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3), // Adjust opacity as needed
          ),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  height: 270,
                  width: double.infinity,
                  alignment: Alignment.bottomCenter,
                  child: const Text(
                    'Login To Continue Process',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    decoration:  BoxDecoration(
                      //color: Color(0xfffdfbda),
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade100, Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius:const BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: BlocConsumer<AuthCubit, CubitState>(
                          listener: (context, state) {
                        if (state is LoginLoading) {
                          setState(() {
                            _loginStatue = 'Loading....';
                          });
                        } else if (state is LoginSuccess) {
                          BlocProvider.of<LayoutCubit>(context).getCarts();
                          BlocProvider.of<LayoutCubit>(context).getFavoriteProducts();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>LayoutPage(),
                              ));

                        } else if (state is LoginError) {
                          setState(() {
                            _loginStatue = 'Login';
                          });
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ShowAlertDialog(
                                  errorMessage:
                                      state.error ?? 'No error message available');
                            },
                          );
                        }
                      }, builder: (context, state) {
                        return Column(
                          children: [
                            const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff2d4569),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: emailController,
                                    validator: (value) {
                                      return value!.isEmpty
                                          ? 'This Field is Required'
                                          : null;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: 'Email:',
                                      prefixIcon: Icon(Icons.email),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    obscureText: true && !visiablePasswprd,
                                    controller: passwordController,
                                    validator: (value) {
                                      return value!.isEmpty
                                          ? 'This Field is Required'
                                          : null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Password:',
                                      prefixIcon: const Icon(Icons.password),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            visiablePasswprd = !visiablePasswprd;
                                          });
                                        },
                                        icon: Icon(visiablePasswprd
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<AuthCubit>(context).login(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff2d4569),
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 100),
                              ),
                              child: Text(
                                _loginStatue,
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Don\'t Have An Account?'),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                        MaterialPageRoute(builder: (context) => RegisterPage(),)
                                        );
                                      },
                                      child: Text(
                                        'Create One',
                                        style: TextStyle(
                                            color: Color(0xff2d4569),
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.underline),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
