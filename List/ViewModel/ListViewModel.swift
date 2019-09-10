//
//  ListViewModel.swift
//  List
//
//  Created by Xiaoheng Pan on 9/8/19.
//  Copyright © 2019 Xiaoheng Pan. All rights reserved.
//

import CoreData
import UIKit

class ListViewModel {

    var todoLists = [List]()
    private let context = CoreDataStack.shared.persistentContainer.viewContext

    func fetchTodoLists() {
        let fetchRequest = NSFetchRequest<List>(entityName: "List")

        do {
            let lists = try context.fetch(fetchRequest)
            self.todoLists = lists
        } catch let error {
            print("Failed to fetch todo lists: \(error)")
        }
    }

    func addTodoList(description: String, date: Date) {
        let todoLists = NSEntityDescription.insertNewObject(forEntityName: "List", into: context)
        todoLists.setValue(description, forKey: "name")
        todoLists.setValue(date, forKey: "date")
        saveTodoList()
    }

    func deleteTodoList(index: Int) {
        context.delete(todoLists[index])
        saveTodoList()
    }

    func resetTodoLists() {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: List.fetchRequest())
        do {
            try context.execute(deleteRequest)
        } catch let error {
            print("Batch delete request failed: \(error)")
        }
    }

    func saveTodoList() {
        do {
            try context.save()
            fetchTodoLists()
        } catch let error {
            print("Failed to save: \(error)")
        }
    }
}
