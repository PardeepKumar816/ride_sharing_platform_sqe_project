

import 'package:flutter/material.dart';
import 'package:ride_sharing_platform/view/sections/ride-booking/ride_booking_mobile.dart';

import '../../../model/authentication/auth.dart';

class LoginScreenMobile extends StatefulWidget {
  const LoginScreenMobile({Key? key}) : super(key: key);

  @override
  State<LoginScreenMobile> createState() => _LoginScreenMobileState();
}

class _LoginScreenMobileState extends State<LoginScreenMobile> {

  bool _discoverPassword = false;
  String _email = "";
  String _password = "";
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool _signUp = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading ? const Center(child: CircularProgressIndicator(),) : Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: AppBar(
        centerTitle: true,
        title:  Text(_signUp ? "Sign Up" :"Login"),
      ),
      body: Form(
        key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/taxi.png",width: 200,height: 200,),
                Center(
                  child: Container(
                    padding:const EdgeInsets.symmetric(horizontal: 16),
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 48,
                    decoration:const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(24))
                    ),
                    child: TextFormField(
                      decoration:const InputDecoration(
                        hintText: "Email",
                        border: InputBorder.none
                      ),
                      onChanged: (value){
                        _email = value;
                      },
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Please input Email";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16,),
                Container(
                  padding:const EdgeInsets.only(left: 16,right: 10),
                  width: MediaQuery.of(context).size.width*0.8,
                  height: 48,
                  decoration:const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(24))
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: TextFormField(
                          obscureText: !_discoverPassword,
                          decoration:const InputDecoration(
                              hintText: "Password",
                              border: InputBorder.none
                          ),
                          onChanged: (value){
                            _password = value;
                          },
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return "Please input Password";
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(onPressed: (){
                        setState(() {
                          _discoverPassword = !_discoverPassword;
                        });
                      }, icon: Icon(_discoverPassword ? Icons.panorama_fish_eye : Icons.remove_red_eye_rounded))
                    ],
                  ),
                ),
                const SizedBox(height: 16,),
                ElevatedButton(onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    setState(() {
                      _isLoading = true;
                    });
                    if(_signUp){
                      await  registerWithUsernameAndPassword(_email,_password).then((value) {
                        _isLoading = false;
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const RideBookingMobile()));
                      });
                    }else{
                  await  loginWithUsernameAndPassword(_email,_password).then((value) {
                        _isLoading = false;
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const RideBookingMobile()));
                      });
                    }
                  }
                }, child:  Text(_signUp ? "Sign Up" :"Login")),
                const SizedBox(height: 16,),
                if(!_signUp)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   const Text("Don't have account?",style: TextStyle(color: Colors.white),),
                    TextButton(onPressed: (){
                      setState(() {
                        _signUp = !_signUp;
                      });
                    }, child: const Text("Sign up")),
                  ],
                ),
                if(_signUp)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have account?",style: TextStyle(color: Colors.white),),
                      TextButton(onPressed: (){
                        setState(() {
                          _signUp = !_signUp;
                        });
                      }, child: const Text("Login")),
                    ],
                  )
              ],
            ),
          )),
    );
  }
}
