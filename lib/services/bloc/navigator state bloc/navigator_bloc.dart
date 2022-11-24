import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mokingbird_flutter/app/constant.dart';
import 'package:mokingbird_flutter/services/models/navigator.model.dart';
import 'package:mokingbird_flutter/views/screens/pages/home_page.dart';

part 'navigator_event.dart';
part 'navigator_state.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, NavigatorBlocState> {
  NavigatorBloc() : super(NavigatorInitial()) {
    on<NavigationChangeDestiny>(_destinyChange);
  }

  void _destinyChange(
      NavigationChangeDestiny event, Emitter<NavigatorBlocState> emit) {
    if (state is NavigatorInitial) {
      emit(
          NavigatorInitial(selectedView: event.newView, label: event.newLabel));
    }
  }
}
