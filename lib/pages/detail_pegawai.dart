
import 'package:flutter/material.dart';
import 'package:flutter_pegawai/pages/list_pegawai.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPegawai extends StatelessWidget {
  final item;

  DetailPegawai(this.item);

  Future<void> delete(context) async {
    http.Response res = await http.post(
      Uri.parse(
          "http://192.168.20.189/server_employee/deleteEmployee.php"),
      body: {
        "id": this.item['id'],
      },
    );

    Map data = jsonDecode(res.body);
    if (data['is_success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message']))
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => ListPegawai2()));
    } else {
      print("Gagal");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text.rich(data['message'])),
      );
    }
  }



void deletePegawai(context) async {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Hapus Pegawai?"),
          scrollable: true,
          content: Column(
            children: [
              MaterialButton(
                child: Text("YA"),
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () {
                  //delete
                  delete(context);


                },
              ),
              MaterialButton(
                child: Text("TIDAK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      });
}

//construct ada dua tipe : ada yg pakai kurung kurawal ada yag tidak

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Detail Pegawai"),
      actions: [
        IconButton(
          onPressed: () {
            deletePegawai(context);
          },
          icon: Icon(
            Icons.delete,
          ),
        )
      ],
    ),
    body: Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            "Nama : ${item['nama'] ?? "-"}",
            style: TextStyle(fontSize: 24),
          ),
          Text(
            item['posisi'] ?? "-",
            style: TextStyle(fontSize: 24),
          ),
          Text(
            item['gaji'] ?? "-",
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    ),
  );
}}
