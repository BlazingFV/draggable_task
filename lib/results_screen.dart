import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loshical/hugged_child.dart';
import 'package:loshical/providers/result_provider.dart';

import 'app_router.dart';

class ResultScreen extends ConsumerStatefulWidget {
  final String? id;
  const ResultScreen({
    super.key,
    this.id,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animationTween;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    );
    _animationTween =
        Tween(begin: 0.5, end: 7.0).animate(_animationController!);
    _animationController!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          widget.id == '5' ? 'Correct Answer !' : "Wrong Answer !",
          style: TextStyle(
              color: ref.watch(resultRepositoryProvider).isCorrectAnswer
                  ? Colors.green
                  : Colors.red,
              fontWeight: FontWeight.w700,
              fontSize: 23),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.id == '5'
              ? const Center(
                  child: Text(
                    'Congratulations !\nYou Chose the Correct Answer ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : const Center(
                  child: Text(
                    'Game Over !\nBetter Luck Next Time',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      height: 1.5,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
          const SizedBox(height: 16),
          Center(
              child:
                  HuggedChild(child: Image.asset('assets/a${widget.id}.png'))),
          const SizedBox(height: 50),
          Center(
            child: GestureDetector(
                onTapDown: _onTapDown,
                onTapUp: _onTapUp,
                // onTap: () {

                // },
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  elevation: _animationTween!.value,
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: ref.watch(resultRepositoryProvider).isCorrectAnswer
                          ? Colors.green
                          : Colors.red,
                    )),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Restart',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ref
                                    .watch(resultRepositoryProvider)
                                    .isCorrectAnswer
                                ? Colors.green
                                : Colors.red,
                            height: 1.5,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.restart_alt_rounded,
                          color: ref
                                  .watch(resultRepositoryProvider)
                                  .isCorrectAnswer
                              ? Colors.green
                              : Colors.red,
                          size: 34,
                        ),
                      ],
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }

  void _onTapDown(TapDownDetails details) async {
    _animationController!.forward();
  }

  void _onTapUp(TapUpDetails details) async {
    _animationController!.reverse();
    await Future.delayed(const Duration(milliseconds: 500), () {
      ref.watch(resultRepositoryProvider).resetGame();
      if (ref.watch(resultRepositoryProvider).selectedImage == '') {
        context.pushReplacementNamed(AppRoute.startPage.name);
      }
    });
  }
}
