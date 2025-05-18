import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:safepak/core/common/widgets/button_widget.dart';
import 'package:safepak/features/authentication/domain/entities/sign_in_params.dart';
import 'package:safepak/features/authentication/presentation/bloc/auth_cubit/authentication_cubit.dart';
import '../../../../Home/home_screen.dart';
import '../../../../core/configs/utils/validator.dart';
import 'register_page.dart';
import '../../../../core/configs/const/asset_const.dart' show AssetConst;
import '../../../../core/configs/theme/app_colors.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _validateInputs() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Email and password cannot be empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
    return true;
  }

  void _login() async {
    if (!_validateInputs()) return;


    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      User? user = userCredential.user;

      if (user != null) {
        if (!user.emailVerified) {
          await _auth.signOut();
          Fluttertoast.showToast(
            msg: "Please verify your email before logging in.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.orange,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          return;
        }

        String username = user.displayName ?? "User";

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) =>
        //         HomeScreen(username: username, email: user.email ?? ""),
        //   ),
        // );

        Fluttertoast.showToast(
          msg: "Login successful!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Login failed. Please try again.";

      if (e.code == 'user-not-found') {
        errorMessage = "Invalid email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Invalid password.";
      }

      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Login failed: ${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetConst.logoWithText,
                    width: 150,
                  ),
                  SizedBox(height: 20),
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
                    validator: (value) {
                      return Validator.passwordValidator(value);
                    },
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    cursorColor: AppColors.primaryColor,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: AppColors.lightGrey,
                      prefixIcon: Icon(
                        BoxIcons.bx_lock,
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
                      if (state is Authenticated) {
                       context.go('/home');
                        Fluttertoast.showToast(
                          msg: "Login successful!",
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
                                "Login",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            context
                                .read<AuthenticationCubit>()
                                .signInWithEmailAndPassword(
                                  params: SignInParams(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text,
                                    name: '',
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
                        "Don't have an account?  ",
                        style: TextStyle(fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.push('/login/register');
                        },
                        child: Text(
                          "Register here",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
