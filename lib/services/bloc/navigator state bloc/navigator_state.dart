part of 'navigator_bloc.dart';

abstract class NavigatorBlocState extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigatorInitial extends NavigatorBlocState {
  final Widget selectedView;
  final String label;

  NavigatorInitial({this.selectedView = const HomePage(), this.label = "Home"});

  @override
  List<Object> get props => [selectedView, label];
}
