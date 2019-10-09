//
//  TodoTableViewController.swift
//  TodoList
//
//  Created by Muhammad Ashary on 06/10/19.
//  Copyright © 2019 M. Ashary. All rights reserved.
//

import UIKit

class TodoTableViewController: UITableViewController, TodoCellDelegate {
    
    var todos = [Todo]()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let saveTodos = Todo.loadTodos() {
            todos = saveTodos
        } else {
            todos = Todo.loadSampleTodos()
        }
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCellIdentifier", for: indexPath) as? TodoCell else {
            fatalError("Could not dequeue a cell")
        }
        
        let todo = todos[indexPath.row]
        cell.titleLabel.text = todo.title
        cell.isCompleteButton.isSelected = todo.isComplete
        cell.delegate = self
        return cell
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Todo.saveTodos(todos)
        }
    }
    
    // MARK: - Todo cell delegate
    
    func checkmarkTapped(sender: TodoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var todo = todos[indexPath.row]
            todo.isComplete = !todo.isComplete
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            Todo.saveTodos(todos)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditTodo",
            let navController = segue.destination as? UINavigationController,
            let todoDetailTableViewController = navController.topViewController as? TodoDetailTableViewController {
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedTodo = todos[indexPath.row]
            todoDetailTableViewController.todo = selectedTodo
        }
    }
    
    // MARK: - Actions
    
    @IBAction func unwindToTodoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as! TodoDetailTableViewController
        
        if let todo = sourceViewController.todo {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                todos[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: todos.count, section: 0)
                todos.append(todo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        
        Todo.saveTodos(todos)
    }
    
}
