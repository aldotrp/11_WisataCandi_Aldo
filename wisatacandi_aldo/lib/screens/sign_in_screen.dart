import'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //todo : deklarasi variable
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  String _errorText = '';

  bool _isSignedIn = false;

  bool _obscurePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //todo : pasang app bar
        appBar: AppBar(
          title: const Text('Sign In'),
        ),
        //tode : pasang body
        body:  Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                child: Column(
                  //todo : atur main axisalignment dan cross
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //todo : pasang textformfield nama pengguna
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: "Nama Pengguna",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    //todo : pasang textformfield kata sandi
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: "Kata Sandi",
                        errorText: _errorText.isNotEmpty ? _errorText : null,
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            _obscurePassword =!_obscurePassword;
                          });
                        }, icon: Icon(_obscurePassword 
                         ?Icons.visibility_off 
                         : Icons.visibility),
                         ),
                      ),
                      obscureText: _obscurePassword,
                    ),
                    //todo : pasang elevatedbutton signin
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: (){}, child: const Text('Sign In'),
                      ),
                    //todo : pasang text button Sign Up
                    const SizedBox(height: 20,),
                    // TextButton(
                    //   onPressed: (){}, child: const Text('Belum punya akun? Daftar disini.')
                    // ),
                    RichText(text: 
                    TextSpan(
                      text: 'Belum punya akun?', 
                      style: const TextStyle( 
                        fontSize: 16, color: Colors.deepPurple
                        ),
                        children: [
                        TextSpan(text: ' Daftar disini.', style: const TextStyle( 
                          fontSize: 16, color: Colors.blue, 
                          decoration: TextDecoration.underline
                        ),
                        recognizer: TapGestureRecognizer()
                        ..onTap = (){}
                        )
                        ]
              
                        ),
                        ),
              
                    
              
                  ],
                ),
              ),
            ),
          )
        ),
    );
  }
}