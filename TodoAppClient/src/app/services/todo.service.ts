import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export interface ToDoItem {
  id: number;
  task: string;
  isCompleted: boolean;
}

@Injectable({
  providedIn: 'root',
})
export class TodoService {
  private apiUrl = 'https://localhost:5001/api/TodoItems';

  constructor(private http: HttpClient) { }

  getTodos(): Observable<ToDoItem[]> {
    return this.http.get<ToDoItem[]>(this.apiUrl);
  }

  addTodo(todo: ToDoItem): Observable<ToDoItem> {
    return this.http.post<ToDoItem>(this.apiUrl, todo);
  }

  updateTodo(todo: ToDoItem): Observable<void> {
    return this.http.put<void>(`${this.apiUrl}/${todo.id}`, todo);
  }

  deleteTodo(id: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/${id}`);
  }
}
