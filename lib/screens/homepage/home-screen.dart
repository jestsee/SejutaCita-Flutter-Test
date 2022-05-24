import 'dart:developer';

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejuta_cita_test/bloc/issue_bloc.dart';
import 'package:sejuta_cita_test/repository/issue-repository.dart';

import 'home-body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(
        create: (context) => IssueRepo()
      )],
      child: BlocProvider(
        create: (context) =>
          IssueBloc(RepositoryProvider.of<IssueRepo>(context)
      )..add(LoadIssueEvent()),
        child: Scaffold(
          appBar: AppBar(),
          body: BlocBuilder<IssueBloc, IssueState>(
            builder: (context, state) {
              if (state is IssueLoadingState) {
                log("masuk loading state");
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is IssueLoadedState) {
                log("masuk loaded state");
                return Column(
                  children: <Widget>[
                    Text(state.issueTitle),
                    Text(state.issueUpdateAt.toString()),
                    Text(state.issueState),
                  ],
                );
              }
              log("ga masuk mana2");
              return HomeBody();
            } ,
          ),
        ),
      ),
    );
  }
}
