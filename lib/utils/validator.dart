import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringHelper on String {
  formatToShort() {
    if (length > 30) {
      return substring(0, 31);
    } else {
      return this;
    }
  }

  bool isValidEmail() {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);
  }
}

Future<String> selectDate(BuildContext context,{DateTime? startDate,DateTime? initialDate}) async {
  DateTime selectedDate = initialDate ?? startDate ?? DateTime.now();
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: startDate ?? DateTime(2015, 8),
    lastDate: DateTime(2101),
  );

  if (picked != null && picked != selectedDate) {
    selectedDate = picked;
  }
  return DateFormat('yyyy-MM-dd').format(selectedDate);
}
