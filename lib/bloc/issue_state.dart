part of 'issue_bloc.dart';

enum IssueStatus { loading, initial, success, failure }

class IssueState extends Equatable {
  const IssueState(
      {this.status = IssueStatus.initial,
      this.items = const <Item>[],
      this.totalItems = -1,
      this.currentPage = 1,
      this.currentIdx = 1,
      this.hasReachedMax = false,
      this.slicedItems = const <Item>[]
      });

  final IssueStatus status;
  final List<Item> items;
  final List<Item> slicedItems;
  final int totalItems;
  final int currentPage;
  final int currentIdx;
  final bool hasReachedMax;

  IssueState copyWith({
    IssueStatus? status,
    List<Item>? items,
    List<Item>? slicedItems,
    int? totalItems,
    int? currentPage,
    int? currentIdx,
    bool? hasReachedMax,
  }) {
    return IssueState(
      status: status ?? this.status,
      items: items ?? this.items,
      slicedItems: slicedItems ?? this.slicedItems,
      totalItems: totalItems ?? this.totalItems,
      currentPage: currentPage ?? this.currentPage,
      currentIdx: currentIdx ?? this.currentIdx,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''IssueState { status: $status, hasReachedMax: $hasReachedMax, items: ${items.length}, total items: $totalItems} }''';
  }

  @override
  List<Object> get props => [status, items, slicedItems, totalItems, currentPage, currentIdx, hasReachedMax];
}
