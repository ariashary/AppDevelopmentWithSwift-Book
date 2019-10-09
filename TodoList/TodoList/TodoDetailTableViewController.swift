//
//  TodoDetailTableViewController.swift
//  TodoList
//
//  Created by Muhammad Ashary on 06/10/19.
//  Copyright © 2019 M. Ashary. All rights reserved.
//

import UIKit

class TodoDetailTableViewController: UITableViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var todo: Todo?

    var isPickerHidden = true
    
    let dateLabelIndexPath = IndexPath(row: 1, section: 0)
    let datePickerIndexPath = IndexPath(row: 2, section: 0)
    let notesTextViewIndexPath = IndexPath(row: 0, section: 1)
    
    let normalCellHeight: CGFloat = 44
    let largeCellHeight: CGFloat = 200
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todo = todo {
            navigationItem.title = "To-Do"
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
        } else {
            dueDatePickerView.date = Date().addingTimeInterval(24 * 60 * 60)
        }
        
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
    }
    
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = Todo.dueDateFormatter.string(from: date)
    }
    
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath:
            return isPickerHidden ? 0 : dueDatePickerView.frame.height
        case notesTextViewIndexPath:
            return largeCellHeight
        default:
            return normalCellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == dateLabelIndexPath {
            isPickerHidden = !isPickerHidden
            dueDateLabel.textColor = isPickerHidden ? .black : tableView.tintColor
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func textEditingChanged(_ sender: Any) {
        updateSaveButtonState()
    }
    
    @IBAction func returnPressed(_ sender: Any) {
        titleTextField.resignFirstResponder()
    }
    
    @IBAction func isCompleteButtonTapped(_ sender: Any) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
        
        todo = Todo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
    }
    
}
