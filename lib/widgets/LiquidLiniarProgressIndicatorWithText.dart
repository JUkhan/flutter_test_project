import 'dart:async';

import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:rxdart/rxdart.dart';

class FakeUpload {
  final BehaviorSubject<double> _subject = BehaviorSubject.seeded(0.0);
  bool _isCancelled = false;
  bool get isCancelled => _isCancelled;

  Stream<double> get uploadProgress => _subject.stream;

  FakeUpload() {
    _subject.doOnDone(() {
      _subject.close();
    });
    _initUpload();
  }

  void _initUpload() async {
    int milliseconds = 400;
    while (_subject.value < 1) {
      await Future.delayed(Duration(milliseconds: milliseconds));

      if (!_isCancelled) {
        _subject.add(_subject.value + 0.2);
        milliseconds += 400;
      } else {
        break;
      }
    }
    _subject.close();
  }

  void cancel() {
    _isCancelled = true;
    _subject.close();
  }
}

class LiquidLinearProgressIndicatorWithText extends ImplicitlyAnimatedWidget {
  final double percent;

  LiquidLinearProgressIndicatorWithText({
    Key key,
    @required this.percent,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.linear,
  }) : super(duration: duration, curve: curve, key: key);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _LiquidLinearProgressIndicatorWithTextState();
}

class _LiquidLinearProgressIndicatorWithTextState
    extends AnimatedWidgetBaseState<LiquidLinearProgressIndicatorWithText> {
  Tween _tween;

  @override
  Widget build(BuildContext context) {
    return LiquidLinearProgressIndicator(
      value: _tween.evaluate(animation),
      valueColor:
          AlwaysStoppedAnimation(Theme.of(context).primaryColor.withAlpha(150)),
      backgroundColor: Colors.white,
      borderColor: Theme.of(context).primaryColor,
      borderWidth: 0,
      borderRadius: 0,
      center: Text(
        '${(_tween.evaluate(animation) * 100).ceil().toString()}%',
        style: TextStyle(color: Colors.black87, fontSize: 16),
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor visitor) {
    _tween = visitor(_tween, (widget.percent), (value) => Tween(begin: value));
  }
}
/*LiquidLinearProgressIndicatorWithText(
                            percent: state is FormBlocSubmitting
                                ? state.progress
                                : state is FormBlocSuccess ? 1.0 : 0.0,
                          )*/
