import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextWidget extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final double height;
  final String topLabel;
  final int? minLines;
  final bool multiLines;
  final int? maxLines;
  final TextEditingController? controller;

  const TextWidget({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.height = 48.0,
    this.topLabel = "",
    this.minLines,
    this.multiLines = false,
    this.maxLines,
    this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(topLabel),
        SizedBox(height: 5.0.h),
        Container(
          height: ScreenUtil().setHeight(height),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0.spMin),
          ),
          child: TextFormField(
            controller: controller,
            minLines: minLines,
            maxLines: maxLines,
            keyboardType:
                multiLines ? TextInputType.multiline : TextInputType.text,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(74, 77, 84, 0.2),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.purple,
                ),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 14.0.spMin,
                color: const Color.fromRGBO(105, 108, 121, 0.7),
              ),
            ),
          ),
        )
      ],
    );
  }
}
