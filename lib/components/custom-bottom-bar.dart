import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/issue_bloc.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueBloc, IssueState>(
      builder: (context, state) {
        int totalItems = (state.totalItems / 30).ceil();
        log("division result: $totalItems");

        List<Widget> indexes = [];
        if (totalItems > 3) {
          for (int i = 0; i < 3; i++) {
            indexes.add(indexNumber(
                // TODO harus bikin event baru kah?
                i + 1,
                () => context.read<IssueBloc>().add(GetIssuePageEvent(i + 1))));
          }
          indexes.add(indexNumber(
              totalItems,
              () => context
                  .read<IssueBloc>()
                  .add(GetIssuePageEvent(totalItems))));
        } else {
          for (int i = 0; i < totalItems; i++) {
            indexes.add(indexNumber(i + 1,
                () => context.read<IssueBloc>().add(GetIssuePageEvent(i + 1))));
          }
        }

        return Container(
          color: Colors.blue,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indexes,
          ),
        );
      },
    );
  }

  Widget indexNumber(int index, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        index.toString(),
      ),
    );
  }
}
