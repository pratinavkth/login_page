import 'package:flutter/material.dart';
import 'package:login_page/login/screens/login.dart';
import 'package:login_page/signup/service/signup_service.dart';
// import 'package:flutter/widgets.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController comfirmpasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthSignupService authService = AuthSignupService();

  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    comfirmpasswordController.dispose();
  }

  void SignupUser(){
    authService.signupUser(
      context: context, 
      email: emailController.text, 
      password: passwordController.text, 
      comfirmPassword: comfirmpasswordController.text
      );
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenheight * 0.1),
                child: const Text(
                  "Welcome to our App",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenheight * 0.1),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: screenheight * 0.1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.1),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Email";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: screenheight * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.1),
                child: TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: screenheight * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.1),
                child: TextFormField(
                  controller: comfirmpasswordController,
                  decoration: const InputDecoration(
                    hintText: "Comfirm Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter comfirm password";
                    }
                    if (value != passwordController.text) {
                      return "Password does not match";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenheight * 0.1),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Perform signup action
                      SignupUser();
                   
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF000000),
                    minimumSize: Size(screenwidth * 0.9, 50),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: screenheight*0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
               
                children: [
                  const Text("Alredy have an account?"),
                  TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
                    },
                    child: const Text("Sign In"),
                  )
                ], 
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
