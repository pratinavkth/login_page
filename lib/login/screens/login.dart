
import 'package:flutter/material.dart';

class Login extends StatefulWidget{
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState()=> _LoginState();

}

class _LoginState extends State<Login>{
  @override
  Widget build(BuildContext context){
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(
                top: screenheight*0.2),
                child: const Text("Welcome to our App",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
                ),
            ),
            SizedBox(height: screenheight*0.2,),
            // SizedBox(height: screenheight*0.15,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenwidth*0.1),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Please enter your email";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: screenheight*0.01,),
            
            Padding(padding: EdgeInsets.symmetric(horizontal: screenwidth*0.1),
            child: TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: (value){
                if(value==null || value.isEmpty){
                  return "Please enter your password";
                }
                return null;
              },
            ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenheight*0.01),
              child: ElevatedButton(
                onPressed: (){
                  if (_formKey.currentState!.validate()) {
                      // Perform signup action
                    }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF000000),
                  minimumSize: Size(screenwidth*0.9, 50),
                ),
                child: const Text('Sign In',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFFFFFFFF),
                ),
                ),
            ),
            ),
          ],
          ),
        ),
      ),
    );
  }
}