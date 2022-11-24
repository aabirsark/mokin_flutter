part of 'posts_bloc_bloc.dart';

abstract class PostsBlocState extends Equatable {
  const PostsBlocState();

  @override
  List<Object> get props => [];
}

/// It will be initially set by the state
class PostBlocInitial extends PostsBlocState {}

// it will be emitted to state when there will be a call to the servers
class PostBlocLoading extends PostsBlocState {}

// when the state is filled with all the thoughts
class PostBlocLoaded extends PostsBlocState {
  final List<ThoughtModel> thoughts;

  const PostBlocLoaded({required this.thoughts});

  @override
  List<Object> get props => [thoughts];
}

// IF error comes in between throw this error
class PostBlocError extends PostsBlocState {}
