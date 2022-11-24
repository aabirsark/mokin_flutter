import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mokingbird_flutter/services/api/thought_api.serv.dart';
import 'package:mokingbird_flutter/services/models/thought.model.dart';

part 'posts_bloc_event.dart';
part 'posts_bloc_state.dart';

class PostsBlocBloc extends Bloc<PostsBlocEvent, PostsBlocState> {
  PostsBlocBloc() : super(PostBlocInitial()) {
    on<PostBlocLoad>(loadPosts);
    on<PostBlocRefresh>(refreshPost);
  }

  Future<void> loadPosts(
      PostBlocLoad event, Emitter<PostsBlocState> emit) async {
    if (state is PostBlocInitial) {
      emit(PostBlocLoading());
      try {
        final res = await ThoughtAPIService.getAllThought();
        emit(PostBlocLoaded(thoughts: res));
      } catch (e) {
        emit(PostBlocError());
      }
    }
  }

  Future<void> refreshPost(
      PostBlocRefresh event, Emitter<PostsBlocState> emit) async {
    if (state is PostBlocLoaded) {
      emit(PostBlocLoading());
      try {
        final res = await ThoughtAPIService.getAllThought();
        emit(PostBlocLoaded(thoughts: res));
      } catch (e) {
        emit(PostBlocError());
      }
    }
  }
}
