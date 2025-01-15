import 'package:alqaysar_rates/core/config/routes/route_constants.dart';
import 'package:alqaysar_rates/core/helper/extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/resource/colors_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState()=>_LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen>{

  var emailController = TextEditingController();
  var passController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool passwordVisible = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.backgroundColor[0], // Start color
              AppColors.backgroundColor[1], // End color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   const Center(
                     child:  Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                   ),
                    const SizedBox(height: 8),
                    const Center(
                      child: Text(
                        "Enter your email & password",
                        style: TextStyle(
                          fontSize: 18,
                          color:Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: AppColors.primaryContainerColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: AppColors.primaryContainerColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: passController,
                        obscureText:  !passwordVisible, //This will obscure text dynamically,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon:IconButton(
                            icon:Icon(
                            // Based on passwordVisible state choose the icon
                            passwordVisible ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                            //Toggle the state of passwordVisible variable
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                          },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          ),
                          ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                        },
                        child:const Text(
                          "Forget Password?",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child:
                      Container(decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: AppColors.primaryContainerColor),
                          borderRadius: BorderRadius.circular(25),
                      ),
                        child: ElevatedButton(
                          onPressed: () {
                            context.pushNamed(Routes.HomeScreenUserRoute);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                   ],
                ),
                ),
              ),
            ),
          ),
    ),
    );
  }
}
