part of 'home_cubit.dart';

enum HomeStatus {
  initial,
  favoriteLoading,
  loading,
  success,
  failure,
}

class HomeState extends Equatable {
  final HomeStatus status;
  final RepositoryListModel? repositoryListModel;
  final List<Items> repoList;
  final bool hasReachedMax;
  final String? message;

  const HomeState({
    this.status = HomeStatus.initial,
    this.message,
    this.repositoryListModel,
    this.repoList = const [],
    this.hasReachedMax = false,
  });

  HomeState copyWith({
    HomeStatus? status,
    bool? hasReachedMax,
    RepositoryListModel? repositoryListModel,
    List<Items>? repoList,
    String? message,
  }) {
    return HomeState(
      status: status ?? this.status,
      message: message ?? this.message,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      repositoryListModel: repositoryListModel ?? this.repositoryListModel,
      repoList: repoList ?? this.repoList,
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        hasReachedMax,
        repositoryListModel,
        repoList,
      ];
}
