
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fometic/models/transaction_model.dart';
import 'package:simple_logger/simple_logger.dart';

import 'main_page_controller.dart';

final logger = SimpleLogger();

class TransactionController extends GetxController {


  String dateTimeSelected = "";

  String klasifikasiTransaksi = "Sedekah";
  String judulTransaksi = "";
  String nilaiTransaksi = "";
  double nilaiTransaksiDbl = 0.00;
  String tanggalTransaksi = "";
  String jenisTransaksi = "Pemasukan";
  int jenisTransaksiInt = 1;

  var listKlasifikasiTransaksi = ["Zakat", "Infak", "Sedekah", "Wakaf", "Operasional"];
  var listJenisTransaksi = ["Pemasukan", "Pengeluaran"];

  final formKey = GlobalKey<FormState>();

  TextEditingController judulTransaksiTxCtr = TextEditingController();
  TextEditingController tanggalTransaksiTxCtr = TextEditingController(text: DateTime.now().toString());
  TextEditingController nilaiTransaksiTxCtr = TextEditingController();
  TextEditingController klasifikasiTransaksiTxCtr = TextEditingController();
  TextEditingController jenisTransaksiTxCtr = TextEditingController();


  @override
  void onInit() {
    //Intl.systemLocale = Localizations.localeOf(Get.context!).toString();
    //initializeDateFormatting('id','');
    //initializeDateFormatting('en','US');
    super.onInit();

    logger.info("onInit");
  }


  @override
  void refresh() {
    super.refresh();
    logger.info("refresh");
  }


  @override
  void onReady() {
    super.onReady();
    //Intl.defaultLocale = "id_ID";  //Locale._('in_ID')
    tanggalTransaksi = tanggalTransaksiTxCtr.value.text;
    logger.info("onReady tanggalTransaksi=$tanggalTransaksi");
  }

  @override
  void onClose() {
    logger.info("onClose");
    super.onClose();
  }

  void dateTimeOnChange(String val) {
    logger.info("Changed Date To : $val");
    tanggalTransaksi = val;
  }

  String? dateTimeValidation(String val) {
    dateTimeSelected = val;
    return null;
  }

  void dateTimeSaved(String? val) {
    logger.info("Selected Date : $val");
    if (val != null) {
      tanggalTransaksi = val;
    }
    update();
  }

  void klasifikasiOnChanged(String? val) {
    logger.info("Changed Selection To : $val");
    if (val != null) {
      klasifikasiTransaksiTxCtr.value = TextEditingValue(text: val);
      klasifikasiTransaksi = val;
    }
    update();
  }

  void judulTransaksiOnChanged(String? val) {
    logger.info("Changed Title To : $val");
    if (val != null) {
      judulTransaksiTxCtr.value = TextEditingValue(text: val);
      judulTransaksi = val;
    }

  }

  void jenisOnChanged(String? val) {
    logger.info("Changed Selection To : $val");
    if (val != null) {
      if(val=="Pengeluaran") {
        jenisTransaksiInt = -1;
      } else {
        jenisTransaksiInt = 1;
      }
      jenisTransaksiTxCtr.value = TextEditingValue(text: val);
      jenisTransaksi = val;
    }
  }

  void nilaiTransaksiValidated(String value) {
    logger.info("nilaiTransaksiValidated = $value");
    nilaiTransaksi = value;
  }

  void nilaiTransaksiChanged(double val) {
    logger.info("nilaiTransaksiDouble = $val");
    nilaiTransaksiDbl = val;
  }

  void addTransaction(TransactionModel transactionModel) {
    logger.info("addTransaction: ${transactionModel.judulTransaksi}");
    MainPageController mainController = Get.find<MainPageController>();
    mainController.transactionModelList.add(transactionModel);
    mainController.update();
    update();
  }

  List<TransactionModel> getAllTransaction() {
    MainPageController mainController = Get.find<MainPageController>();
    return mainController.transactionModelList;
  }

}