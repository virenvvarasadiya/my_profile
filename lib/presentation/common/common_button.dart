import 'package:flutter/material.dart';

class CommonButton extends StatefulWidget {
  final Color? backGroundColor;
  final Color? textColor;
  final String? buttonText;
  final double? width;
  final double? fontSize;
  final double? vertical;
  final double? radius;
  final double? horizontal;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;

  const CommonButton(
      {super.key,
        this.backGroundColor,
        this.buttonText,
        this.width,
        this.textColor,
        this.onTap,
        this.fontWeight,
        this.fontSize,this.horizontal,this.vertical,this.radius});

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(widget.radius ?? 22),
      child: Container(
        width: widget.width ?? double.infinity,
        padding: EdgeInsets.symmetric(vertical: widget.vertical ?? 15, horizontal: widget.horizontal ?? 15),
        decoration: BoxDecoration(
          border: Border.all(color: widget.backGroundColor != null ? widget.textColor ?? Colors.transparent : Colors.transparent),
            borderRadius: BorderRadius.circular(widget.radius ?? 22),
            color: widget.backGroundColor ?? Colors.blueAccent),
        child: Center(
            child: Text(
              widget.buttonText ?? "",
              style: TextStyle(
                  color: widget.textColor ?? Colors.white,
                  fontSize: widget.fontSize ?? 15,
                  fontWeight: widget.fontWeight ?? FontWeight.w500),
            )),
      ),
    );
  }
}
