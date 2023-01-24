// login exception
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

// register exception
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

class NetworkRequestFailAuthException implements Exception {}

// generic exceptions

class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
