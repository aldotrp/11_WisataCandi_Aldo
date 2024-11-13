import 'package:flutter/material.dart';
import 'package:wisatacandi_aldo/data/candi_data.dart';
import 'package:wisatacandi_aldo/models/candi.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //todo 1 : Buat appbar dengan judul wisata candi
      appBar: AppBar(title: const Text('Wisata Candi'),),
      //todo 2 : Buat body dengan gridview builder
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        itemCount: candiList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
        itemBuilder: (context, index) {
          Candi candi = candiList[index];
        },
        ),
      //todo 3 : Buat Itemcard sebagai return value dari gridview builder  
    );
  }
}