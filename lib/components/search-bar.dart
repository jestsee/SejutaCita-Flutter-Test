import 'dart:developer';

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejuta_cita_test/bloc/issue_bloc.dart';
import 'package:sejuta_cita_test/constants.dart';

import '../repository/issue-repository.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: .8 * size.width,
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
              context.read<IssueBloc>().add(GetNewIssueEvent(value));
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
            suffixIcon: Icon(Icons.search),
            hintText: "Search",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
          ),
        ),
      ),
    );
  }
}
