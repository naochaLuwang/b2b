import 'package:flutter/material.dart';

import 'infocard.dart';

class OverviewCardsSmallScreen extends StatelessWidget {
  const OverviewCardsSmallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 230,
      child: Column(
        children: [
          InfoCardSmall(
            title: "Pending Orders",
            value: "7",
            onTap: () {},
            isActive: true,
          ),
          SizedBox(
            height: width / 64,
          ),
          InfoCardSmall(
            title: "Recieved Orders",
            value: "17",
            onTap: () {},
          ),
          SizedBox(
            height: width / 64,
          ),
          InfoCardSmall(
            title: "Total Orders",
            value: "3",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
