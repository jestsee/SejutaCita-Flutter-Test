import 'package:flutter/material.dart';
import 'package:sejuta_cita_test/components/search-bar.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, required this.bottom}) : super(key: key);
  final PreferredSizeWidget bottom;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const SearchBar(),
      automaticallyImplyLeading: false,
      centerTitle: true,
      toolbarHeight: 125,
      // expandedHeight: 120,
      bottom: bottom,
    );
  }
}
