import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:fometic/components/form_content_decoration.dart';
import 'package:fometic/components/form_dropdown_selection.dart';
import 'package:fometic/components/form_header.dart';
import 'package:fometic/controllers/transaction_controller.dart';
import 'package:fometic/models/transaction_model.dart';
import 'package:fometic/utils/responsive/responsive.dart';
import 'package:fometic/utils/strutils/constants.dart';

class TransactionSection extends GetView<TransactionController> {
  @override
  Widget build(BuildContext context) {

    return GetBuilder<TransactionController>(
        init: TransactionController(),
        builder: (controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(defaultPadding),
            child: Container(
              height: MediaQuery.of(context).size.height - 64 - defaultPadding,
              color: Theme.of(context).backgroundColor,
              child: Column(
                children: <Widget>[
                  SizedBox(height: defaultPadding),
                  const FormHeader(
                    title: "Transaksi",
                  ),
                  const SizedBox(height: formHeadContentPadding),
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: borderWidthSmall,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height:
                                    formStylePadding), //Input Nama dan Tanggal Responsive
                            Expanded(
                              flex: 1,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: TextFormField(
                                      controller:
                                          controller.judulTransaksiTxCtr,
                                      decoration: FormContentDecoration(
                                          labelText: "Nama Transaksi",
                                          hintText: "Masukkan Nama Transaksi"),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  if (!Responsive.isMobile(context))
                                    SizedBox(width: formContentRowPadding),
                                  if (!Responsive.isMobile(context))
                                    Expanded(
                                      flex: 1,
                                      child: DateTimePicker(
                                        decoration: FormContentDecoration(
                                            hintText: "Pilih Waktu Transaksi", labelText: ''),
                                        type: DateTimePickerType.dateTimeSeparate,
                                        dateMask: 'd MMM, yyyy',
                                        use24HourFormat: false,
                                        calendarTitle: "Tanggal Transaksi",
                                        locale: const Locale("id", "ID"),
                                        initialValue: DateTime.now().toString(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                        icon: Icon(Icons.event),
                                        dateLabelText: "Tanggal",
                                        dateHintText: "Tanggal Acara",
                                        timeLabelText: "Waktu",
                                        timeHintText: "Waktu Acara",
                                        onChanged: (val) => print(val),
                                        validator: (val) {
                                          print(val);
                                          return null;
                                        },
                                        onSaved: (val) => print(val),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            if (Responsive.isMobile(context))
                              SizedBox(height: formContentColPadding),
                            if (Responsive.isMobile(context))
                              Expanded(
                                flex: 1,
                                child: DateTimePicker(
                                    decoration: FormContentDecoration(
                                        hintText: "Pilih Waktu Transaksi", labelText: ''),
                                    type: DateTimePickerType.dateTimeSeparate,
                                    dateMask: 'd MMM, yyyy',
                                    locale: const Locale("id", "ID"),
                                    initialValue: DateTime.now().toString(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                    icon: Icon(Icons.event),
                                    dateLabelText: "Tanggal",
                                    dateHintText: "Tanggal Acara",
                                    timeLabelText: "Waktu",
                                    timeHintText: "Waktu Acara",
                                    onChanged: (val) => print(val),
                                    validator: (val) {
                                      print(val);
                                      return null;
                                    },
                                    onSaved: (val) => print(val),
                                  ),
                              ),
                            SizedBox(
                                height:
                                    formStylePadding), //Input Nominal dan Jenis Transaksi
                            Expanded(
                              flex: 1,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Rp", style: formContentlabelStyle),
                                  SizedBox(width: formContentRowSmallPadding),
                                  Expanded(
                                    flex: 1,
                                    child: TextFormField(
                                      controller:
                                          controller.nilaiTransaksiTxCtr,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        MoneyInputFormatter(
                                          leadingSymbol: "Rp ",
                                          mantissaLength: 2,
                                          maxTextLength: 256,
                                          onValueChange: (val) {
                                            controller
                                                .nilaiTransaksiChanged(val);
                                          },
                                          thousandSeparator:
                                              ThousandSeparator.Period,
                                        )
                                      ],
                                      decoration: FormContentDecoration(
                                          labelText: "Nilai Transaksi dalam Rp",
                                          hintText:
                                              "Masukkan Jumlah Transaksi"),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Harap Masukkan Nilai Transaksi';
                                        } else if (!value.isCurrency) {
                                          return 'Terdapat huruf pada nilai transaction';
                                        }
                                        controller
                                            .nilaiTransaksiValidated(value);
                                        return null;
                                      },
                                    ),
                                  ),
                                  if (!Responsive.isMobile(context))
                                    SizedBox(width: formContentRowPadding),
                                  if (!Responsive.isMobile(context))
                                    Expanded(
                                      flex: 1,
                                      child: FormDropdownInput<String>(
                                        hintText: "Pilihan Sumber Dana",
                                        options:
                                            controller.listKlasifikasiTransaksi,
                                        value: controller.klasifikasiTransaksi,
                                        onChanged:
                                            controller.klasifikasiOnChanged,
                                        getLabel: (String value) => value,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            if (Responsive.isMobile(context))
                              SizedBox(height: formContentColPadding),
                            if (Responsive.isMobile(context))
                              Expanded(
                                flex: 1,
                                child: FormDropdownInput<String>(
                                  hintText: "Pilihan Klasifikasi Dana",
                                  options: controller.listKlasifikasiTransaksi,
                                  value: controller.klasifikasiTransaksi,
                                  onChanged: controller.klasifikasiOnChanged,
                                  getLabel: (String value) => value,
                                ),
                              ),
                            SizedBox(height: formContentColPadding),
                            Expanded(
                              flex: 1,
                              child: FormDropdownInput<String>(
                                hintText: "Pilihan Jenis Aliran Transaksi",
                                options: controller.listJenisTransaksi,
                                value: controller.jenisTransaksi,
                                onChanged: controller.jenisOnChanged,
                                getLabel: (String value) => value,
                              ),
                            ),
                            Container(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Validate returns true if the form is valid, or false otherwise.
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    var param = [
                                      controller.judulTransaksiTxCtr.text,
                                      controller.tanggalTransaksi,
                                      controller.nilaiTransaksiTxCtr.text,
                                      controller.klasifikasiTransaksi,
                                      controller.nilaiTransaksiDbl,
                                      controller.jenisTransaksi,
                                      controller.jenisTransaksiInt
                                    ];
                                    logger.info("input : $param");
                                    TransactionModel transactionModel =
                                        TransactionModel(
                                            controller.judulTransaksiTxCtr.text,
                                            controller.tanggalTransaksi,
                                            controller.nilaiTransaksiDbl,
                                            controller.klasifikasiTransaksi,
                                            controller.jenisTransaksiInt);

                                    controller.addTransaction(transactionModel);
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Processing Data $param")),
                                    );
                                  }
                                },
                                child: const Text('Submit'),
                              ),
                            ),
                            Container(
                              child: ElevatedButton(
                                onPressed: () {


                                  // Validate returns true if the form is valid, or false otherwise.
                                  List<TransactionModel> transactionList =
                                      controller.getAllTransaction();
                                  String transaksiListString = "";
                                  for (var i = 0;
                                      i < transactionList.length;
                                      i++) {
                                    transaksiListString +=
                                        transactionList[i].judulTransaksi;
                                    transaksiListString += ";";
                                  }

                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Transaksi Terdaftar : $transaksiListString")),
                                  );
                                },
                                child: const Text('Cek Semua Transaksi'),
                              ),
                            ),
                            Expanded(
                                flex: 5,
                                child: SizedBox(
                                  height: defaultPadding,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

/*

TextField(
                  controller: controller.judulTransaksiTxCtr,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Name of the event",
                      labelText: "Event Name",
                      labelStyle: TextStyle(fontSize: 18, color: Colors.black)),
                ),

                controller: controller.tanggalTransaksiTxCtr,
                                        decoration: FormContentDecoration(
                                            labelText: controller.tanggalTransaksiTxCtr.value.text,
                                            hintText: "Pilih Waktu Transaksi"),
                                        type:
                                            DateTimePickerType.dateTimeSeparate,
                                        dateMask: 'd MMM, yyyy',
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                        //initialValue: controller.tanggalTransaksi,
                                        locale: Locale('in', 'ID'),
                                        icon: Icon(Icons.event),
                                        dateLabelText: 'Date',
                                        timeLabelText: "Hour",
                                        //selectableDayPredicate: (date) {
                                          // Disable weekend days to select from the calendar
                                        //  if (date.weekday == 6 ||
                                        //      date.weekday == 7) {
                                        //    return false;
                                        //  }

                                        //  return true;
                                        //},
                                        onChanged: (val) {
                                          controller.dateTimeOnChange(val);
                                        },
                                        validator: (val) {
                                          controller.dateTimeSaved(val);
                                          print(val);
                                          return null;
                                        },
                                        onSaved: (val) {
                                          controller.dateTimeSaved(val);
                                        },



                                        Localizations(
                                  locale: const Locale('id', ''),
                                  delegates: <LocalizationsDelegate<dynamic>>[
                                    DefaultWidgetsLocalizations.delegate,
                                    DefaultMaterialLocalizations.delegate,
                                  ],
                                  child:

                                  var dateSelected = showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2100));
                                  logger.info("dateSelected = $dateSelected");
 */
