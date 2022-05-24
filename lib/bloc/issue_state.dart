part of 'issue_bloc.dart';

abstract class IssueState extends Equatable {
  const IssueState();
}

class IssueLoadingState extends IssueState {
  @override
  List<Object> get props => [];
}

// TODO harus dibedain bloc nya buat per issue, repo, user gitu ga ya?
class IssueLoadedState extends IssueState {
  final Future<List<Item>> items;

  IssueLoadedState(this.items);
  @override
  List<Object?> get props => [items];
}

class IssueNoInternetState extends IssueState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
