import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejuta_cita_test/bloc/app_bloc.dart';
import 'package:sejuta_cita_test/components/custom-app-bar.dart';
import 'package:sejuta_cita_test/components/error-handler.dart';
import 'package:sejuta_cita_test/components/utils.dart';
import 'package:sejuta_cita_test/constants.dart';
import 'package:sejuta_cita_test/screens/lazy-screen.dart';

import '../../components/bottom-loader.dart';
import '../../components/custom-bar.dart';
import '../../components/custom-bottom-bar.dart';
import '../components/list-items/issue-list-item.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  bool bottomHit = false;
  late int _page;
  late int _idx;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        // controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CustomAppBar(
              bottom: CustomBar(indexPress: () {
            // TODO bikin biar gabisa dipencet
          }, lazyPress: () {
            log('INDEX -> LAZY: $_page');
            context.read<AppBloc>().add(IndexToLazyEvent(_page, 1));
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => LazyScreen()),
            );
          }))
        ],
        body: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            _page = state.currentPage;
            _idx = state.currentIdx;
            switch (state.status) {
              case Status.failure:
                return Center(child: ErrorHandler(text: state.errorMsg));

              case Status.success:
                // log("build ulang");
                if (state.items.isEmpty) {
                  return const Center(
                      child: ErrorHandler(
                          text: "Sorry, we couldn't find any results"));
                }
                return ListView.builder(
                  itemCount: kLimit,
                  itemBuilder: (context, index) {
                    return index < state.slicedItems.length
                        ? Utils.widgetDecider(state.slicedItems[index], index) : SizedBox();
                  },
                );

              default:
                return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
