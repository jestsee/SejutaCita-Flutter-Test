import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejuta_cita_test/bloc/issue_bloc.dart';
import 'package:sejuta_cita_test/components/search-bar.dart';

import '../../components/bottom-loader.dart';
import '../../components/custom-bar.dart';
import '../../components/issue-list-item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  // late IssueBloc issueBloc;
  bool bottomHit = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        // controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: SearchBar(onChanged: (String value) {  },),
            centerTitle: true,
            bottom: CustomBar(),
          )
        ], body: BlocBuilder<IssueBloc, IssueState>(
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
                      : state.items.length + 1,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    return index >= state.items.length
                        ? BottomLoader()
                        : IssueListItem(item: state.items[index], index: index+1,);
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
      context.read<IssueBloc>().add(IssueFetchedEvent());
      bottomHit = true;
    } else {
      Future.delayed(const Duration(milliseconds: 1200), () {
        bottomHit = false;
      });
    }
    // if (_isBottom) context.read<IssueBloc>().add(IssueFetchedEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
