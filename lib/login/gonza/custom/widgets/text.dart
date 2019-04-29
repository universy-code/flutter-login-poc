import 'package:flutter/material.dart';

class CustomText extends Text {
  CustomText(String data)
      : super(
          data,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 25),
        );
}

class CustomTextFormField extends TextFormField {
  CustomTextFormField({
      TextEditingController controller,
      String inputMessage,
      String errorMessage,
      obscure=false})
      : super(
            controller: controller,
            decoration: InputDecoration(labelText: inputMessage),
            validator: getNotEmptyValidator(errorMessage),
            obscureText: obscure);
}

FormFieldValidator<String> getNotEmptyValidator(String errorMessage) {
  return (value) {
    if (value.isEmpty) {
      return errorMessage;
    }
  };
}
