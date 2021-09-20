import 'package:flutter/material.dart';
import 'package:spinchat/utils/constants.dart';

class CustomTextField extends StatefulWidget {
  final double? width;
  final double? height;
  final String? hintText;
  final TextEditingController? controller;
  final int? minLines;
  final int? maxLines;
  final bool? obscureText;
  final bool? enabled;
  final FormFieldValidator<String>? validateFunction;
  final void Function(String)? onSaved, onChange;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode, nextFocusNode;
  final VoidCallback? submitAction;
  final bool? enableErrorMessage;
  final void Function(String)? onFieldSubmitted;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final Color? bordercolor;
  final bool? autofocus;

  const CustomTextField({
    Key? key,
    this.width,
    this.height = 60,
    @required this.hintText,
    @required this.controller,
    this.minLines = 1,
    this.obscureText = false,
    this.enabled = true,
    this.validateFunction,
    this.onSaved,
    this.onChange,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.nextFocusNode,
    this.submitAction,
    this.enableErrorMessage = true,
    this.maxLines = 1,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.prefixIcon,
    this.bordercolor,
    this.autofocus,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? error;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: widget.height,
          // height: widget.maxLines != 1
          //     ? widget.maxLines!.toDouble() *
          //         MediaQuery.of(context).size.height /
          //         35
          //     : widget.height,
          width: widget.width ?? MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.bordercolor == null
                  ? kMynaveyBlue
                  : widget.bordercolor!,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10),
            child: Center(
              child: TextFormField(
                autofocus: widget.autofocus == null ? false : widget.autofocus!,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textCapitalization: TextCapitalization.sentences,
                enabled: widget.enabled,
                onChanged: (val) {
                  widget.validateFunction != null
                      ? error = widget.validateFunction!(val)
                      : error = null;
                  setState(() {});
                  // widget.onSaved(val);
                },
                style: TextStyle(
                  fontSize: 15.0,
                ),
                key: widget.key,
                maxLines: widget.maxLines,
                controller: widget.controller,
                obscureText: widget.obscureText!,
                keyboardType: widget.keyboardType,
                validator: widget.validateFunction != null
                    ? widget.validateFunction!
                    : (value) {
                        return null;
                      },
                onSaved: (val) {
                  error = widget.validateFunction!(val);
                  setState(() {});
                  widget.onSaved!(val!);
                },
                textInputAction: widget.textInputAction,
                focusNode: widget.focusNode,
                onFieldSubmitted: widget.onFieldSubmitted,
                decoration: InputDecoration(
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: widget.suffixIcon,
                  filled: false,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: kMyMediumGrey,
                  ),
                  errorBorder: kBorderStyle,
                  errorStyle: TextStyle(
                      height: 0.0, fontSize: 0.0, color: Colors.yellow),
                  focusedErrorBorder: kBorderStyle,
                  disabledBorder: kBorderStyle,
                  border: kBorderStyle,
                  enabledBorder: kBorderStyle,
                  focusedBorder: kBorderStyle,
                ),
              ),
            ),
          ),
        ),
        if (error != null)
          Container(
            height: 5.0,
          )
        else
          Container(),
        if (error != null)
          Text(
            error!,
            style: TextStyle(
              color: Colors.red,
            ),
          )
        else
          Container(),
        Container(
          height: 5,
        ),
      ],
    );
  }
}
