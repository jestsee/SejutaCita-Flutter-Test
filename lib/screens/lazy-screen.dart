import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejuta_cita_test/bloc/issue_bloc.dart';
import 'package:sejuta_cita_test/components/utils.dart';
import 'package:sejuta_cita_test/constants.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../components/bottom-loader.dart';
import '../components/custom-app-bar.dart';
import '../components/custom-bar.dart';
import '../components/issue-list-item.dart';
import '../models/issue-response.dart';
import 'with-index-screen.dart';

class LazyScreen extends StatefulWidget {
  const LazyScreen({Key? key}) : super(key: key);

  @override
  State<LazyScreen> createState() => _LazyScreenState();
}

class _LazyScreenState extends State<LazyScreen> {
  ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;
  bool bottomHit = false;
  bool correctIndex = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        // controller: _scrollController,
        // floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CustomAppBar(
            bottom: CustomBar(
              lazyPress: () {
                // TODO
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
            _scrollController = PrimaryScrollController.of(context)!;
            _scrollController.addListener(_onScroll);

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
                    if (!correctIndex) {
                      Future.delayed(const Duration(milliseconds: 200), () {
                        Utils.scrollToIndex(
                            (state.currentPage - 1) * Constant.LIMIT,
                            _scrollController);
                        correctIndex = true;
                      });
                    }

                    return VisibilityDetector(
                      key: Key(index.toString()),
                      onVisibilityChanged: (VisibilityInfo info) {
                        setState(() {
                          _currentIndex = index;
                          // log('CURRENT IDX: $_currentIndex');
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

    // log("maxScroll: $maxScroll currentScroll: $currentScroll");

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
