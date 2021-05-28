import 'package:creatorstudio/config/palette.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final String hintText;
  final TextEditingController textController;
  const CustomTextFieldWidget({required this.hintText, required this.textController});

  @override
  _CustomTextFieldWidgetState createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: TextFormField(
          controller: widget.textController,
          decoration: InputDecoration(
            hintText: widget.hintText,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Palette.darkerGrey,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Palette.darkerGrey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
