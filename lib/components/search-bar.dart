import 'dart:developer';

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejuta_cita_test/bloc/issue_bloc.dart';

import '../repository/issue-repository.dart';

class SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchBar({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: .8 * size.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0),
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        onChanged: onChanged,
        onSubmitted: (value) {
          log("submit clicked, value:$value");

          context.read<IssueBloc>().add(GetNewIssueEvent(value));

          // final issueBloc = BlocProvider.of<IssueBloc>(context);
          // issueBloc.query = value;

          // context.read<IssueBloc>().add(IssueFetchedEvent());
        },
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.search),
          hintText: "Search",
          hintStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 5),
        ),
      ),
    );
  }
}
