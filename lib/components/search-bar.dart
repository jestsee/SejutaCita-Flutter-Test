import 'dart:developer';

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejuta_cita_test/bloc/app_bloc.dart';
import 'package:sejuta_cita_test/constants.dart';

import '../repository/repository.dart';
import '../screens/lazy-screen.dart';

class SearchBar extends StatefulWidget {
  final bool homePage;

  const SearchBar({Key? key, this.homePage = false}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: .8 * size.width,
      // margin: EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          style: const TextStyle(color: Colors.black),
          onSubmitted: (value) {
            isEmpty = value == '';
            if (!isEmpty) {
              log("submit clicked, value:$value");
              context.read<AppBloc>().add(NewQueryEvent(value));

              if (widget.homePage) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LazyScreen()),
                );
              }
            } else {
              final snackBar = SnackBar(
                content: const Text("Field can't be empty"),
                backgroundColor: (Colors.black),
                action: SnackBarAction(
                  label: 'Dismiss',
                  onPressed: () {},
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          decoration: const InputDecoration(
            suffixIcon: Icon(
              Icons.search,
              size: 28,
            ),
            hintText: "Search",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
          ),
        ),
      ),
    );
  }
}
