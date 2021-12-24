import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_solidity/core/extensions/extensions.dart';
import 'package:flutter_solidity/utils/colors.dart';
import 'package:flutter_solidity/widgets/touchable_opacity.dart';

class FlSolidityTextField extends StatefulWidget {
  const FlSolidityTextField({
    Key? key,
    this.onTap,
    this.prefix,
    this.suffix,
    this.hintText,
    this.validator,
    this.maxLength,
    this.isPassword = false,
    this.isEnabled = true,
    this.controller,
    this.padding,
    this.keyboardType,
    this.inputFormatters,
    required this.labelText,
  }) : super(key: key);

  final String? labelText, hintText;
  final Widget? prefix, suffix;
  final int? maxLength;
  final bool isPassword, isEnabled;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? padding;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  _FlSolidityTextFieldState createState() => _FlSolidityTextFieldState();
}

class _FlSolidityTextFieldState extends State<FlSolidityTextField> {
  late bool obscured;
  @override
  void initState() {
    setState(() {
      obscured = widget.isPassword;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ??
          const EdgeInsets.symmetric(
            horizontal: 16,
          ),
      child: Row(
        children: [
          Flexible(
            child: TouchableOpacity(
              onTap: widget.onTap,
              child: TextFormField(
                obscureText: obscured,
                enabled: widget.isEnabled,
                controller: widget.controller,
                maxLength: widget.maxLength,
                validator: widget.validator,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: kFlSolidityBlack,
                ),
                inputFormatters: widget.inputFormatters,
                keyboardType: widget.keyboardType,
                decoration: InputDecoration(
                  hintText: widget.hintText ?? '',
                  labelText: widget.labelText,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: kFlSolidityGreen,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: kFlSolidityGrey100,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.isPassword == true)
                        TouchableOpacity(
                          onTap: () {
                            setState(() {
                              obscured = !obscured;
                            });
                          },
                          child: SvgPicture.asset(
                            'eye'.svg,
                            color: obscured
                                ? kFlSolidityBlack
                                : kFlSolidityGrey700,
                          ),
                        ),
                      if (widget.suffix != null) widget.suffix!,
                    ],
                  ),
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: kFlSolidityBlack,
                  ),
                  counterStyle: const TextStyle(
                    fontSize: 0,
                    color: white,
                  ),
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    color: kFlSolidityGrey900,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
