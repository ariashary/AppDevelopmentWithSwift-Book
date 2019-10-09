//
//  Todo.swift
//  TodoList
//
//  Created by Muhammad Ashary on 06/10/19.
//  Copyright © 2019 M. Ashary. All rights reserved.
//

import Foundation

struct Todo: Codable {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static var dueDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    
    static let DocumentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentDirectory.appendingPathComponent("todos").appendingPathExtension("plist")
    
    static func loadTodos() -> [Todo]? {
        guard let codedTodos = try? Data(contentsOf: ArchiveURL) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<Todo>.self, from: codedTodos)
    }
    
    static func saveTodos(_ todos: [Todo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedTodos = try? propertyListEncoder.encode(todos)
        try? codedTodos?.write(to: ArchiveURL, options: .noFileProtection)
    }
    
    static func loadSampleTodos() -> [Todo] {
        let todo1 = Todo(title: "Todo One", isComplete: false, dueDate: Date(), notes: "Notes 1")
        let todo2 = Todo(title: "Todo Two", isComplete: false, dueDate: Date(), notes: "Notes 2")
        let todo3 = Todo(title: "Todo Three", isComplete: false, dueDate: Date(), notes: "Notes 3")
        return [todo1, todo2, todo3]
    }
    
}
