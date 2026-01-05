import 'package:demo/pages/base/viewModel.dart';
import 'package:demo/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MainViewModel extends BaseViewModel {
  MainViewModel({required super.context, required super.ref}) {
    useEffect(() {
      _init();
      return null;
    }, []);
  }

  final _todos = useState<List<Todo>>([]);
  List<Todo> get todos => _todos.value;

  final _newTodoTextController = useTextEditingController();
  TextEditingController get newTodoTextController => _newTodoTextController;

  _init() {
    _todos.value = [
      Todo(id: '1', title: '샘플 투두 1', createdAt: DateTime.now()),
      Todo(id: '2', title: '샘플 투두 2', createdAt: DateTime.now()),
      Todo(id: '3', title: '샘플 투두 3', createdAt: DateTime.now()),
      Todo(id: '4', title: '샘플 투두 4', createdAt: DateTime.now()),
      Todo(id: '5', title: '샘플 투두 5', createdAt: DateTime.now()),
      Todo(id: '6', title: '샘플 투두 6', createdAt: DateTime.now()),
      Todo(id: '7', title: '샘플 투두 7', createdAt: DateTime.now()),
      Todo(id: '8', title: '샘플 투두 8', createdAt: DateTime.now()),
      Todo(id: '9', title: '샘플 투두 9', createdAt: DateTime.now()),
    ];
  }

  void addTodo(String title) {
    if (title.trim().isEmpty) return;
    
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
      createdAt: DateTime.now(),
    );
    
    _todos.value = [..._todos.value, newTodo];
    newTodoTextController.clear();
    rebuild();
  }

  void toggleTodo(String id) {
    _todos.value = _todos.value.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(isCompleted: !todo.isCompleted);
      }
      return todo;
    }).toList();
    rebuild();
  }

  void deleteTodo(String id) {
    _todos.value = _todos.value.where((todo) => todo.id != id).toList();
    rebuild();
  }

  void deleteAllCompleted() {
    _todos.value = _todos.value.where((todo) => !todo.isCompleted).toList();
    rebuild();
  }
}
