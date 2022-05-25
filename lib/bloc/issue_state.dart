part of 'issue_bloc.dart';

enum IssueStatus { loading, initial, success, failure }

class IssueState extends Equatable {
  const IssueState(
      {this.status = IssueStatus.initial,
      this.items = const <Item>[],
      this.hasReachedMax = false});

  final IssueStatus status;
  final List<Item> items;
  final bool hasReachedMax;

  IssueState copyWith({
    IssueStatus? status,
    List<Item>? items,
    bool? hasReachedMax,
  }) {
    return IssueState(
      status: status ?? this.status,
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''IssueState { status: $status, hasReachedMax: $hasReachedMax, items: ${items.length} }''';
  }

  @override
  List<Object> get props => [status, items, hasReachedMax];
}
