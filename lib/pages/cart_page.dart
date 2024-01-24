import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.all(20),
                  child: Text("$index"),
                ),
            separatorBuilder: (context, index) => SizedBox(height: 12),
            itemCount: 3)
      ]),
    );
  }
}
