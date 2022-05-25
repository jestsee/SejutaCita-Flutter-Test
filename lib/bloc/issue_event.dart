part of 'issue_bloc.dart';

abstract class IssueEvent extends Equatable {
  const IssueEvent();
}

// load issue baru
class GetNewIssueEvent extends IssueEvent {
  final String query;

  const GetNewIssueEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class GetIssueEvent extends IssueEvent {
  @override
  List<Object?> get props => [];
}