
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect_couple/AuthenticationScreens/registration_screen.dart';
import 'package:perfect_couple/Controllers/authentication_controller.dart';
import 'package:perfect_couple/Widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool showProgressBar = false;
  var controllerAuth = AuthenticationController.authController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100,),
              Image.asset('images/logo.jpg', width: 200,),
              const Text("Welcome", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.pink,),),
              const SizedBox(height: 10,),
              const Text('Login now, To find your perfect match', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, fontStyle: FontStyle.italic,), textAlign: TextAlign.center,),
              const SizedBox(height: 20,),
              /* email */
              CustomTextField(
                editingController: emailTextEditingController,
                labelText: "Email",
                iconData: Icons.email_outlined,
                isObscure: false,
              ),
              const SizedBox(height: 20,),
              /* password */
              CustomTextField(
                editingController: passwordTextEditingController,
                labelText: "Password",
                iconData: Icons.lock_clock_outlined,
                isObscure: true,
              ),
              const SizedBox(height: 20,),
              /* login button */
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 36,
                decoration: const BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.all(Radius.circular(12,),),
                ),
                child: InkWell(
                  onTap: ()async{
                    if(emailTextEditingController.text.trim().isNotEmpty && passwordTextEditingController.text.trim().isNotEmpty){
                      setState(() {
                        showProgressBar = true;
                      });
                      await controllerAuth.loginUser(emailTextEditingController.text.trim(), passwordTextEditingController.text.trim(),);
                      setState(() {
                        showProgressBar = false;
                      });
                    }
                    else{
                      Get.snackbar("Email/Password in missing", "Please fill all field");
                    }
                  },
                  child: const Center(child: Text('Login', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold,),),),
                ),
              ),
              const SizedBox(height: 16,),
              /* don't have an account */
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? ", style: TextStyle(fontSize: 16, color: Colors.grey,),),
                  InkWell(
                    onTap: ()=> Get.to(()=>const RegistrationScreen(),),
                    child: const Text("Register here", style: TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold,),),
                  ),
                ],
              ),
              const SizedBox(height: 16,),
              /* progressBar */
              showProgressBar==true ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),) : Container(),
              const SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}
