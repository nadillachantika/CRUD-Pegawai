
import 'package:flutter/material.dart';
import 'package:flutter_pegawai/pages/add_pegawai_page.dart';
import 'package:flutter_pegawai/pages/detail_pegawai.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

import '../main.dart';

class ListPegawai2 extends StatefulWidget {
  @override
  _ListPegawai2State createState() => _ListPegawai2State();
}

class _ListPegawai2State extends State<ListPegawai2> {

  bool loading = false;

  List? pegawai;
  // method addData
  Future<void> getData() async {
    setState(() {
      loading = true;
    });
    http.Response res = await http.get(
        Uri.parse(
            "http://server-pegawai.indonesiafintechforum.org/getPegawai.php"));
    setState(() {
      loading = false;
    });

    Map data = jsonDecode(res.body);

    if (data['is_success'] == true) {
      pegawai = data['data'];
    }
  }
  @override
  void initState() {

    getData();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //ketika page halamannya ditutup
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Pegawai"),
        centerTitle: true,
      ),
      body: loading ? Center(child: CircularProgressIndicator(),):

        ListView.builder(
          itemCount: pegawai?.length ?? 0,
          itemBuilder: (context,index){
            var item = pegawai?[index];

            return GestureDetector(
              onTap: (){
                print(item);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                  return DetailPegawai(item);
                }));
              },
              child: Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black26,blurRadius: 18),
    ],
    borderRadius: BorderRadius.circular(4),
    ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: Text("${index+1} ${item['nama']}", style: TextStyle(fontSize: 18),)),
                  IconButton(onPressed: (){
                    Navigator.push(
                        context,MaterialPageRoute( builder:(context)=> HomePage(item:item)));
                  }, icon: Icon(Icons.edit))
                ],
              ),
              ),
            );
    }
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPegawaiPage()));

        },
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.blue,
      ),

    );

  }
}
