part of 'issue_bloc.dart';

enum IssueStatus { loading, initial, success, failure }

class IssueState<T> extends Equatable {
  const IssueState(
      {this.status = IssueStatus.initial,
      this.totalItems = -1,
      this.currentPage = 1,
      this.currentIdx = 1,
      this.hasReachedMax = false,
      this.type = SearchType.unknown,
      required this.items,
      required this.slicedItems});

  final IssueStatus status;
  final List<T> items;
  final List<T> slicedItems;
  final int totalItems;
  final int currentPage;
  final int currentIdx;
  final bool hasReachedMax;
  final SearchType type;

  IssueState copyWith(
      {IssueStatus? status,
      List<T>? items,
      List<T>? slicedItems,
      int? totalItems,
      int? currentPage,
      int? currentIdx,
      bool? hasReachedMax,
      SearchType? type}) {
    return IssueState(
      status: status ?? this.status,
      items: items ?? this.items,
      slicedItems: slicedItems ?? this.slicedItems,
      totalItems: totalItems ?? this.totalItems,
      currentPage: currentPage ?? this.currentPage,
      currentIdx: currentIdx ?? this.currentIdx,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      type: type ?? this.type,
    );
  }

  @override
  String toString() {
    return '''IssueState { status: $status, hasReachedMax: $hasReachedMax, items: ${items.length}, total items: $totalItems} }''';
  }

  @override
  List<Object> get props => [
        status,
        items,
        slicedItems,
        totalItems,
        currentPage,
        currentIdx,
        hasReachedMax,
        type
      ];
}
