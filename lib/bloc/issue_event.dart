part of 'issue_bloc.dart';

abstract class IssueEvent extends Equatable {
  const IssueEvent();

  @override
  List<Object> get props => [];
}

// load issue baru
class IssueFetchedEvent extends IssueEvent {}