import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fldome/router/router.dart';

class ExtPage extends StatefulWidget {
  const ExtPage({Key? key}) : super(key: key);

  @override
  _ExtPageState createState() => _ExtPageState();
}

class _ExtPageState extends State<ExtPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Page Samples'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('chat'),
            onTap: () {
              Get.toNamed(RoutesNamespace.Chat);
            },
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
        ],
      ),
    );
  }
}
