class TransactionModel {
  String judulTransaksi = "";
  String tanggalTransaksi = "";
  String nilaiTransaksi = "";
  double nilaiTransaksiDbl = 0.00;
  String klasifikasiTransaksi = "";
  int jenisTransaksi = 1;

  TransactionModel(this.judulTransaksi, this.tanggalTransaksi,
      this.nilaiTransaksiDbl, this.klasifikasiTransaksi, this.jenisTransaksi);

}