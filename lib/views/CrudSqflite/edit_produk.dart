import 'package:tugas1_0080/views/CrudSqflite/crud_sqflite.dart';
import 'package:flutter/material.dart';
import 'package:tugas1_0080/model/produk_model.dart';
import 'package:tugas1_0080/database/database_helper.dart';

class UbahProduk extends StatefulWidget {
  const UbahProduk({
    required Key key,
    required this.id,
    required this.namaProduk,
    required this.satuan,
    required this.jumlah,
    required this.hargaJual,
  }) : super(key: key);

  final int id;
  final String namaProduk;
  final String satuan;
  final int jumlah;
  final int hargaJual;

  @override
  State<UbahProduk> createState() => _UbahProdukState();
}

class _UbahProdukState extends State<UbahProduk> {
  @override
  void initState() {
    super.initState();
    namaProdukController.text = widget.namaProduk;
    satuanController.text = widget.satuan;
    jumlahController.text = widget.jumlah.toString();
    hargaJualController.text = widget.hargaJual.toString();
  }

  final namaProdukController = TextEditingController();
  final satuanController = TextEditingController();
  final jumlahController = TextEditingController();
  final hargaJualController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Database SQLite"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Column(
            children: [
              TextFormField(
                controller: namaProdukController,
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
                controller: hargaJualController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Harga Jual",
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    int jumlah = int.tryParse(jumlahController.text) ?? 0;
                    int hargajual = int.tryParse(hargaJualController.text) ?? 0;
                    await DatabaseHelper.instance.update(
                      ProdukModel(
                        id: widget.id,
                        namaProduk: namaProdukController.text,
                        satuan: satuanController.text,
                        jumlah: jumlah,
                        hargaJual: hargajual,
                      ),
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    print("Error while saving data: $e");
                  }
                },
                child: Text('Ubah'),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
