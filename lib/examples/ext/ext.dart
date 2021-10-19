import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fldome/router/router.dart';

class ExtPage extends StatefulWidget {
  const ExtPage({Key? key}) : super(key: key);

  @override
  _ExtPageState createState() => _ExtPageState();
}

class _ExtPageState extends State<ExtPage> {
  double _x = 0;
  double _y = 0;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Overlay.of(context)?.insert(_entry());
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Page Samples'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('聊天'),
            onTap: () {
              Get.toNamed(RoutesNamespace.Chat);
            },
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            title: Text('画板'),
            onTap: () {
              Get.toNamed(RoutesNamespace.Draw);
            },
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
        ],
      ),
    );
  }

  OverlayEntry _entry() {
    return OverlayEntry(builder: (ctx) {
      return Positioned(
        width: 48,
        height: 48,
        left: _x,
        top: _y,
        child: GestureDetector(
          onPanUpdate: (d) {
            setState(() {
              _x += d.delta.dx;
              _y += d.delta.dy;
            });
          },
          child: FloatingActionButton(
            child: Icon(Icons.add_rounded),
            onPressed: () {
              print('yes');
            },
          ),
        ),
      );
    });
  }
}
