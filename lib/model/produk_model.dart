class ProdukModel {
  final int? id;

  final String namaProduk;
  final String satuan;
  final int jumlah;
  final int hargaJual;

  ProdukModel(
      {this.id,
      required this.namaProduk,
      required this.satuan,
      required this.jumlah,
      required this.hargaJual});

  factory ProdukModel.fromMap(Map<String, dynamic> json) => ProdukModel(
        id: json['id'],
        namaProduk: json['namaProduk'],
        satuan: json['satuan'],
        jumlah: json['jumlah'],
        hargaJual: json['hargaJual'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'namaProduk': namaProduk,
      'satuan': satuan,
      'jumlah': jumlah,
      'hargaJual': hargaJual,
    };
  }

  factory ProdukModel.fromJson(Map<String, dynamic> json) {
    return ProdukModel(
      id: json['id'],
      namaProduk: json['namaProduk'],
      satuan: json['satuan'],
      jumlah: json['jumlah'],
      hargaJual: json['hargaJual'],
    );
  }
}
