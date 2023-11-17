import 'package:flutter/material.dart';
import 'package:project_1/models/restaurant.dart';

class MenuListItem extends StatelessWidget {
  final Menu menu;

  MenuListItem({required this.menu});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: ListTile(
        title: Text(
          menu.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '฿${menu.price.toStringAsFixed(2)}',
          style: TextStyle(
            color: Colors.green.shade400,
            fontSize: 16,
          ),
        ),
        trailing: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("สั่งอาหารแล้ว"),
                  content: Text("เมนู ${menu.name} ถูกสั่งแล้ว :-) "),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("ตกลง"),
                    ),
                  ],
                );
              },
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
          child: Text(
            "Order Now",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
