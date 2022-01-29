import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi/pages/home/home_page.dart';
import 'package:pi/pages/splain/splain_page.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 80,
            color: Colors.blueAccent,
          ),
          ListTile(
            title: const Text('Кривая Безье'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Сплайн кривой Безье'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SplainPage()));
            },
          ),
        ],
      ),
    );
  }
}
