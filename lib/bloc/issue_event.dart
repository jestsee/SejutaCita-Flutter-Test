part of 'issue_bloc.dart';

abstract class IssueEvent extends Equatable {
  const IssueEvent();
}

// load issue dengan query baru
class GetNewIssueEvent extends IssueEvent {
  final String query;

  const GetNewIssueEvent(this.query);

  @override
  List<Object?> get props => [query];
}

// load issue dengan query yang sudah ada
class GetIssueEvent extends IssueEvent {
  @override
  List<Object?> get props => [];
}

// load issue pada page tertentu
class GetIssueIndexEvent extends IssueEvent {
  final int page;

  const GetIssueIndexEvent(this.page);

  @override
  List<Object?> get props => [page];
}