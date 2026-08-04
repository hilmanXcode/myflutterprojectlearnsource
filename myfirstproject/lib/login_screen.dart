

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // deklarasi 
  late TextEditingController emailController;
  late TextEditingController passwordController;
  var isObscurePassword = true;

  @override
  void initState() {
    super.initState();
    
    // inisialisasi
    emailController = TextEditingController();
    passwordController = TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(height: 100),
            Text(
              "Hi!",
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 26
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Welcome to ID-Networkers",
              style: TextStyle(
                fontSize: 15
              ),
            ),
            SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email"),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: 
                    InputDecoration(
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 1),
                        borderRadius: BorderRadius.circular(8)
                      )
                    )
                ),

                SizedBox(height: 15),

                Text("Password"),
                
                TextField(
                  controller: passwordController,
                  obscureText: isObscurePassword,
                  decoration: 
                    InputDecoration(
                      hintText: "Masukkan password",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 1),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            isObscurePassword = !isObscurePassword;
                          });
                        },
                        icon: Icon(
                          isObscurePassword ? 
                          Icons.visibility_off : Icons.visibility
                          )
                      )
                    )
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                onPressed: actionLogin,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.orange
                ),
                child: Text("Login"),
              ),
            ),

            SizedBox(height: 10),
            Text("or continue with"),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 15,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.email, size: 40),
                Icon(Icons.facebook, size: 40),
                Icon(Icons.apple, size: 40),
              ],
            )

          ],
        ),
        ),
      ) 
    );
  }

  void actionLogin(){
    var email = emailController.text.trim();
    var password = passwordController.text.trim();

    if(email.isEmpty || password.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email & Password tidak boleh kosong"),
          backgroundColor: Colors.orange,
        )
      );
    } else {
      debugPrint("Email $email, Password: $password");
    }
  }
}