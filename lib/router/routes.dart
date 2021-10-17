// ignore_for_file: prefer_const_constructors

import 'package:fldome/examples/chat/chat.dart';
import 'package:fldome/examples/ext/ext.dart';
import 'package:get/get.dart';

import 'namespace.dart';

final List<GetPage> routes = [
  GetPage(
    name: RoutesNamespace.Chat,
    page: () => ChatPage(),
  ),
  GetPage(
    name: RoutesNamespace.Home,
    page: () => ExtPage(),
  ),
];
