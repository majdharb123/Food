import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'ListViewDemo.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}
final TextEditingController emailcontroller = TextEditingController();
final TextEditingController passwordcontroller = TextEditingController();

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Wrapped in Column to align text with TextField
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome To KaLéa Store ♡',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Login To Continue'),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: 340,
                    child: TextField(controller: emailcontroller,
                      decoration: InputDecoration(
                        label: Text('Email'),
                        hintText: 'Enter Your Email ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 340,
                    height: 50,
                    child: TextField(controller: passwordcontroller,
                      decoration: InputDecoration(
                        label: Text('Password'),
                        hintText: 'Enter Your Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      obscureText: true,
                      obscuringCharacter: '#',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 50,
                width: 170,
                child: ElevatedButton(
                  onPressed: () {

                    emailcontroller.clear();
                    passwordcontroller.clear();




                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListViewDemo()),
                      );
                    


                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFAEBD7),
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Submit', style: TextStyle(color: Colors.black)),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No Account? '),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Loginpage()),
                      );
                    },
                    child: Text(
                      'Sign Up Here ',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
