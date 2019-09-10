//
//  ViewController.swift
//  List
//
//  Created by Xiaoheng Pan on 9/5/19.
//  Copyright © 2019 Xiaoheng Pan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    private var viewModel = ListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        viewModel.fetchTodoLists()
    }

    private func setupTableView() {
        tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        view.backgroundColor = .white
    }

    private func setupNavigationBar() {
        navigationItem.title = "To Do Lists"
        let image = UIImage(named: "PlusButton")?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleAdd))
    }

    @objc private func handleAdd() {
        let newListViewController = NewListViewController()
        let navigationController = BaseNavigationController(rootViewController: newListViewController)
        newListViewController.delegate = self
        present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate
extension HomeTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.reuseIdentifier, for: indexPath) as? HomeCell else {
            return UITableViewCell()
        }

        cell.configureCell(listViewModel: viewModel, indexPath: indexPath)
        return cell
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.todoLists.count
    }
}

// MARK: - UITableViewDataSource
extension HomeTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (_, indexPath) in
            let editTodoListViewController = NewListViewController()
            let navigationController = BaseNavigationController(rootViewController: editTodoListViewController)
            editTodoListViewController.delegate = self
            editTodoListViewController.list = self.viewModel.todoLists[indexPath.row]
            self.present(navigationController, animated: true, completion: nil)
        }

        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
            self.viewModel.deleteTodoList(index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }

        return [deleteAction, editAction]
    }
}

// MARK: - TodoListDelegate
extension HomeTableViewController: TodoListDelegate {
    func editTodoList(list: List) {
        guard let row = viewModel.todoLists.firstIndex(of: list) else { return }
        viewModel.saveTodoList()
        let reloadIndexPath = IndexPath(row: row, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: .middle)
    }

    func addTodoList(description: String, date: Date?) {
        viewModel.addTodoList(description: description, date: date)
        let newIndexPath = IndexPath(row: viewModel.todoLists.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
}
