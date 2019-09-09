//
//  ListViewModel.swift
//  List
//
//  Created by Xiaoheng Pan on 9/8/19.
//  Copyright © 2019 Xiaoheng Pan. All rights reserved.
//

import Foundation

class ListViewModel {
    var todoLists = [ListModel]()

    func addTodoList(description: String, date: Date?) {
        let listModel = ListModel(name: description, date: date)
        todoLists.append(listModel)
    }

    func deleteTodoList(index: Int) {
        todoLists.remove(at: index)
    }

    func editTodoList(list: ListModel, index: Int) {
        todoLists[index].name = list.name
        todoLists[index].date = list.date
    }
}
