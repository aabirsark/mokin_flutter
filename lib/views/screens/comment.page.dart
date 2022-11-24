import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokingbird_flutter/app/constant.dart';
import 'package:mokingbird_flutter/services/api/thought_api.serv.dart';
import 'package:mokingbird_flutter/services/models/comment.model.dart';
import 'package:mokingbird_flutter/services/models/thought.model.dart';
import 'package:mokingbird_flutter/views/widgets/post_card.widget.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key, required this.model});

  final ThoughtModel model;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<Comment> comments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getComments();
  }

  getComments() async {
    final res = await ThoughtAPIService.getComments(widget.model.id!);
    comments = res;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostCard(
              model: widget.model,
              showFooter: false,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Comments",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 25,
                  fontFamily: GoogleFonts.anton().fontFamily),
            ),
            const SizedBox(
              height: 20,
            ),
            if (isLoading)
              const Expanded(
                  child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ))
            else
              Expanded(
                  child: ListView.builder(
                itemCount: comments.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CommentTile(
                    comment: comments.elementAt(index),
                  ),
                ),
              )),
            const SizedBox(
              height: 15,
            ),
            CommentBox(
              model: widget.model,
              afterCall: () {
                getComments();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CommentTile extends StatelessWidget {
  const CommentTile({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          comment.activiyByUserId?.username ?? "",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            height: 1.5,
            fontFamily: GoogleFonts.montserrat().fontFamily,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            comment.value ?? "",
            style: TextStyle(
                fontFamily: GoogleFonts.ibmPlexMono().fontFamily, height: 1.5),
          ),
        )
      ],
    );
  }
}

class CommentBox extends HookWidget {
  const CommentBox({Key? key, required this.model, required this.afterCall})
      : super(key: key);

  final ThoughtModel model;
  final VoidCallback afterCall;

  @override
  Widget build(BuildContext context) {
    final commentController = useTextEditingController();

    return Container(
      height: 70,
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.black,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: commentController,
            cursorColor: primaryColor,
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: "Share your views..."),
            style: TextStyle(fontFamily: GoogleFonts.ibmPlexMono().fontFamily),
          )),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () async {
              if (commentController.text.isNotEmpty) {
                final res = await ThoughtAPIService.commentOnPost(
                    model.user!.id!, model.id!, commentController.text);
                if (res) {
                  afterCall();
                }
              }
              commentController.clear();
            },
            child: const SizedBox(
              height: double.maxFinite,
              width: 50,
              child: Center(
                child: Text(
                  "Post",
                  style: TextStyle(
                      color: primaryColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
