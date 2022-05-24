import 'dart:developer';

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejuta_cita_test/bloc/issue_bloc.dart';
import 'package:sejuta_cita_test/models/issue-response.dart';
import 'package:sejuta_cita_test/repository/issue-repository.dart';
import 'package:sejuta_cita_test/services/connectivity-service.dart';

import 'home-body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => IssueRepo()),
        RepositoryProvider(create: (context) => ConnectivityService()),
      ],
      child: BlocProvider(
        create: (context) =>
            IssueBloc(
                RepositoryProvider.of<IssueRepo>(context),
                RepositoryProvider.of<ConnectivityService>(context),
            )
              ..add(LoadIssueEvent()),
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
                return FutureBuilder<List<Item>>(
                  future: state.items,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        // TODO perlu itemcount?
                        itemBuilder: (context, index) => Card (
                          shape: RoundedRectangleBorder(
                            // TODO bisa dijadiin constant radiusnya
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: ListTile(
                            title: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(snapshot.data![index].title)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  }
                );
              }
              log("ga masuk mana2");

              if (state is NoInternetEvent) {
                return Text('no internet : (');
              }

              return HomeBody();
            },
          ),
        ),
      ),
    );
  }
}
