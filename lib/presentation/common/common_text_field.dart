import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final Function(String val)? validation;
  final Function(String val)? onChanged;
  final Function(String val)? onSubmit;
  final bool? obscureText;
  final TextInputType? textInputType;
  final Function()? onTap;
  final Function()? onTapEdit;
  final Widget? suffixIcon;
  final bool readOnly;
  final bool isShowEllipsis;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;

  const CommonTextField({super.key,
    this.controller,
    this.readOnly = false,
    this.isShowEllipsis = false,
    this.hintText,
    this.labelText,
    this.validation,
    this.onChanged,
    this.obscureText,
    this.onTap,
    this.onSubmit,
    this.inputFormatters,
    this.maxLines=1,
    this.onTapEdit,
    this.textInputType, this.suffixIcon});

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelText != null ? Padding(
          padding:  widget.onTapEdit == null ? const EdgeInsets.only(left: 12.0,bottom: 5.0,top: 8) : const EdgeInsets.only(left: 12.0,right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.labelText ?? "",style: const TextStyle(color: Colors.black,fontSize: 14)),
             widget.onTapEdit != null ? InkWell(
                borderRadius: BorderRadius.circular(20),
                  onTap: widget.onTapEdit,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.edit_outlined),
                  )) : const SizedBox.shrink()
            ],
          ),
        ) : const SizedBox.shrink(),
        InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: widget.onTap,
          child: IgnorePointer(
            ignoring: widget.onTap != null ? true : false,
            child: TextFormField(
              controller: widget.controller,
              readOnly: widget.readOnly,
              maxLines: widget.maxLines,
              inputFormatters: widget.inputFormatters??[],
              obscureText: widget.obscureText ?? false,
              keyboardType: widget.textInputType ?? TextInputType.name,
              onChanged: ((value) => widget.onChanged != null ? widget.onChanged!(value) : null),
              validator: (value) => widget.validation != null ? widget.validation!(value ?? "") : null,
              onFieldSubmitted: ((value) => widget.onSubmit != null ? widget.onSubmit!(value) : null),
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
              decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  errorMaxLines: 3,
                  fillColor: Colors.grey.withOpacity(0.15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22), borderSide: BorderSide.none),
                  hintText: widget.hintText ?? "",
                  suffixIcon: widget.suffixIcon,
                  hintStyle: const TextStyle(
                      color: Colors.grey,
                      overflow: TextOverflow.ellipsis
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15)),
            ),
          ),
        ),
      ],
    );
  }
}
