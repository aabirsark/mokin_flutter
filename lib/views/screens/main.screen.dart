import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mokingbird_flutter/app/constant.dart';
import 'package:mokingbird_flutter/services/bloc/navigator%20state%20bloc/navigator_bloc.dart';
import 'package:mokingbird_flutter/services/models/navigator.model.dart';
import 'package:mokingbird_flutter/views/screens/pages/home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: BlocBuilder<NavigatorBloc, NavigatorBlocState>(
        builder: (context, state) {
          if (state is NavigatorInitial) {
            return state.selectedView;
          }
          return const Center(
            child: Text("ERROR OCCURED"),
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: scaffoldBackgroundColor,
            border: Border.all(color: primaryColor.withOpacity(0.3))),
        margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
        height: 70,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: navigators
                .map((e) => NavigatorStateLogic(
                      model: e,
                    ))
                .toList()),
      ),
    );
  }
}

class NavigatorStateLogic extends StatelessWidget {
  const NavigatorStateLogic({
    Key? key,
    required this.model,
  }) : super(key: key);

  final NavigatorModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorBloc, NavigatorBlocState>(
      builder: (context, state) {
        if (state is NavigatorInitial) {
          return Expanded(
            child: GestureDetector(
                onTap: () {
                  context.read<NavigatorBloc>().add(NavigationChangeDestiny(
                      newView: model.child, newLabel: model.label));
                },
                child: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  color: scaffoldBackgroundColor,
                  child: Icon(
                    model.icon,
                    color:
                        model.label == state.label ? primaryColor : Colors.grey,
                  ),
                )),
          );
        }
        return const Text("ERROR");
      },
    );
  }
}
