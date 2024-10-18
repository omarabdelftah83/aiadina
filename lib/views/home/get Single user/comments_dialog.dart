import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:ourhands/utils/colors.dart';
import 'package:ourhands/utils/const.dart';
import 'package:ourhands/utils/images.dart';
import '../../../models/comments_model.dart';
import '../../../services/comment_service.dart';
import '../../../widgets/app_text/AppText.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'comments_dailog/show_comments_dialog.dart';
class CommentsDialog {
  static Future<void> show(BuildContext context, String postId) async {
    final TextEditingController _commentController = TextEditingController();
    final CommentService _commentService = CommentService();

    await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        pageBuilder: (context, animation, secondaryAnimation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              contentPadding: EdgeInsets.zero,
              content: StatefulBuilder(
                builder: (context, setState) {
                  return FutureBuilder<CommentResponse?>(
                    future: _commentService.fetchComments(postId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _loadingWidget();
                      } else if (snapshot.hasError ||
                          !snapshot.hasData ||
                          snapshot.data!.comments!.isEmpty) {
    return _noCommentsWidget(context, _commentController, setState, _commentService, postId);
                      }

                      final comments = snapshot.data!.comments!;
                      comments.sort((a, b) => DateTime.parse(b.createdAt.toString())
                          .compareTo(DateTime.parse(a.createdAt.toString())));

                      return _commentsList(context, comments, setState, postId, _commentController, _commentService);
                    },
                  );
                },
              ),
            ),
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    );
  }

  static Widget _loadingWidget() {
    return SizedBox(
      height: 300,
      child: Center(
        child: Lottie.asset(
          AssetImages.loading,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

 static Widget _noCommentsWidget(
    BuildContext context, TextEditingController commentController, 
    StateSetter setState, CommentService commentService, String postId) {
  return Container(
    height: 300,
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomText(
          text: 'لا توجد تعليقات حالياً.',
          textColor: Colors.grey,
          fontSize: 16,
        ),
        const SizedBox(height: 16),
        _commentInput(commentController, setState, commentService, postId),
      ],
    ),
  );
}

  static Widget _commentsList(BuildContext context, List<Comment> comments,
      StateSetter setState, String postId, TextEditingController commentController, CommentService commentService) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _commentsHeader(context, comments.length),
          const Divider(),
          _commentsView(context, comments, setState, commentController, commentService, postId),
          const Divider(),
          _commentInput(commentController, setState, commentService, postId),
        ],
      ),
    );
  }

  static Widget _commentsHeader(BuildContext context, int commentCount) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: 'التعليقات ($commentCount)',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            textColor: Colors.green,
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  static Widget _commentsView(BuildContext context, List<Comment> comments,
      StateSetter setState, TextEditingController commentController, CommentService commentService, String postId) {
    return Expanded(
      child: SizedBox(
        height: 300,
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: comments.length,
          itemBuilder: (context, index) {
            final comment = comments[index];
            final createdAt = DateTime.parse(comment.createdAt.toString());
            final commentDate = timeago.format(createdAt);
            return TweenAnimationBuilder<Offset>(
              duration: const Duration(milliseconds: 500),
              tween: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ),
              curve: Curves.easeInOut,
              builder: (context, offset, child) {
                return Transform.translate(
                  offset: offset,
                  child: child,
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade400,
                      child: comment.id != null
                          ? ClipOval(
                              child: Image.network(
                             baseUrl+   comment.user!.profilePhoto!,
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                              ),
                            )
                          : const Icon(Icons.person, color: Colors.white),
                    ),
                    title: CustomText(
                      text: comment.user!.name ?? 'مستخدم مجهول',
                      fontWeight: FontWeight.bold,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: commentDate,
                          fontSize: 12,
                          textColor: Colors.grey.shade600,
                        ),
                        CustomText(
                          text: comment.text ?? '',
                          fontSize: 14,
                          textColor: Colors.black,
                        ),
                      ],
                    ),
                    trailing: _commentActions(context, comment, setState, commentController, commentService, postId),
                    onTap: () {
                      showSingleCommentDialog(context, comment);
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

static Widget _commentActions(BuildContext context, Comment comment,
    StateSetter setState, TextEditingController commentController, CommentService commentService, String postId) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        icon: Icon(Icons.edit_note_rounded, color: AppColors.actionButton),
        onPressed: () {
          showUpdateDialog(context, comment.id!, commentController, setState);
        },
      ),
      IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () async {
          bool? confirmDelete = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('تأكيد الحذف'),
                content: const Text('هل أنت متأكد أنك تريد حذف هذا التعليق؟'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('إلغاء'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('حذف'),
                  ),
                ],
              );
            },
          );

          if (confirmDelete == true) {
            setState(() {
            });

            Get.snackbar(
              'جاري الحذف...',
              'يرجى الانتظار',
              backgroundColor: Colors.orange,
              colorText: Colors.white,
              duration: Duration(seconds: 2),
              snackPosition: SnackPosition.BOTTOM,
            );

            bool success = await commentService.deleteComment(comment.id!);
            if (success) {
              setState(() {});
              Get.snackbar(
                'نجاح',
                'تم حذف التعليق بنجاح!',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            } else {
              Get.snackbar(
                'خطأ',
                'تعذر حذف التعليق. حاول مرة أخرى.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
          }
        },
      ),
    ],
  );
}

  static Widget _commentInput(TextEditingController commentController, StateSetter setState,
      CommentService commentService, String postId) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: commentController,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: 'اكتب تعليق...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                suffixIcon: IconButton(
                  icon:  Icon(Icons.send, color: AppColors.actionButton),
                  onPressed: () async {
                    final text = commentController.text;
                    if (text.isNotEmpty) {
                      bool success = await commentService.postComment(postId, text);
                      if (success) {
                        commentController.clear();
                        setState(() {});
                        Get.snackbar('نجاح', 'تم إرسال تعليقك بنجاح!', snackPosition: SnackPosition.BOTTOM);
                      } else {
                        Get.snackbar('خطأ', 'تعذر إرسال تعليقك. حاول مرة أخرى.', snackPosition: SnackPosition.BOTTOM);
                      }
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
