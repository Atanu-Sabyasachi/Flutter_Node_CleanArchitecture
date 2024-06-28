class Failure {
  final String message;
  final int statusCode;
  Failure([
    this.message = "An unexpected error occured !",
    this.statusCode = 500,
  ]);
}
