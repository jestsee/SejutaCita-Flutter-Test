import 'package:flutter/material.dart';
import 'package:sejuta_cita_test/constants.dart';

class Utils {
  static void scrollToIndex(int index, ScrollController sc) {
    sc.animateTo(Constant.listTileHeight * (index),
        // TODO nanti offsetnya disesuaiin lagi
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn);
  }
}
