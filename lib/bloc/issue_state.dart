part of 'issue_bloc.dart';

enum IssueStatus { loading, initial, success, failure }

class IssueState extends Equatable {
  const IssueState(
      {this.status = IssueStatus.initial,
      this.items = const <Item>[],
      this.totalItems = 0,
      this.hasReachedMax = false});

  final IssueStatus status;
  final List<Item> items;
  final int totalItems;
  final bool hasReachedMax;

  IssueState copyWith({
    IssueStatus? status,
    List<Item>? items,
    int? totalItems,
    bool? hasReachedMax,
  }) {
    return IssueState(
      status: status ?? this.status,
      items: items ?? this.items,
      totalItems: totalItems ?? this.totalItems,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''IssueState { status: $status, hasReachedMax: $hasReachedMax, items: ${items.length}, total items: $totalItems} }''';
  }

  @override
  List<Object> get props => [status, items, totalItems, hasReachedMax];
}
