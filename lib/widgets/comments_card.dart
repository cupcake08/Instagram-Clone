import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/resources/firestore_methods.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentsCard extends StatefulWidget {
  const CommentsCard({Key? key, required this.snap}) : super(key: key);
  final Map<String, dynamic> snap;
  @override
  _CommentsCardState createState() => _CommentsCardState();
}

class _CommentsCardState extends State<CommentsCard> {
  bool _liked = false;
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.snap['profilePic']),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${widget.snap['username']} ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: widget.snap['text'],
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat.yMMMMd('en_US')
                              .format(widget.snap['datePublished'].toDate()),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: secondaryColor,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        if (widget.snap['likes'].length > 0)
                          Text(
                            '${widget.snap['likes'].length} likes',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: secondaryColor,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          LikeAnimation(
            isAnimating: widget.snap['likes'].contains(user.uid),
            smallLike: true,
            child: InkWell(
              onTap: () async {
                setState(() {
                  _liked = !_liked;
                });
                await FirestoreMethods().likeComment(
                  commentId: widget.snap['commentId'],
                  likes: widget.snap['likes'],
                  postId: widget.snap['postId'],
                  uid: user.uid,
                  context: context,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: widget.snap['likes'].contains(user.uid)
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                        size: 16,
                      )
                    : const Icon(
                        Icons.favorite_outline,
                        size: 16,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
