import 'package:flutter/material.dart';

import '../color_manager.dart';
import '../font_manager.dart';
import '../style_manager.dart';
import '../value_manager.dart';

class MyTextFormField extends StatelessWidget {
  String initialValue,label,hint;
  Image? icon;
  bool enable;
  GlobalKey<FormState>? formKey;
  TextEditingController controller;
  MyTextFormField({this.initialValue='', required this.controller, this.label='', this.hint='', this.icon, this.enable=true, this.formKey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Text(
              label ?? "",
              style: getRegularStyle(
                  fontColor: ColorManager.primary,
                  fontSize: FontSize.labelSize),
            ),
          ),
          TextFormField(
            validator: ((value) {
              if (value == null || value.isEmpty) {
                return "value must not be null";
              }
              return null;
            }),
            enabled: enable,
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.borderRadius),
                borderSide: BorderSide(color: ColorManager.disabledColor),
              ),
              icon: icon,
            ),
          ),
        ],
      ),
    );
  }
}