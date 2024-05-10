import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tugas1_0080/views/home.dart';

class TambahData extends StatefulWidget {
  @override
  _TambahDataState createState() => _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  TextEditingController namaprodukController = TextEditingController();
  TextEditingController satuanController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController hargajualController = TextEditingController();

  void tambahData() {
    var url = Uri.parse("https://660aac33ccda4cbc75db7cd7.mockapi.io/produk");
    http.post(url, body: {
      "nama_produk": namaprodukController.text,
      "satuan": satuanController.text,
      "jumlah": jumlahController.text,
      "harga_jual": hargajualController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Data Produk (Api)"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: namaprodukController,
              decoration: const InputDecoration(
                labelText: "Nama Produk",
              ),
            ),
            TextFormField(
              controller: satuanController,
              decoration: const InputDecoration(
                labelText: "Satuan",
              ),
            ),
            TextFormField(
              controller: jumlahController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Jumlah",
              ),
            ),
            TextFormField(
              controller: hargajualController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Harga Jual",
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                tambahData();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
