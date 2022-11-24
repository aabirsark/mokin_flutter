import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokingbird_flutter/app/constant.dart';
import 'package:mokingbird_flutter/services/api/thought_api.serv.dart';
import 'package:mokingbird_flutter/services/bloc/posts%20state%20bloc/posts_bloc_bloc.dart';
import 'package:mokingbird_flutter/services/models/thought.model.dart';
import 'package:mokingbird_flutter/views/screens/new_thought.page.dart';
import 'package:mokingbird_flutter/views/widgets/post_card.widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appName,
          style: TextStyle(
              fontFamily: GoogleFonts.anton().fontFamily,
              fontSize: 25,
              color: primaryColor),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              context.read<PostsBlocBloc>().add(PostBlocRefresh());
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  "Refresh",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white38),
                ),
              ),
            ),
          )
        ],
        leadingWidth: 80,
        leading: const Center(
            child: Text(
          "Home",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )),
      ),
      body: BlocBuilder<PostsBlocBloc, PostsBlocState>(
        builder: (context, state) {
          if (state is PostBlocLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (state is PostBlocError) {
            return const Center(
              child: Text(
                "Something Bad Happend !",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          } else if (state is PostBlocLoaded) {
            return RefreshIndicator(
              color: Colors.white,
              onRefresh: () async {
                context.read<PostsBlocBloc>().add(PostBlocRefresh());
                await Future.delayed(const Duration(milliseconds: 700));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.thoughts.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: PostCard(model: state.thoughts.elementAt(index)),
                  ),
                ),
              ),
            );
          }
          return const Center(
            child: Text("Error :-("),
          );
        },
      ),
    );
  }
}
