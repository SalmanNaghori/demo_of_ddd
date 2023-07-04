import 'package:demo_of_ddd/domain/core/failures.dart';

class UnexPectedValueError extends Error {
  final ValueFailure valueFailure;

  UnexPectedValueError(this.valueFailure);

  @override
  String toString() {
    const explanation =
        'Encountered a ValueFailure at an unrecoverable point. Terminating.';
    return Error.safeToString('$explanation Failure was: $valueFailure');
  }
}
