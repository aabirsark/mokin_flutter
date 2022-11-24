part of 'posts_bloc_bloc.dart';

abstract class PostsBlocEvent extends Equatable {
  const PostsBlocEvent();

  @override
  List<Object> get props => [];
}

/// When the app is initially opened
class PostBlocLoad extends PostsBlocEvent {}

/// when user pull to refresh
class PostBlocRefresh extends PostsBlocEvent {}
