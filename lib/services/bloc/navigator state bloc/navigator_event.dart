part of 'navigator_bloc.dart';

abstract class NavigatorEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigationChangeDestiny extends NavigatorEvent {
  final Widget newView;
  final String newLabel;

  NavigationChangeDestiny({required this.newView, required this.newLabel});

  @override
  List<Object> get props => [newView, newLabel];
}
