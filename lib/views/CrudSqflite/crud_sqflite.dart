// import 'package:tugas1_0080/edit_produk.dart';
import 'package:flutter/material.dart';
import 'package:tugas1_0080/model/produk_model.dart';
import 'package:tugas1_0080/database/database_helper.dart';
import 'package:tugas1_0080/views/CrudSqflite/tambah_data.dart';
import 'package:tugas1_0080/views/CrudSqflite/edit_produk.dart';

class CrudSqflite extends StatefulWidget {
  const CrudSqflite({Key? key}) : super(key: key);

  @override
  State<CrudSqflite> createState() => _CrudSqfliteState();
}

class _CrudSqfliteState extends State<CrudSqflite> {
  int? selectedId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ProdukModel>>(
        future: DatabaseHelper.instance.getAllProduk(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProdukModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return (snapshot.data != null && snapshot.data!.isEmpty)
              ? const Center(child: Text('No Data in List. '))
              : ListView(
                  children: snapshot.data!.map((produk) {
                    return Center(
                      child: Card(
                        color: Colors.white70,
                        child: ListTile(
                          title: Text(produk.namaProduk),
                          onTap: () {
                            setState(
                              () {
                                if (selectedId == null) {
                                  selectedId = produk.id;
                                } else {
                                  selectedId = null;
                                }
                              },
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UbahProduk(
                                          key: UniqueKey(),
                                          id: produk.id ?? 0,
                                          namaProduk: produk.namaProduk,
                                          satuan: produk.satuan,
                                          jumlah: produk.jumlah,
                                          hargaJual: produk.hargaJual,
                                        )));
                          },
                          trailing: InkWell(
                            child: const Icon(
                              Icons.delete_forever_rounded,
                              size: 30,
                              color: Colors.red,
                            ),
                            onTap: () {
                              setState(() {
                                DatabaseHelper.instance.remove(produk.id ?? 0);
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TambahProduk()),
          );
        }, // atau () {} untuk fungsi kosong
      ),
    );
  }
}
