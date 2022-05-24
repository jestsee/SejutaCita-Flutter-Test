part of 'issue_bloc.dart';

abstract class IssueEvent extends Equatable {
  const IssueEvent();
}

class LoadIssueEvent extends IssueEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}