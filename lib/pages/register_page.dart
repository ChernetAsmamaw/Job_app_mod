import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/my_textfield.dart';
import '../components/my_button.dart';
import '../components/my_signup_button.dart';
import 'package:job_application_portal/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Sign User in function
  void signUserUp() async {
    // Loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Try to sign up using email and password
    try {
      // Confirm that the passwords used are the same
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        // Show error message | Passwords don't match
        showErrorMessage("Passwords don'\t match!");
      }
      // Remove the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Remove the loading circle
      Navigator.pop(context);

      print('Error is ---: $e');
      showErrorMessage(e.code);
    }
  }

  // Error message popup
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey[500],
          title: Center(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // Logo
                Icon(
                  Icons.signpost_rounded,
                  size: 50,
                  color: Colors.blueGrey[800],
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Welcome to JAP! Let\'s get you started.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                // Text field for Email

                MyTextField(
                  controller: emailController,
                  hintText: "Email Address",
                  obscurText: false,
                ),

                const SizedBox(height: 15),

                // Text field for password
                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscurText: true,
                ),

                const SizedBox(height: 15),

                // Text field for confirm password
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  obscurText: true,
                ),

                const SizedBox(height: 15),

                // Sign Up button

                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp,
                ),

                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "or",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 5),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButtonWithImg(
                          onTap: () => AuthService().signInWithGoogle(),
                          buttonName: "Sign Up with Google",
                          imagePath: "lib/images/google_logo.webp"),
                      SizedBox(height: 16.0),
                      MyButtonWithImg(
                          onTap: () {},
                          buttonName: "Sign Up with Apple",
                          imagePath: "lib/images/apple_logo.webp"),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      Text(
                        "Already have an accout?",
                        style: TextStyle(color: Colors.blueGrey[700]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[800],
                            ),
                          ),
                        ),
                      )
                    ],
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
