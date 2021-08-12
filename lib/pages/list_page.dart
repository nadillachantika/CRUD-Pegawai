import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListPegawai extends StatefulWidget {
  @override
  _ListPegawaiState createState() => _ListPegawaiState();
}

class _ListPegawaiState extends State<ListPegawai> {

  bool loading = false;
  List _post = [];

  Future getDataPegawai() async {
    setState(() {
      loading = true;
    });

    http.Response res = await http.get(
        Uri.parse("http://192.168.20.189/server_employee/getEmployee.php"));

    setState(() {
      loading = false;
    });

    Map data = jsonDecode(res.body);
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataPegawai();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Pegawai',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightGreen,
      ),
      body: ListView.builder(
        itemCount: _post.length,
        itemBuilder: (context,index){
          return ListTile(
            leading:  Container(
              width: 100,
              height: 100,
              padding: EdgeInsets.all(10),
              child: Card(

                child: InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed('detailPegawai');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('${_post[index]['nama']}'),
                            Text('${_post[index]['posisi']}'),
                            Text('${_post[index]['gaji']}')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ) ,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed('addPegawai');

        },
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.lightGreen,
      ),


    );
  }
}