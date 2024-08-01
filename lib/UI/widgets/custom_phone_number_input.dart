import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../constants/palette.dart';
import 'apptexts.dart';

class CustomPhoneNumberInput extends StatelessWidget {
  final Function? onSubmit;
  final String? hintText;
  final double? textSize;
  final Color? hintColor;
  final String? Function(String?)? validator;
  final Function(PhoneNumber)? onSaved;
  final Function(PhoneNumber)? onInputChanged;
  String? isoCode;
  final String? hint;
  final TextEditingController? controller;

  CustomPhoneNumberInput(
      {Key? key,
      this.onSubmit,
      this.onSaved,
      this.isoCode,
      this.onInputChanged,
      this.controller,
      this.hint = "Phone Number",
      this.hintText,
      this.textSize,
      this.hintColor,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hintText != null
            ? Column(
                children: [
                  AppText(
                    hintText ?? "",
                    size: textSize ?? 13.5,
                    color: hintColor ?? primaryColor,
                    // isBold: true,
                    align: TextAlign.start,
                  ),
                  10.0.sbH,
                ],
              )
            : 0.0.sbH,
        Column(
          children: [
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) => onInputChanged!(number),
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
              initialValue: PhoneNumber(
                isoCode:
                    'NG', // Set the default country using its ISO code (e.g., 'US' for United States)
              ),
              searchBoxDecoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.transparent,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor, width: 0.8),
                    borderRadius: BorderRadius.circular(8)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0.8,
                        color:
                            Theme.of(context).disabledColor.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(8)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: errorColor, width: 0.8),
                    borderRadius: BorderRadius.circular(8)),
                errorStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              inputDecoration: InputDecoration(
                isDense: true,
                // border: InputBorder.none,
                hintText: hint!,
                filled: true,
                fillColor: Colors.transparent,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor, width: 0.8),
                    borderRadius: BorderRadius.circular(8)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0.8,
                        color:
                            Theme.of(context).disabledColor.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(8)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: errorColor, width: 0.8),
                    borderRadius: BorderRadius.circular(8)),
                errorStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              textFieldController: controller,
              // initialValue: PhoneNumber(isoCode: isoCode!),
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.DIALOG,
              ),
              ignoreBlank: true,
              autoValidateMode: AutovalidateMode.disabled,
              onSaved: (PhoneNumber number) => {onSaved!(number)},
              onSubmit: () => onSubmit!(),
              validator: validator,
            ),
          ],
        ),
      ],
    );
  }
}
