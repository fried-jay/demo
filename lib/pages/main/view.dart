import 'package:flutter/material.dart'; 
import 'package:demo/pages/base/view.dart';
import 'package:demo/pages/main/viewModel.dart';
import 'package:demo/models/todo.dart';

class MainView extends BaseView<MainViewModel> {
  const MainView({super.key, required super.context, required super.viewModel});

  @override
  Widget buildBody() => _buildTodoList();
  
  Widget _buildTodoList() {
    final todos = viewModel.todos;
    // final hasCompleted = todos.any((todo) => todo.isCompleted); 
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTodoEditor(),
          const SizedBox(height: 16),
          _buildAddTodoButton(),
          const SizedBox(height: 16),
          if (viewModel.hasCompleted)
            _buildDeleteAllCompletedButton(),
          if (todos.isEmpty)
            _buildEmptyTodoText()
          else
            ...todos.map((todo) => _buildTodoItem(todo)),
        ],
      ),
    );
  } 

  Widget _buildTodoEditor() {
    return TextField(
      controller: viewModel.newTodoTextController,
      decoration: const InputDecoration(
        hintText: '새로운 투두를 입력하세요...',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildAddTodoButton() {
    return ElevatedButton(
      onPressed: () {
        viewModel.addTodo(viewModel.newTodoTextController.text);
      },
      child: const Icon(Icons.add),
    );
  }

  Widget _buildDeleteAllCompletedButton() {
    return TextButton(
      onPressed: viewModel.deleteAllCompleted,
      child: const Text('완료된 항목 삭제'),
    );
  }

  Widget _buildEmptyTodoText() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 32.0),
      child: Text(
        '투두가 없습니다.\n새로운 투두를 추가해보세요!',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
  
  Widget _buildTodoItem(Todo todo) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) => viewModel.toggleTodo(todo.id),
        ),
        title: Text(todo.title),
      ),
    );
  }
}