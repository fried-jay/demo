import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:demo/repository/data_source.dart';

part 'mock.g.dart';

@Riverpod(keepAlive: true)
class MockRepository extends _$MockRepository {
  @override
  DataSource<int, List<int>> build() {
    return DataSource<int, List<int>>();
  }

  void addMock(int num) {
    state.setValue(num, [...state.getValue(num) ?? [], num]);
  }

  void deleteMock(int num) {
    state.delete(num);
  }

  void clearMock() {
    state.clear();
  }
}
