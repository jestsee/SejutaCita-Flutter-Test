import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejuta_cita_test/bloc/issue_bloc.dart';

import '../../components/bottom-loader.dart';
import '../../components/issue-list-item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  late IssueBloc issueBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TEST"),
      ),
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
                    : state.items.length + 1,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return index >= state.items.length
                      ? BottomLoader()
                      : IssueListItem(item: state.items[index]);
                },
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
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
    if (_isBottom) context.read<IssueBloc>().add(IssueFetchedEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
