import 'package:flutter/material.dart';
import 'package:wisatacandi_aldo/models/candi.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.candi});

  //todo 1:deklarasi variable 
  final Candi candi;
  

  @override
  Widget build(BuildContext context) {
    //todo 6 : implement routing ke detail screen
    return Card(
      //todo 2 : tetapkan parameter shape, margin , dan elevation dari cari
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      margin: const EdgeInsets.all(4),
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
             //todo 3 : buat image sebagai anak dari column
             Expanded(
              // todo 7: implementasi hero animation
               child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                 child: Image.asset(candi.imageAsset,
                 width: double.infinity,
                 fit: BoxFit.cover,
                 ),
               ),
             ),
             //todo 4 : buat text sebagai anak dari column
             Padding(
               padding: const EdgeInsets.only(left: 16,top: 8),
               child: Text(
                  candi.name,
                  style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
               ),
             ),
             //todo 5 : buat text sebagai anak dari column
             Padding(
               padding: const EdgeInsets.only(left: 16,bottom: 8),
               child: Text(candi.type,
                  style: const TextStyle(fontSize: 12),
               ),
             )
      

        ],
      ),
   

    );
  }
}