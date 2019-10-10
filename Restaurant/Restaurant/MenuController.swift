//
//  MenuController.swift
//  Restaurant
//
//  Created by Muhammad Ashary on 10/10/19.
//  Copyright © 2019 M. Ashary. All rights reserved.
//

import UIKit

class MenuController {
    static let shared = MenuController()
    
    static var order = Order() {
        didSet {
            NotificationCenter.default.post(name: MenuController.orderUpdatedNotification, object: nil)
        }
    }
    
    static let orderUpdatedNotification = Notification.Name("MenuController.orderUpdated")
    
    private var itemsByID = [Int: MenuItem]()
    private var itemsByCategory = [String: [MenuItem]]()
    
    func item(withID itemID: Int) -> MenuItem? {
        return itemsByID[itemID]
    }
    
    func items(forCategory category: String) -> [MenuItem]? {
        return itemsByCategory[category]
    }
    
    var categories: [String] {
        get {
            return itemsByCategory.keys.sorted()
        }
    }
    
    private func process(_ items: [MenuItem]) {
        itemsByID.removeAll()
        itemsByCategory.removeAll()
        
        for item in items {
            itemsByID[item.id] = item
            itemsByCategory[item.category, default: []].append(item)
        }
    }
    
    func loadRemoteData() {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        let components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        let menuURL = components.url!
        
        let task = URLSession.shared.dataTask(with: menuURL) { (data, _, _) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
                self.process(menuItems.items)
            }
        }
        task.resume()
    }
    
    let baseURL = URL(string: "http://localhost:8090/")!
    
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoryURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let categories = try? jsonDecoder.decode(Categories.self, from: data) {
                completion(categories.categories)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func submitOrder(forMenuIDs menuIds: [Int], completion: @escaping (Int?) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data: [String: [Int]] = ["menuIds": menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data) {
                completion(preparationTime.prepTime)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchMenuItems(forCategory categoryName: String, completion: @escaping ([MenuItem]?) -> Void) {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        let task = URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
                completion(menuItems.items)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func loadOrder() {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let orderFileURL = documentDirectoryURL.appendingPathComponent("order").appendingPathExtension("json")
        
        guard let data = try? Data(contentsOf: orderFileURL) else { return }
        MenuController.order = (try? JSONDecoder().decode(Order.self, from: data)) ?? Order(menuItems: [])
    }
    
    func saveOrder() {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let orderFileURL = documentDirectoryURL.appendingPathComponent("order").appendingPathExtension("json")
        
        if let data = try? JSONEncoder().encode(MenuController.order) {
            try? data.write(to: orderFileURL)
        }
    }
    
    func loadItems() {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let menuItemsFileURL = documentDirectoryURL.appendingPathComponent("menuItems").appendingPathExtension("json")
        
        guard let data = try? Data(contentsOf: menuItemsFileURL) else { return }
        let items = (try? JSONDecoder().decode([MenuItem].self, from: data)) ?? []
        process(items)
    }
    
    func saveItems() {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let menuItemsFileURL = documentDirectoryURL.appendingPathComponent("menuItems").appendingPathExtension("json")
        
        let items = Array(itemsByID.values)
        if let data = try? JSONEncoder().encode(items) {
            try? data.write(to: menuItemsFileURL)
        }
    }
}
