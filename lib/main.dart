import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pegawai/pages/list_page.dart';
import 'package:flutter_pegawai/pages/list_pegawai.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListPegawai2(),
    );
  }
}

class HomePage extends StatefulWidget {
  final item;

  const HomePage({this.item});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController posisiController = TextEditingController();
  TextEditingController gajiController = TextEditingController();
  bool loading = false;

  // method addData
  Future<void> addData() async {
    setState(() {
      loading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    http.Response res = await http.post(
      Uri.parse(
          "http://server-pegawai.indonesiafintechforum.org/addPegawai.php"),
      body: {
        "namaPegawai": namaController.text,
        "posisiPegawai": posisiController.text,
        "gajiPegawai": gajiController.text,
      },
    );
    setState(() {
      loading = false;
    });
    //ubah data ke String

    //int result = int.parse("10");

    //tipe data map hampisr sama degan json di dalam flutter

    Map data = jsonDecode(res.body);
    if (data['is_success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message']))
      );
    } else {
      print("Gagal");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text.rich(data['message'])),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.item != null) {
      namaController = TextEditingController(text: widget.item['nama']);
      posisiController = TextEditingController(text: widget.item['posisi']);
      gajiController = TextEditingController(text: widget.item['gaji']);
    }
    super.initState();
  }

  Future<void> editData() async {
    setState(() {
      loading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    http.Response res = await http.post(
      Uri.parse(
          "http://server-pegawai.indonesiafintechforum.org/editPegawai.php"),
      body: {
        "idPegawai": widget.item['id'],
        "namaPegawai": namaController.text,
        "posisiPegawai": posisiController.text,
        "gajiPegawai": gajiController.text,
      },
    );
    setState(() {
      loading = false;
    });
    Map data = jsonDecode(res.body);
    if (data['is_success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message']))
      );
    } else {
      print("Gagal");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text.rich(data['message'])),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Pegawai"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          //Nama Pegawai
          SizedBox(height: 12),
          Text(
            "Update Pegawai",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          Container(
            // color: Colors.yellow,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: TextFormField(
              controller: namaController,
              decoration: InputDecoration(
                hintText: "Nama Pegawai",
                labelText: "Nama Pegawai",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: TextFormField(
              controller: posisiController,
              decoration: InputDecoration(
                hintText: "Posisi Pegawai",
                labelText: "Posisi Pegawai",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: TextFormField(
              controller: gajiController,
              decoration: InputDecoration(
                hintText: "Gaji Pegawai",
                labelText: "Gaji Pegawai",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),


          Container(
          //  color: Colors.yellow,
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            //   margin: EdgeInsets.all(40),
              // height: 60,
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 60,
                          child:
                          loading? Center(child: CircularProgressIndicator(),):
                        MaterialButton(
                          child: Text(widget.item==null?"Tambah Baru": "Edit Data"),
                          height: 50,
                          color: Colors.blue,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          onPressed: () {
                            if(widget.item==null){
                              addData();
                            }else{
                              editData();
                            }
                          },
                        ),
                      )
                      )],
                  ),
                  // SizedBox(height: 12),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   // crossAxisAlignment: CrossAxisAlignment.end,
                  //   children: [
                  //     Container(
                  //       child: MaterialButton(
                  //         height: 50,
                  //         child: Text("Tambah baru"),
                  //         color: Colors.blue,
                  //         textColor: Colors.white,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(100),
                  //         ),
                  //         onPressed: () {},
                  //       ),
                  //     )
                  //   ],
                  // ),
                ],
              )),
        ]),
      ),
    );
  }
}
