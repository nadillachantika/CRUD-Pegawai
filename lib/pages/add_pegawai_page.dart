import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pegawai/main.dart';
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
      home: AddPegawaiPage(),
    );
  }
}

class AddPegawaiPage extends StatefulWidget {
  @override
  _AddPegawaiPageState createState() => _AddPegawaiPageState();
}

class _AddPegawaiPageState extends State<AddPegawaiPage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController posisiController = TextEditingController();
  TextEditingController gajiController = TextEditingController();
  bool loading = false;

  // method addData
  Future<void> addData() async {
    setState(() {
      loading= true;
    });
    await Future.delayed(Duration(seconds: 2));
    http.Response res = await http.post(
      Uri.parse("http://192.168.20.189/server_employee/addEmployee.php"),
      body: {
        "nama": namaController.text,
        "posisi": posisiController.text,
        "gaji": gajiController.text,
      },
    );
    setState(() {
      loading= false;
    });
    //ubah data ke String

    //int result = int.parse("10");

    //tipe data map hampisr sama degan json di dalam flutter

    Map data = jsonDecode(res.body);
    if(data['is_success']==true){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message']))
      );

    }else{
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
            "Input Pegawai",
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
                              child: Text("Tambah baru"),
                              height: 50,
                              color: Colors.blue,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              onPressed: () {
                                addData();
                              },

                            ),


                          )
                      )],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: MaterialButton(
                          height: 50,
                          child: Text("List"),
                          color: Colors.blue,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ListPegawai2()));

                          },
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ]),
      ),
    );
  }
}
