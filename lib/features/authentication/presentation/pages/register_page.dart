import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:safepak/core/common/widgets/button_widget.dart';
import 'package:safepak/features/authentication/domain/entities/sign_in_params.dart';
import 'package:safepak/features/authentication/presentation/bloc/auth_cubit/authentication_cubit.dart';
import '../../../../core/configs/utils/validator.dart';
import '../../../../core/configs/theme/app_colors.dart';
import 'package:loading_indicator/loading_indicator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create an account",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _usernameController,
                    cursorColor: AppColors.primaryColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Username',
                      filled: true,
                      fillColor: AppColors.lightGrey,
                      prefixIcon: Icon(
                        Clarity.user_line,
                        color: AppColors.secondaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _emailController,
                    cursorColor: AppColors.primaryColor,
                    validator: (value) {
                      return Validator.emailValidator(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      fillColor: AppColors.lightGrey,
                      prefixIcon: Icon(
                        Clarity.email_line,
                        color: AppColors.secondaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    cursorColor: AppColors.primaryColor,
                    validator: (value) {
                      return Validator.passwordValidator(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: AppColors.lightGrey,
                      prefixIcon: Icon(
                        BoxIcons.bx_lock,
                        color: AppColors.secondaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? OctIcons.eye_closed
                              : OctIcons.eye,
                          color: AppColors.primaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  BlocConsumer<AuthenticationCubit, AuthenticationState>(
                    listener: (context, state) {
                      if (state is AuthenticatedButNotComplete) {
                        context.go('/create_account_page_1',
                        extra: state.user,
                        );
                        Fluttertoast.showToast(
                          msg: "Registration successful!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                      if (state is AuthenticationError) {
                        Fluttertoast.showToast(
                          msg: state.message.message,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    },
                    builder: (context, state) {
                      return ButtonWidget(
                        content: state is AuthenticationLoading
                            ? Center(
                                child: LoadingIndicator(
                                  indicatorType: Indicator.ballPulse,
                                  colors: [Colors.white],
                                  strokeWidth: 10,
                                ),
                              )
                            : Text(
                                "Register",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            context
                                .read<AuthenticationCubit>()
                                .signUpWithEmailAndPassword(
                                  params: SignInParams(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    name: _usernameController.text.trim(),
                                  ),
                                );
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?  ",
                        style: TextStyle(fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go('/login');
                        },
                        child: Text(
                          "Login here",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height:30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}