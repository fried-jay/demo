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

    useEffect(() {
      _hasCompleted.value = todos.any((todo) => todo.isCompleted);
      return null;
    }, [ todos ]);
  }
 
  final _todos = useState<List<Todo>>([]);
  List<Todo> get todos => _todos.value;

  final _newTodoTextController = useTextEditingController();
  TextEditingController get newTodoTextController => _newTodoTextController;

  final _hasCompleted = useState<bool>(false);
  bool get hasCompleted => _hasCompleted.value;
 
  _init() {
    showLoading(context: context);
    _todos.value = [
      Todo(id: '1', title: '샘플 투두 1', createdAt: DateTime.now()),
      Todo(id: '2', title: '샘플 투두 2', createdAt: DateTime.now()),
      Todo(id: '3', title: '샘플 투두 3', createdAt: DateTime.now()),
    ];
    hideLoading(context: context);
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
    // rebuild();
  }

  void toggleTodo(String id) {
    _todos.value = _todos.value.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(isCompleted: !todo.isCompleted);
      }
      return todo;
    }).toList();
  }

  void deleteTodo(String id) {
    _todos.value = _todos.value.where((todo) => todo.id != id).toList();
  }

  void deleteAllCompleted() {
    _todos.value = _todos.value.where((todo) => !todo.isCompleted).toList();
  }
}
