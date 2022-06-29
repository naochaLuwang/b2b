import 'dart:io';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../models/invoice.dart';
import 'pdf_api.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();

    final font = await rootBundle.load("assets/OpenSans-Regular.ttf");
    final ttf = Font.ttf(font);

    pdf.addPage(MultiPage(
        build: (context) => [
              buildTitle(invoice, ttf),
            ]));

    return PdfApi.saveDocument(name: 'invoice.pdf', pdf: pdf);
  }

  static Widget buildTitle(Invoice invoice, ttf) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('INVOICE',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, font: ttf)),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
      ]);
}
