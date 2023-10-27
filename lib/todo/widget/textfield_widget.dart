import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
    TextFieldWidget({
        Key? key,
        required this.maxLine,
        required this.hintText,
        required this.txtController,
    }) : super(key: key);

    final int maxLine;
    final String hintText;
    final TextEditingController txtController;
    final FocusNode focusNode = FocusNode();

    @override
    Widget build(BuildContext context) {
        return TextField(
            controller: txtController,
            focusNode: focusNode,
            maxLines: maxLine,
            decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                ),
            ),
            onTap: () {
                focusNode.requestFocus();
            },
            onEditingComplete: () {
                focusNode.unfocus();
            },
        );
    }
}
