abstract class BaseLocalSource<T> {
  Future<List<T>> getAll();
  Future<void> store(T data);
  Future<void> update(T data);
  Future<void> delete(T data);
}
