import 'package:flutter/material.dart';
import 'package:wisatacandi_aldo/widgets/profile_item_info.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // TODO: variable
  bool isSignedIn = true;
  String fullName = "DummyName";
  String userName = "DummyUsername";
  int favoriteCandiCount = 0;

  //todo implement fungsi signin
  void SignIn() {
    setState(() {
      isSignedIn = !isSignedIn;
    });
  }
  //todo implement fungsi signout
  void SignOut() {
    setState(() {
      isSignedIn = !isSignedIn; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
            Container(
              height: 200,width: double.infinity,color: Colors.deepPurple,
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  //todo: make bagian profile header
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
                              shape: BoxShape.circle
                            ),
                              child: const CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage('images/placeholder_image.png'),
                              ),
                          ),
                          if(isSignedIn) IconButton(onPressed: (){}, icon: Icon(
                            Icons.camera_alt,
                            color: Colors.deepPurple[50],
                          )
                          )
                       ],
                      ),
                    ),
                  ),
                  //todo: make bagian profile content
                  const SizedBox(height: 20,),
                  Divider(color: Colors.deepPurple[100],),
                  const SizedBox(height: 4,),
                  Row(
                    children: [
                    SizedBox(width: MediaQuery.of(context).size.width / 3,
                    child: const Row(
                      children: [
                        Icon(Icons.lock, color: Colors.amber,),
                        SizedBox(width: 8,),
                        Text('Pengguna',style: TextStyle(
                          fontSize: 18,fontWeight: FontWeight.bold,),
                          )
                      ],
                    ),
                    ),
                    Expanded(
                      child: Text(':$userName', style: const TextStyle(
                        fontSize: 18,
                      ),
                      ),
                    ),
                  ]
                  ),
                  const SizedBox(height: 4,),
                  Divider(color : Colors.deepPurple[100],),
                  const SizedBox(height: 4,),
                  // Row(children: [
                  //   SizedBox(width: MediaQuery.of(context).size.width / 3,
                  //   child: const Row(
                  //     children: [
                  //       Icon(Icons.person, color: Colors.blue,),
                  //       SizedBox(width: 8,),
                  //       Text('Nama',style: TextStyle(
                  //         fontSize: 18,fontWeight: FontWeight.bold,),
                  //         )
                  //     ],
                  //   ),
                  //   ),
                  //   Expanded(
                  //     child: Text(':$fullName', style: const TextStyle(
                  //       fontSize: 18,
                  //     ),
                  //     ),
                  //   ),
                  //   if(isSignedIn) const Icon(Icons.edit),

                  //],
                  //),
                  ProfileItemInfo(
                    icon: Icons.person,
                    label: 'Name',
                    value: fullName,
                    iconColor: Colors.blue,
                    showEditIcon: isSignedIn,
                    onEditPressed: () {
                      debugPrint('Icon Edit Ditekan');
                    },
                  ),
                  const SizedBox(height: 4,),
                  Divider(color: Colors.deepPurple[100],),
                  const SizedBox(height: 10,),
                  ProfileItemInfo(
                    icon: Icons.favorite,
                    label: 'Favorite ',
                    value: favoriteCandiCount >0 ? '$favoriteCandiCount candi' : '',
                    iconColor: Colors.red,
                  ),
                  //todo: make bagian profile footer
                  const SizedBox(height: 4,),
                  Divider(color: Colors.deepPurple[100],),
                  const SizedBox(height: 10,),
                  isSignedIn 
                  ? TextButton(onPressed: SignOut, child: Text('Sign Out'))
                  : TextButton(onPressed: SignIn, child: Text('Sign In')),
                  

                ],
              )
              ),
        ],
    ),
    );
  }
}