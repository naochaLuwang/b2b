import 'package:flutter/material.dart';

import '../../../models/order.dart';

class InvoicePage extends StatefulWidget {
  static const String routeName = "/invoice";
  final Order order;
  const InvoicePage({Key? key, required this.order}) : super(key: key);

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('${widget.order.id.trim()}.pdf',
            style: const TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Rely Health Medico',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '9 , Sundarpur , Guwahati , Assam',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ]),
                )
              ],
            ),
            Row(
              children: const [],
            )
          ],
        ),
      )),
    );
  }
}
