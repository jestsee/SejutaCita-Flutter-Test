import "package:flutter/material.dart";
import '../../components/search-bar.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width
    return Center(
      child: Column(
        children: <Widget>[
          SearchBar(
          )
        ],
      ),
    );
  }
}
