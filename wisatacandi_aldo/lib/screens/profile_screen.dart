import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisatacandi_aldo/data/candi_data.dart';
import 'package:wisatacandi_aldo/widgets/profile_item_info.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Variabel untuk data pengguna
  bool isSignedIn = true;
  String fullName = "DummyName";
  String userName = "DummyUsername";
  int favoriteCandiCount = 0;


Future<String?> _showEditDialog(BuildContext context, String title, String currentValue) async {
  TextEditingController controller = TextEditingController(text: currentValue);
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: "Masukkan nama baru"),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, controller.text),
          child: Text("Save"),
        ),
      ],
    ),
  );
}


Future<Map<String, String>> retrieveAndDecryptDataFromPrefs(Future<SharedPreferences> prefs,) async {
final sharedPreferences = await prefs;
final encryptedUsername = sharedPreferences.getString('username') ?? '';
final encryptedPassword = sharedPreferences.getString('password') ?? '';
final encryptedfullName = sharedPreferences.getString('name') ?? '';
final keyString = sharedPreferences.getString('key') ?? '';
final ivString = sharedPreferences.getString('iv') ?? '';

final encrypt.Key key = encrypt.Key. fromBase64(keyString);
final iv = encrypt. IV.fromBase64(ivString);

final encrypter = encrypt. Encrypter(encrypt.AES(key));
final decryptedUsername = encrypter.decrypt64(encryptedUsername, iv: iv);
final decryptedPassword = encrypter.decrypt64(encryptedPassword, iv: iv);
final decryptedFullName = encrypter.decrypt64(encryptedfullName, iv: iv);

// Mengembalikan data terdekripsi
return {'username': decryptedUsername, 'password': decryptedPassword, 'name' : decryptedFullName};

}

  // Fungsi untuk membaca data pengguna dari SharedPreferences
 void _loadUserData() async {
  final data = await retrieveAndDecryptDataFromPrefs(SharedPreferences.getInstance());
  setState(() {
    fullName = data['name'] ?? 'Nama belum diatur';
    userName = data['username'] ?? 'Pengguna belum diatur';
  });
}
 void _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var candi in candiList) { // allCandis adalah daftar semua Candi
      bool isFavorite = prefs.getBool('favorite_${candi.name.replaceAll(' ', '_')}') ?? false;
      if (isFavorite) {
        favoriteCandiCount++;
      }
    }
    setState(() {

    });
  }

  // Fungsi untuk Sign In
  void SignIn() {
    Navigator.pushNamed(context, '/signin');
  }

  // Fungsi untuk Sign Out
  void SignOut() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isSignedIn', false);
  // await prefs.setString('name', '');
  // await prefs.setString('username', '');
  // await prefs.setString('password', '');
  setState(() {
    isSignedIn = false;
    fullName = "DummyName";
    userName = "DummyUsername";
    favoriteCandiCount = 0;
  });
  Navigator.pushReplacementNamed(context, '/signin');
}


  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.deepPurple,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // Header Profile
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 200 - 50),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.deepPurple,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('images/placeholder_image.png'),
                          ),
                        ),
                        if (isSignedIn)
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.deepPurple[50],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Divider(color: Colors.deepPurple[100]),
                const SizedBox(height: 4),
                // Informasi Pengguna
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Row(
                        children: [
                          Icon(Icons.lock, color: Colors.amber),
                          SizedBox(width: 8),
                          Text(
                            'Pengguna',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ': $userName',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Divider(color: Colors.deepPurple[100]),
                const SizedBox(height: 4),
                ProfileItemInfo(
                  icon: Icons.person,
                  label: 'Name',
                  value: fullName,
                  iconColor: Colors.blue,
                  showEditIcon: isSignedIn,
                  onEditPressed: () async {
                    final newName = await _showEditDialog(context, 'Edit Name', fullName);
                    if (newName != null && newName.isNotEmpty) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('name',(newName)); // Simpan nama yang dienkripsi
                        setState(() {
                            fullName = newName; // Tampilkan nama baru secara lokal
                           });
                         }
                        },
                ),
                const SizedBox(height: 4),
                Divider(color: Colors.deepPurple[100]),
                const SizedBox(height: 10),
                ProfileItemInfo(
                  icon: Icons.favorite,
                  label: 'Favorite',
                  value: favoriteCandiCount > 0
                      ? '$favoriteCandiCount candi'
                      : 'Belum ada',
                  iconColor: Colors.red,
                ),
                const SizedBox(height: 4),
                Divider(color: Colors.deepPurple[100]),
                const SizedBox(height: 10),
                // Tombol Sign In/Sign Out
                isSignedIn
                    ? TextButton(onPressed: SignOut, child: const Text('Sign Out'))
                    : TextButton(onPressed: SignIn, child: const Text('Sign In')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension on Map<String, String> {
  getInt(String s) {}
}
