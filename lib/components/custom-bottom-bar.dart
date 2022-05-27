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
        // var totalItems =
        //     state.totalItems > 1000 ? 33 : (state.totalItems / 30).ceil();

        int page = (state.items.length / 30).ceil();
        // log("page: $page");

        List<Widget> indexes = [];
        if (page > max) {
          for (int i = 0; i < max; i++) {
            indexes.add(indexNumber(
                i + 1,
                () => context.read<AppBloc>().add(LoadDataPageEvent(i + 1))));
          }
          indexes.add(indexNumber(
              page,
              () =>
                  context.read<AppBloc>().add(LoadDataPageEvent(page))));
        } else {
          for (int i = 0; i < page; i++) {
            indexes.add(indexNumber(i + 1,
                () => context.read<AppBloc>().add(LoadDataPageEvent(i + 1))));
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
