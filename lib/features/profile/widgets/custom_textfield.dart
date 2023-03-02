import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, required this.hintText, required this.icon});

  final String hintText;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      width: MediaQuery.of(context).size.width,
      height: 70,
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        autocorrect: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          prefixIcon: icon,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
          filled: true,
          // border: InputBorder.none,
          fillColor: const Color.fromRGBO(240, 240, 240, 1),
        ),
      ),
    );
  }
}
