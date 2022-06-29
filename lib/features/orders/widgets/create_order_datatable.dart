import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/custom_text.dart';

class CreateOrderDatatable extends StatefulWidget {
  final int index;
  const CreateOrderDatatable({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CreateOrderDatatable> createState() => _CreateOrderDatatableState();
}

class _CreateOrderDatatableState extends State<CreateOrderDatatable> {
  @override
  Widget build(BuildContext context) {
    final productCard = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCard['product']);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: active.withOpacity(.4), width: .5),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: DataTable2(
          columnSpacing: 0,
          horizontalMargin: 5,
          minWidth: MediaQuery.of(context).size.width,
          columns: const [
            DataColumn2(
              label: Text('Sl.no'),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text('Item'),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text('Qty'),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text('Price'),
            ),
          ],
          rows: List.generate(
              productCard.length!,
              (index) => DataRow(cells: [
                    DataCell(CustomText(text: (index + 1).toString())),
                    DataCell(CustomText(text: product.name)),
                    DataCell(CustomText(text: product.quantity.toString())),
                    DataCell(CustomText(text: product.price.toString())),
                  ]))),
    );
  }
}
