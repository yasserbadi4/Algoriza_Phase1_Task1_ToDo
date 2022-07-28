import 'package:flutter/material.dart';

class MyInputText extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController? controller;
  final Widget? widget;
  final TextInputType type;

  const MyInputText({
    Key? key,
    required this.title,
    required this.hintText,
    this.controller,
    this.widget,
    required this.type,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
          Container(
            height: 52,
            padding: const EdgeInsets.only(left: 10.0),
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget==null?false:true,
                    autofocus: false,
                    cursorColor: Colors.grey,
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hintText,
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white60,
                          width: 0,
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white60,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                widget==null?Container():Container(child: widget,),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
