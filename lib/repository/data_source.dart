class DataSource<K, V> {
  final _value = <K, V>{};

  setValue(K key, V value) {
    _value[key] = value;
  }

  V? getValue(K key) {
    return _value[key];
  }

  delete(K key) {
    _value.remove(key);
  }

  int length() {
    return _value.length;
  }

  void clear() {
    _value.clear();
  }
}
