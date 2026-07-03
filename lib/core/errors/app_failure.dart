class AppFailure implements Exception {
  const AppFailure(this.message, {this.code});

  final String message;
  final String? code;

  @override
  String toString() {
    if (code == null) {
      return 'AppFailure: $message';
    }

    return 'AppFailure($code): $message';
  }
}
