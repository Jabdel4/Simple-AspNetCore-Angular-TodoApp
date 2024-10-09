import { Component, OnInit } from '@angular/core';
import { TodoService, TodoItem } from '../../services/todo.service';

@Component({
  selector: 'app-todo',
  templateUrl: './todo.component.html',
  styleUrls: ['./todo.component.css'],
})
export class TodoComponent implements OnInit {
  todos: TodoItem[] = [];
  newTodo: string = '';

  constructor(private todoService: TodoService) { }

  ngOnInit(): void {
    this.getTodos();
  }

  getTodos(): void {
    this.todoService.getTodos().subscribe((todos) => (this.todos = todos));
  }

  addTodo(): void {
    if (this.newTodo.trim()) {
      const newToDoItem: TodoItem = {
        id: 0,
        task: this.newTodo,
        isCompleted: false,
      };

      this.todoService.addTodo(newToDoItem).subscribe(() => {
        this.getTodos();
        this.newTodo = '';
      });
    }
  }

  toggleCompletion(todo: TodoItem): void {
    todo.isCompleted = !todo.isCompleted;
    this.todoService.updateTodo(todo).subscribe();
  }

  deleteTodo(id: number): void {
    this.todoService.deleteTodo(id).subscribe(() => this.getTodos());
  }
}
