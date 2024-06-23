// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_node_practice/core/constants/custom_colors.dart';

class AuthFormField extends StatelessWidget {
  AuthFormField({
    super.key,
    required this.title,
    required this.hintText,
    this.suffixIcon,
    this.obscureText,
    required this.isRequired,
    required this.validator,
    required this.controller,
    this.textInputAction,
    this.readOnly,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.enabled,
  });
  String title;
  String hintText;
  Widget? suffixIcon;
  bool? obscureText;
  bool isRequired;
  TextInputAction? textInputAction;
  String? Function(String?)? validator;
  TextEditingController controller;
  Function(String)? onFieldSubmitted;
  bool? readOnly;
  List<TextInputFormatter>? inputFormatters;
  bool? enabled;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              isRequired
                  ? const TextSpan(
                      text: "*",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CustomColor.actionColor,
                      ),
                    )
                  : const WidgetSpan(
                      child: SizedBox(width: 5),
                    ),
              const WidgetSpan(
                child: SizedBox(width: 5),
              ),
              TextSpan(
                text: title,
                style: Theme.of(context).textTheme.labelLarge?.merge(
                      const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 400,
          child: TextFormField(
            enabled: enabled,
            readOnly: readOnly ?? false,
            obscureText: obscureText ?? false,
            cursorColor: Colors.black,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            decoration: InputDecoration(
              suffixIcon: suffixIcon ?? const SizedBox(),
              hintText: hintText,
              errorStyle: const TextStyle(color: CustomColor.actionColor),
              hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 173, 173, 245),
                  fontWeight: FontWeight.normal),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              errorMaxLines: 3,
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: CustomColor.actionColor),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: CustomColor.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: CustomColor.actionColor),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: CustomColor.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            keyboardType: TextInputType.name,
            keyboardAppearance: Brightness.dark,
            autofocus: false,
            validator: validator,
            controller: controller,
            onSaved: (value) {},
            onFieldSubmitted: onFieldSubmitted,
            textInputAction: textInputAction ?? TextInputAction.next,
            inputFormatters: inputFormatters,
          ),
        ),
      ],
    );
  }
}
