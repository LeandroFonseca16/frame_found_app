import 'package:flutter/cupertino.dart';
import 'package:frame_found_app/shared/core/result.dart';

abstract class Command<TSuccess, TFailure> extends ChangeNotifier {
  bool _isRunning = false;

  bool get isRunning => _isRunning;

  Result<TSuccess, TFailure>? _result;

  Result<TSuccess, TFailure>? get result => _result;

  bool get isSuccess => _result is Success;

  bool get isFailure => _result is Failure;

  Future<void> _execute(Future<Result<TSuccess, TFailure>> Function() action) async {
    if(_isRunning) return;

    _result = null;
    _isRunning = true;
    notifyListeners();
    _result = await action();
    _isRunning = false;
    notifyListeners();
  }
}

class Command0<TSuccess, TFailure> extends Command<TSuccess, TFailure> {
  final Future<Result<TSuccess, TFailure>> Function() _action;
  Command0(this._action);
  Future<void> execute() => _execute(_action);
}

class Command1<TParam, TSuccess, TFailure> extends Command<TSuccess, TFailure> {
  final Future<Result<TSuccess, TFailure>> Function(TParam) _action;
  Command1(this._action);
  Future<void> execute(TParam param) => _execute(() => _action(param));
}