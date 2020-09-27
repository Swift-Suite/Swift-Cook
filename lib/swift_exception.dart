// File: swift_exception
// this defines all of our exceptions

//
class BaseException implements Exception {
  String context;
  String cause;
  BaseException(this.context, this.cause);
}

class DatabaseWriteException extends BaseException {
  DatabaseWriteException(context, cause) : super(context, cause);
}

class DatabaseReadException extends BaseException {
  DatabaseReadException(context, cause) : super(context, cause);
}
