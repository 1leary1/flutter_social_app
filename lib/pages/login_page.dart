import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/my_button.dart';
import 'package:social_app/components/my_textfield.dart';
import 'package:social_app/helper/helper_functions.dart';

class LoginPage extends StatefulWidget {

  final void Function()? onTap;
  
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //login method
  void login() async {
    // show loading
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);

      if (context.mounted) Navigator.pop(context);
      
    } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessageToUser(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Icon(
                Icons.people,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
        
              const SizedBox(height: 25),
        
              // app name
              const Text(
                "T H R E A D B O A R D",
                style: TextStyle(fontSize: 20),
              ),
        
              const SizedBox(height: 50),
        
              // email textfield
              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: emailController
              ),

              const SizedBox(height: 10),
              
              // password textfield
              MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: passwordController
              ),

              const SizedBox(height: 10),

              // forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  )
                ],
              ),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                text: "Login",
                onTap: login,
              ),

              const SizedBox(height: 25),

              // don't have account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Register Here",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                        ),
                      ),
                  ),
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}
