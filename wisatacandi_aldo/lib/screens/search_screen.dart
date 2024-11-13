import 'package:flutter/material.dart';
import 'package:wisatacandi_aldo/data/candi_data.dart';
import 'package:wisatacandi_aldo/models/candi.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //todo 1 : Deklarasi Variabel
  List<Candi> _filteredCandis = candiList;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController(); // TextEditingController

  @override


  Widget build(BuildContext context) {
    return Scaffold(
      //todo 2 : Buat app bar
      appBar: AppBar(title: Text('Pencarian Candi'),),
      //todo 3 : Buat body berupa column
      body: Column(
        children: [
      //todo 4 : Buat textfield pencarian anak dari column
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),color: Colors.deepPurple[50],
            ),
            child: const TextField(
              autofocus: false,
              //todo 6 : implementasi fitur pencarian
              decoration: InputDecoration(
                hintText: 'Cari Candi...',
                prefixIcon: Icon(Icons.search),
                // todo 7 : implementasi pengosongan input
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 12.0),
              ),
            ),
          ),
        ),
      //todo 5 : Buat listview yang menampilkan data anak yang ditemukan
      Expanded(
        child: ListView.builder(
          itemCount: _filteredCandis.length,
          itemBuilder: (context, index) {
            final candi = _filteredCandis[index];
            //implementasi gesturedetector dan hero animation
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        candi.imageAsset,
                        fit: BoxFit.cover,
                        ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(candi.name, style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                            ),
                          ),
                        const SizedBox(height: 4,),
                        Text(candi.location,)
                      ],
                    ),
                  )
                ]
              ),
              );
          },
        ),
      )
        ],
      ),
    );
  }
}