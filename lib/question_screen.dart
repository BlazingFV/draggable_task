import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loshical/answer_image.dart';
import 'package:loshical/app_router.dart';
import 'package:loshical/assets.dart';
import 'package:loshical/how_to_play_screen.dart';
import 'package:loshical/providers/result_provider.dart';
import 'package:loshical/question_image.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  String caughtData = '';
  bool isSuccessful = false;
  Color errorColor = Colors.red;
  Color correctColor = Colors.green;
  Color color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loshical'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => const HowToPlayScreen()));
            },
            icon: const Icon(Icons.info_outlined),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              const Text('Choose the image that completes the pattern: '),
              const SizedBox(
                height: 16,
              ),
              Consumer(builder: (context, ref, _) {
                return Wrap(
                  children: AssetManager.questionPaths
                      .map(
                        (e) => DragTarget<String>(
                          onAccept: (val) {
                            ref.watch(resultRepositoryProvider).selectedImage =
                                val;

                            final intValue = int.parse(ref
                                .watch(resultRepositoryProvider)
                                .selectedImage
                                .replaceAll(RegExp('[^0-9]'), ''));

                            if (val == 'assets/a5.png') {
                              ref
                                  .watch(resultRepositoryProvider)
                                  .isCorrectAnswer = true;
                            } else {
                              ref
                                  .watch(resultRepositoryProvider)
                                  .isCorrectAnswer = false;
                            }

                            if (ref
                                    .watch(resultRepositoryProvider)
                                    .selectedImage !=
                                '') {
                              Future.delayed(const Duration(milliseconds: 250),
                                  () {
                                context.pushReplacementNamed(
                                  AppRoute.resultScreen.name,
                                  pathParameters: {'id': '$intValue'},
                                );
                              });
                            }
                          },
                          onWillAccept: (data) {
                            if (data == "assets/a5.png") {
                              setState(() {
                                isSuccessful = true;
                                caughtData = data!;
                                color = correctColor;
                              });
                            } else {
                              setState(() {
                                isSuccessful = true;
                                caughtData = data!;
                                color = errorColor;
                              });
                            }
                            return true;
                          },
                          onLeave: (val) {
                            setState(() {
                              isSuccessful = false;
                              // caughtData = ;
                              color = Colors.transparent;
                            });
                          },
                          builder: (context, acceptedData, rejectedData) {
                            if (isSuccessful && e == 'assets/q2.png') {
                              return Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: color, width: 3)),
                                child: QuestionImage(
                                  assetPath: caughtData,
                                ),
                              );
                            } else {
                              return QuestionImage(
                                assetPath: e,
                              );
                            }
                          },
                        ),
                      )
                      .toList(),
                );
              }),
              const Spacer(),
              const Text('Which of the shapes below continues the sequence'),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                children: AssetManager.answerPaths
                    .map(
                      (e) => Draggable<String>(
                        data: e.toString(),
                        onDraggableCanceled: (velocity, offset) {},
                        onDragCompleted: () {},
                        feedback: AnswerImage(
                          assetPath: e,
                        ),
                        child: AnswerImage(
                          assetPath: e,
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: 42,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
