part of 'repository_bloc.dart';

abstract class RepositoryEvent extends Equatable {
  const RepositoryEvent();
}

// load issue dengan query baru
class GetNewRepositoryEvent extends RepositoryEvent {
  final String query;

  const GetNewRepositoryEvent(this.query);

  @override
  List<Object?> get props => [query];
}

// load issue dengan query yang sudah ada
class GetRepositoryEvent extends RepositoryEvent {
  @override
  List<Object?> get props => [];
}

// load issue pada page tertentu
class GetRepositoryIndexEvent extends RepositoryEvent {
  final int page;

  const GetRepositoryIndexEvent(this.page);

  @override
  List<Object?> get props => [page];
}

// pindah dari index ke lazy
class IndexToLazyEvent extends RepositoryEvent {
  final int page;
  final int idx;

  const IndexToLazyEvent(this.page, this.idx);

  @override
  List<Object?> get props => [page, idx];
}