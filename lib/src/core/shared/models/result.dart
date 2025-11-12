class Result {
  final bool isSuccess;
  final String? message;

  Result.success()
      : isSuccess = true,
        message = null;

  Result.failure(this.message) : isSuccess = false;

  bool get isError => !isSuccess;
}
