import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}
final TextEditingController emailcontroller = TextEditingController();
final TextEditingController passwordcontroller = TextEditingController();
final TextEditingController confirmpasscontroller = TextEditingController();


class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFAEBD7),
        foregroundColor: Colors.black,
        title: Text('Login'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // goes back to previous page
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // centers vertically
            crossAxisAlignment: CrossAxisAlignment.center, // centers horizontally
            children: [
              Text(
                'Sign Up To Create An Account',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
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
              SizedBox(height: 10),
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
                  
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 340,
                height: 50,
                child: TextField(controller: confirmpasscontroller,
                  decoration: InputDecoration(
                    label: Text('Confirm Password'),
                    hintText: 'Enter Your Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                 
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 50,
                width: 170,
                child: ElevatedButton(
                  onPressed: () {
                    // Show notification
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Account successfully created!'),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.green,
                      ),
                    );



emailcontroller.clear();
passwordcontroller.clear();
confirmpasscontroller.clear();
Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFAEBD7),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Submit',style: TextStyle(color: Colors.black) ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
