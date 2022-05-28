import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/app_bloc.dart';

class CustomBottomBar extends StatelessWidget {
  final int max = 5;

  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        var maxPage =
            state.totalItems > 1000 ? 33 : (state.totalItems / 30).ceil();

        List<Widget> indexes = [];
        int totalPage = (state.items.length / 30).ceil();
        // log("page: $page");

        indexes.add(indexNumber("<",
            () => context.read<AppBloc>().add(LoadDataPageEvent(
                state.currentPage > 1
                    ? state.currentPage - 1
                    : state.currentPage))));

        if (totalPage > max) {
          for (int i = 0; i < max; i++) {
            indexes.add(indexNumber((i + 1).toString(),
                () => context.read<AppBloc>().add(LoadDataPageEvent(i + 1))));

            indexes.add(const SizedBox(
              width: 10,
            ));
          }
          indexes.add(indexNumber(totalPage.toString(),
              () => context.read<AppBloc>().add(LoadDataPageEvent(totalPage))));
        } else {
          for (int i = 0; i < totalPage; i++) {
            indexes.add(indexNumber((i + 1).toString(),
                () => context.read<AppBloc>().add(LoadDataPageEvent(i + 1))));
          }
        }

        indexes.add(indexNumber(">",
                () => context.read<AppBloc>().add(LoadDataPageEvent(
                state.currentPage < maxPage
                    ? state.currentPage + 1
                    : state.currentPage))));

        // styling
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

  Widget indexNumber(String index, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        index,
      ),
    );
  }
}
