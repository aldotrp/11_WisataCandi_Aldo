import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Deklarasi variabel
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorText = '';
  bool _isSignedIn = false;
  bool _obscurePassword = true; // Perbaiki default value ke true

Future<Map<String, String>> retrieveAndDecryptDataFromPrefs(Future<SharedPreferences> prefs,) async {
final sharedPreferences = await prefs;
final encryptedUsername = sharedPreferences.getString('username') ?? '';
final encryptedPassword = sharedPreferences.getString('password') ?? '';
final keyString = sharedPreferences.getString('key') ?? '';
final ivString = sharedPreferences.getString('iv') ?? '';

final encrypt.Key key = encrypt.Key. fromBase64(keyString);
final iv = encrypt. IV.fromBase64(ivString);

final encrypter = encrypt. Encrypter(encrypt.AES(key));
final decryptedUsername =
encrypter.decrypt64(encryptedUsername, iv: iv);
final decryptedPassword =
encrypter.decrypt64(encryptedPassword, iv: iv);

// Mengembalikan data terdekripsi
return {'username': decryptedUsername, 'password': decryptedPassword};

}



  void _signIn() async {
    try {
      final Future<SharedPreferences> prefsFuture = SharedPreferences.getInstance();

      final String username = _usernameController.text;
      final String password = _passwordController.text;
      print('Sign in attempt');

      if (username.isNotEmpty && password.isNotEmpty) {
        final SharedPreferences prefs = await prefsFuture;
        final data = await retrieveAndDecryptDataFromPrefs(prefsFuture);
        if (data.isNotEmpty) {
          final decryptedUsername = data['username'];
          final decryptedPassword = data['password'];

          if (username == decryptedUsername && password == decryptedPassword) {
            _errorText = '';
            _isSignedIn = true;
            prefs.setBool('isSignedIn', true);
            //Pemanggilan untuk menghapus semua halaman dalam tumpukan navigasi
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            });
            //Sign in berhasil, navigasi ke layar utama
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/homescreen');
            });
            print("Sign in succeeded");
          } else {
            print('Username or password is incorrect');
          }
        } else {
          print('No stored credentials found');
        }
      } else {
        print('Username and password cannot be empty');
        // Tambahkan pean untuk kasus ketika username atau password kosong
      }
    } catch (e) {
      print('An error occured: $e');//+
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Input Nama Pengguna
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: "Nama Pengguna",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Input Kata Sandi
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Kata Sandi",
                      errorText: _errorText.isNotEmpty ? _errorText : null,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    obscureText: _obscurePassword,
                  ),
                  const SizedBox(height: 20),
                  // Tombol Sign In
                  ElevatedButton(
                    onPressed: _signIn, // Panggil fungsi _signin
                    child: const Text('Sign In'),
                  ),
                  const SizedBox(height: 20),
                  // Tombol Sign Up
                  RichText(
                    text: TextSpan(
                      text: 'Belum punya akun?',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurple,
                      ),
                      children: [
                        TextSpan(
                          text: ' Daftar disini.',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/signup');
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
