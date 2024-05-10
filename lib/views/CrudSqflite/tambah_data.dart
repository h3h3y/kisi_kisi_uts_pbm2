import 'package:flutter/material.dart';
import 'package:tugas1_0080/views/CrudSqflite/crud_sqflite.dart';
import 'package:tugas1_0080/model/produk_model.dart';
import 'package:tugas1_0080/database/database_helper.dart';
import 'package:tugas1_0080/views/home.dart';

class TambahProduk extends StatefulWidget {
  const TambahProduk({super.key});

  @override
  State<TambahProduk> createState() => _TambahProdukState();
}

class _TambahProdukState extends State<TambahProduk> {
  late int selectedId;

  TextEditingController namaProdukController = TextEditingController();
  TextEditingController satuanController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController hargaJualController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Data Produk (Sqflite)"),
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
                    await DatabaseHelper.instance.add(
                      ProdukModel(
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
                child: Text('Simpan'),
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
