import 'package:flutter/material.dart';

class IngEditRow {
  TextEditingController nameCtrl;
  TextEditingController qtyCtrl;
  String unit;

  IngEditRow({
    required this.nameCtrl,
    required this.qtyCtrl,
    required this.unit,
  });
}

class StepEditRow {
  TextEditingController headingCtrl;
  TextEditingController descCtrl;
  bool hasTimer;
  TextEditingController timerCtrl;

  StepEditRow({
    required this.headingCtrl,
    required this.descCtrl,
    required this.hasTimer,
    required this.timerCtrl,
  });
}