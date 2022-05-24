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
  final String issueTitle;
  final DateTime issueUpdateAt;
  // TODO issues di kanan atas?
  final String issueState;

  IssueLoadedState(this.issueTitle, this.issueUpdateAt, this.issueState);
  @override
  List<Object?> get props => [issueTitle, issueUpdateAt, issueState];
}
