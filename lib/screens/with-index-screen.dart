import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejuta_cita_test/bloc/issue_bloc.dart';
import 'package:sejuta_cita_test/components/search-bar.dart';
import 'package:sejuta_cita_test/constants.dart';
import 'package:sejuta_cita_test/screens/homepage/home-screen.dart';

import '../../components/bottom-loader.dart';
import '../../components/custom-bar.dart';
import '../../components/custom-bottom-bar.dart';
import '../../components/issue-list-item.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  bool bottomHit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        // controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
              title: SearchBar(),
              centerTitle: true,
              bottom: CustomBar(indexPress: () {
                // TODO bikin biar gabisa dipencet
              }, lazyPress: () {

                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              }))
        ],
        body: BlocBuilder<IssueBloc, IssueState>(
          builder: (context, state) {
            switch (state.status) {
              case IssueStatus.failure:
                return const Center(child: Text('failed to fetch posts'));
              case IssueStatus.success:
                // log("build ulang");
                if (state.items.isEmpty) {
                  return const Center(child: Text('no issues'));
                }
                return ListView.builder(
                  itemCount: Constant.LIMIT,
                  itemBuilder: (context, index) {
                    return index >= state.slicedItems.length
                        ? BottomLoader()
                        : IssueListItem(
                            item: state.slicedItems[index],
                            index: index + 1,
                          );
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
