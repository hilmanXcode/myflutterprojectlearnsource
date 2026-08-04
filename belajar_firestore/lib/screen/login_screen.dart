
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // Title login
              SizedBox(height: 15),
              Text(
                "Todolist with Firestore",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              // username & password field
              SizedBox(height: 15),
              Form(
                child: Column(
                  children: [
                    
                    // Username field
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: "Masukkan username anda",
                        labelText: "Username"
                      ),
                    ),

                    SizedBox(height: 15,),

                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.password),
                        hintText: "Masukkan password anda",
                        labelText: "Password",
                        suffixIcon: IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.visibility)
                        )
                      ),
                    ),

                    SizedBox(height: 15,),

                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: (){},
                        child: Text("Submit"),
                      ),
                    )

                  ],
              )),
        
            ],
          ),
        ),
      ),
    );
  }
}