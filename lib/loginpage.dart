// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mental_hacks/homepage.dart';
import 'package:mental_hacks/register.dart';

import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool changebutton = false;
  final _formkey = GlobalKey<FormState>();

  movetohome(BuildContext) async {
    {
      if (_formkey.currentState!.validate()) {
        setState(() {
          changebutton = true;
        });
        await Future.delayed(Duration(seconds: 1));
        await Navigator.push(context,MaterialPageRoute(builder: (context) => const homepage()));
        setState(() {
          changebutton = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
          color: Color.fromARGB(255, 92, 242, 229),
          child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              
                 Text("Therapy Sessions ",style: TextStyle(
    fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white, 
                ),),
                Text("By ",style: TextStyle(
    fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white, 
                ),),
                Text("Carl Rogers ",style: TextStyle(
    fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white, 
                ),),
              //Image.asset("assets/images/class.png", fit: BoxFit.cover),
              SizedBox(
                height: 60.0,
              ),
              Text(
                "Welcome $name",
                style: TextStyle(
                  fontSize: 30,
                  color:Colors.white,fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
                child: Column(children: [
                  TextFormField(
                  
                    decoration: InputDecoration(
                      //filled: true,
                      //fillColor: Colors.white,
                      hintText: ("Username"),
                      hintStyle: TextStyle(color: Colors.white),
                      labelText: ("Enter Username"),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    validator: (value){
                      if (value==null || value.isEmpty) {
                        return "Username cannot be empty";
                      }  else {
                        return null;
                      }
                    },
                        
                    onChanged: (value) {
                      name = value;
                      setState(() {});
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: ("Password"),
                      hintStyle: TextStyle(color: Colors.white),
                      labelText: ("Enter Password"),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    validator: (value) {
                      if (value==null || value.isEmpty) {
                        return "Password cannot be empty";
                      } else if (value.length < 6) {
                        return "Password length cannot be less than 6";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Material(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(changebutton ? 50 : 8),
                    child: InkWell(
                      splashColor: Color.fromARGB(255, 236, 235, 233),
                      onTap: () => movetohome(BuildContext),
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        alignment: Alignment.center,
                        width: changebutton ? 50 : 150,
                        height: 40,
                        child: changebutton
                            ? Icon(Icons.done, color: Colors.white)
                            : Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0,),
                   Material(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(changebutton ? 50 : 8),
                    child: InkWell(
                      
                      onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) =>  RegisterPage()));},
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        alignment: Alignment.center,
                        width:  150,
                        height: 40,
                        child: changebutton
                            ? Icon(Icons.done, color: Colors.white)
                            : Text(
                                "Register",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
