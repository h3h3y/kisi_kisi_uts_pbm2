import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tugas1_0080/views/home.dart';

class EditData extends StatefulWidget {
  final List? list;
  final int? index;

  const EditData({this.list, this.index});

  @override
  EditDataState createState() => EditDataState();
}

class EditDataState extends State<EditData> {
  TextEditingController namaprodukController = TextEditingController();
  TextEditingController satuanController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController hargajualController = TextEditingController();

  void editData(String id) async {
    var url =
        Uri.parse("https://660aac33ccda4cbc75db7cd7.mockapi.io/produk/$id");
    await http.put(
      url,
      body: {
        "nama_produk": namaprodukController.text,
        "satuan": satuanController.text,
        "jumlah": jumlahController.text,
        "harga_jual": hargajualController.text,
      },
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Home()),
      (Route<dynamic> route) => false,
    );
  }

  void deleteData(String id) {
    var url =
        Uri.parse("https://660aac33ccda4cbc75db7cd7.mockapi.io/produk/$id");
    http.delete(url, body: {'id': widget.list![widget.index!]['id']});
  }

  void konfirmasi() {
    AlertDialog alertDialog = AlertDialog(
      content: Text(
          "Apakah anda yakin akan menghapus data '${widget.list![widget.index!]['nama']}' ?"),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          child: const Text(
            "OK DELETE!",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            deleteData(idProduk);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: const Text("CANCEL", style: TextStyle(color: Colors.black)),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  late String idProduk;
  @override
  void initState() {
    idProduk = widget.list![widget.index!]['id'];
    namaprodukController =
        TextEditingController(text: widget.list![widget.index!]['nama_produk']);
    satuanController =
        TextEditingController(text: widget.list![widget.index!]['satuan']);
    jumlahController =
        TextEditingController(text: widget.list![widget.index!]['jumlah']);
    hargajualController =
        TextEditingController(text: widget.list![widget.index!]['harga_jual']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Data Produk"),
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
                labelText: "Satuan Produk",
              ),
            ),
            TextFormField(
              controller: jumlahController,
              decoration: const InputDecoration(
                labelText: "Jumlah",
              ),
            ),
            TextFormField(
              controller: hargajualController,
              decoration: const InputDecoration(
                labelText: "Harga Jual",
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () async {
                    editData(widget.list![widget.index!]['id']);
                  },
                  child: const Text("Ubah"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    konfirmasi();
                  },
                  child: const Text("Hapus"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
