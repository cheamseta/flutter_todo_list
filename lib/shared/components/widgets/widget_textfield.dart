import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_text.dart';
import 'package:flutter_todo_list/theme/text_style.dart';

class TDTextfield extends StatelessWidget {
  TextEditingController? controller;
  String title;
  Icon? theIcon;
  TextInputType? textInput;
  Widget? suffixAction;
  Widget? suffix;
  String placeholder;
  int? textLength;
  Function(String)? onChange;
  Function(String)? onSubmit;
  bool isFocus;
  bool isRead;
  bool isRequired;
  bool isMulti;
  FocusNode? focusNode;
  bool isPassword;
  VoidCallback? onEditComplete;
  List<TextInputFormatter>? inputFormaterList;
  Iterable<String>? autofill;

  TDTextfield(
      {super.key,
      required this.title,
      this.controller,
      this.isFocus = false,
      this.isRead = false,
      this.isPassword = false,
      this.isMulti = false,
      this.isRequired = false,
      this.suffixAction,
      this.textInput,
      this.suffix,
      this.placeholder = "...",
      this.onSubmit,
      this.onChange,
      this.textLength,
      this.inputFormaterList,
      this.onEditComplete,
      this.autofill,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        isRequired
            ? Row(
                children: [
                  TDText.subtitle(title),
                  TDText.subtitle(" *", color: Colors.red)
                ],
              )
            : TDText.subtitle(title),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.only(left: 15, right: 10, bottom: 5),
          decoration: BoxDecoration(
              color: isRead ? Colors.grey : Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 1, color: Colors.grey)),
          child: TextField(
              focusNode: focusNode,
              style: TDTextStyle.subtitle(context: context),
              inputFormatters: inputFormaterList,
              onEditingComplete: onEditComplete,
              keyboardType: isMulti ? TextInputType.multiline : textInput,
              onChanged: onChange,
              maxLines: isMulti ? 5 : 1,
              maxLength: textLength,
              autofocus: isFocus,
              readOnly: isRead,
              textInputAction: TextInputAction.newline,
              autofillHints: autofill,
              obscureText: isPassword,
              onSubmitted: onSubmit,
              onTap: () => controller?.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: controller?.value.text.length ?? 0),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: placeholder,
                  hintStyle:
                      TDTextStyle.body(context: context, color: Colors.grey),
                  suffix: suffix,
                  suffixIcon: suffixAction),
              controller: controller),
        ),
      ],
    );
  }

  static Widget textfield(TextEditingController controller, String placeholder,
      {FocusNode? node,
      bool isNumber = false,
      TextStyle? textStyle,
      bool isReadOnly = false,
      bool isMultiLine = false,
      Function(String)? onChanged,
      Widget? suffixIcon}) {
    return TextField(
        controller: controller,
        focusNode: node,
        readOnly: isReadOnly,
        onChanged: onChanged,
        style: textStyle,
        maxLines: isMultiLine ? 5 : 1,
        keyboardType: isNumber
            ? const TextInputType.numberWithOptions(decimal: true)
            : null,
        decoration: InputDecoration(
            hintText: placeholder,
            suffixIcon: suffixIcon,
            border: InputBorder.none));
  }
}
