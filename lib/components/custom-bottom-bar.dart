import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejuta_cita_test/constants.dart';

import '../bloc/app_bloc.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  final int max = 5;
  int curPage = 1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        var state = context.read<AppBloc>().state;
        var maxPage =
            state.totalItems > 1000 ? 33 : (state.totalItems / 30).ceil();

        List<Widget> indexes = [];
        int totalPage = (state.items.length / 30).ceil();
        // log("page: $page");

        indexes.add(indexNumber("< ", () {
          setState(() {
            curPage--;
          });
          context.read<AppBloc>().add(LoadDataPageEvent(state.currentPage > 1
              ? state.currentPage - 1
              : state.currentPage));
        }, false));

        if (totalPage > max) {
          for (int i = 0; i < max; i++) {
            indexes.add(indexNumber((i + 1).toString(), () {
              setState(() {
                curPage = i;
              });
              context.read<AppBloc>().add(LoadDataPageEvent(i + 1));
            }, i == curPage));

            indexes.add(const SizedBox(
              width: 10,
            ));
          }
          indexes.add(indexNumber("   ...   ", () {}, false));
          indexes.add(indexNumber(totalPage.toString(), () {
            setState(() {
              curPage = totalPage;
            });
            context.read<AppBloc>().add(LoadDataPageEvent(totalPage));
          }, totalPage == curPage));
        } else {
          for (int i = 0; i < totalPage; i++) {
            indexes.add(indexNumber((i + 1).toString(), () {
              setState(() {
                curPage = i;
              });
              context.read<AppBloc>().add(LoadDataPageEvent(i + 1));
            }, i == curPage));

            indexes.add(const SizedBox(
              width: 10,
            ));
          }
        }

        indexes.add(indexNumber("   of  $maxPage", () {}, false));

        indexes.add(indexNumber(" >", () {
          setState(() {
            curPage++;
          });
          context.read<AppBloc>().add(LoadDataPageEvent(
              state.currentPage < maxPage
                  ? state.currentPage + 1
                  : state.currentPage));
        }, false));

        // styling
        return Container(
          color: kBlueLightColor,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indexes,
          ),
        );
      },
    );
  }

  Widget indexNumber(String index, Function() onTap, bool selected) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        index,
        style: TextStyle(
          fontWeight: selected ? FontWeight.w900 : FontWeight.w400,
          fontSize: selected ? 18 : 14,
        ),
      ),
    );
  }
}
