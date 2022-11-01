import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Nam"),value: "Male"),
    DropdownMenuItem(child: Text("Nữ"),value: "Female"),
    DropdownMenuItem(child: Text("Khác"),value: "Other"),
  ];
  return menuItems;
}