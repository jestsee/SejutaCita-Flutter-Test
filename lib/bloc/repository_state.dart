part of 'repository_bloc.dart';

enum RepositoryStatus { loading, initial, success, failure }

class RepositoryState<T> extends Equatable {
  const RepositoryState(
      {this.status = RepositoryStatus.initial,
        this.totalItems = -1,
        this.currentPage = 1,
        this.currentIdx = 1,
        this.hasReachedMax = false,
        required this.items,
        required this.slicedItems
      });

  final RepositoryStatus status;
  final List<T> items;
  final List<T> slicedItems;
  final int totalItems;
  final int currentPage;
  final int currentIdx;
  final bool hasReachedMax;

  RepositoryState copyWith({
    RepositoryStatus? status,
    List<T>? items,
    List<T>? slicedItems,
    int? totalItems,
    int? currentPage,
    int? currentIdx,
    bool? hasReachedMax,
  }) {
    return RepositoryState(
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
    return '''RepositoryState { status: $status, hasReachedMax: $hasReachedMax, items: ${items.length}, total items: $totalItems} }''';
  }

  @override
  List<Object> get props => [status, items, slicedItems, totalItems, currentPage, currentIdx, hasReachedMax];
}

