import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejuta_cita_test/bloc/issue_bloc.dart';
import 'package:sejuta_cita_test/components/search-bar.dart';
import 'package:sejuta_cita_test/components/utils.dart';
import 'package:sejuta_cita_test/constants.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../components/bottom-loader.dart';
import '../../components/custom-bar.dart';
import '../../components/custom-bottom-bar.dart';
import '../../components/issue-list-item.dart';
import '../../models/issue-response.dart';
import '../with-index-screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  int _currentIndex = 0;
  bool bottomHit = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  int itemCounter(List<Item> items) {
    int counter = 30;

    if (items[counter].state != "unknown") {
      counter += 30;
    }

    return counter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        // controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: SearchBar(),
            centerTitle: true,
            bottom: CustomBar(
              lazyPress: () {
                Utils.scrollToIndex(25, _scrollController); // TODO
              },
              indexPress: () {
                int page = (_currentIndex / Constant.LIMIT).ceil();
                log("LAZY -> INDEX: $page");
                context.read<IssueBloc>().add(GetIssueIndexEvent(page));
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => IndexScreen()),
                );
              },
            ),
          )
        ],
        body: BlocBuilder<IssueBloc, IssueState>(
          builder: (context, state) {
            switch (state.status) {
              case IssueStatus.failure:
                return const Center(child: Text('failed to fetch posts'));
              case IssueStatus.success:
                if (state.items.isEmpty) {
                  return const Center(child: Text('no issues'));
                }
                return ListView.builder(
                  itemCount: state.hasReachedMax
                      ? state.items.length
                      : /*itemCounter(state.items)*/ state.items.length + 1,
                  controller: _scrollController,
                  itemBuilder: (context, index) {

                      log('INDEX LAZY: ${state.currentPage}');

                    // Utils.scrollToIndex(state.currentPage * Constant.LIMIT, _scrollController);

                    return VisibilityDetector(
                      key: Key(index.toString()),
                      onVisibilityChanged: (VisibilityInfo info) {
                        setState(() {
                          _currentIndex = index;
                          log('CURRENT IDX: $_currentIndex');
                        });
                      },
                      child: index >= state.items.length
                          ? BottomLoader()
                          : IssueListItem(
                              item: state.items[index],
                              index: index + 1,
                            ),
                    );
                  },
                );
              default:
                return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll && !bottomHit) {
      context.read<IssueBloc>().add(GetIssueEvent());
      bottomHit = true;
    } else {
      Future.delayed(const Duration(milliseconds: 1200), () {
        bottomHit = false;
      });
    }
    // if (_isBottom) context.read<IssueBloc>().add(IssueFetchedEvent());
  }
}
