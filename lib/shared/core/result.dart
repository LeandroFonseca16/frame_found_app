sealed class Result<TSuccess, TFailure> {
  TSuccess? getOrNull() {
    if (this is Success) {
      return (this as Success)._value;
    }
    return null;
  }

  TFailure? getOrNullFailure() {
    if (this is Failure) {
      return (this as Failure)._value;
    }
    return null;
  }

  T fold<T>(T Function(TSuccess) onSuccess, T Function(TFailure) onFailure) {
    if (this is Success) {
      return onSuccess((this as Success)._value);
    } else {
      return onFailure((this as Failure)._value);
    }
  }

}

class Success<TSuccess, TFailure> extends Result<TSuccess, TFailure> {
  final TSuccess _value;

  Success(this._value);
}

class Failure<TSuccess, TFailure> extends Result<TSuccess, TFailure> {
  final TFailure _value;

  Failure(this._value);
}
