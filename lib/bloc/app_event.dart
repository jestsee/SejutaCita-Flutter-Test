part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

// load issue dengan query baru
class NewQueryEvent extends AppEvent {
  final String query;

  const NewQueryEvent(this.query);

  @override
  List<Object?> get props => [query];
}

// load issue dengan query yang sudah ada
class LoadDataEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}

// load issue pada page tertentu
class LoadDataPageEvent extends AppEvent {
  final int page;

  const LoadDataPageEvent(this.page);

  @override
  List<Object?> get props => [page];
}

// pindah dari index ke lazy
class IndexToLazyEvent extends AppEvent {
  final int page;
  final int idx;

  const IndexToLazyEvent(this.page, this.idx);

  @override
  List<Object?> get props => [page, idx];
}

// ganti search type
class ChangeSearchTypeEvent extends AppEvent {
  final SearchType type;

  const ChangeSearchTypeEvent(this.type);

  @override
  List<Object?> get props => [type];
}
