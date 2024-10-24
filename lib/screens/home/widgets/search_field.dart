import 'package:flutter/material.dart';

import 'package:flutter_end/constants/app_icons.dart';

class SearchField extends StatefulWidget {
  const SearchField(
      {super.key, required this.onChangd, required this.hintText});

  final ValueChanged<String> onChangd;
  final String hintText;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final controller = TextEditingController(); // quan li noi dung cua o tim kiem
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller, // controller cua textformfield
        style: const TextStyle(
          color: Colors.orange, // mau chu cua text trong form
          fontSize: 16, // kich thuoc cua text
        ),
        decoration: InputDecoration(
            //
            hintText: widget.hintText, // goi y cua o tim kiem
            hintStyle: TextStyle(
                // dinh dang cho text goi y
                color: Colors.white.withOpacity(0.8),
                fontSize: 15),
            // prefixIcon icon hien thi o dau o tim kiem
            prefixIcon: SizedBox(
              width: 40, // chieu rong cua sizebox
              // center la 1 widget de can giua cac widget con
              child: Center(
                child: Image.asset(
                  AppIcons.search,
                  width: 20,
                  height: 20,
                  color: Colors.black,
                ),
              ),
            ),
            border: OutlineInputBorder( // bien cho form
              borderRadius: BorderRadius.circular(12)
            ),
            filled: true, // to mau nen
            fillColor: Colors.white // mau nen cua form
            ),
            onChanged: widget.onChangd
            );
            
  }
}
