class MapperException<From, To> implements Exception {
  final String message;

  MapperException(this.message);

  @override
  String toString() => 'Error when mapping class $From to $To: $message';
}
