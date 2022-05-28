import 'package:flutter/material.dart';
import 'package:sejuta_cita_test/components/search-bar.dart';
import 'package:sejuta_cita_test/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, required this.bottom}) : super(key: key);
  final PreferredSizeWidget bottom;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const SearchBar(),
      backgroundColor: kBlueLightColor,
      automaticallyImplyLeading: false,
      centerTitle: true,
      // toolbarHeight: 70,
      // collapsedHeight: 100,
      // expandedHeight: 150,
      floating: true,
      snap: true,
      pinned: true,
      elevation: 3,
      bottom: bottom,
    );
  }
}
