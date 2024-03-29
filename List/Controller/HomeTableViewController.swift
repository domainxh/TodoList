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
        navigationItem.title = NSLocalizedString("HomeVC.NavigationTitle.TodoList", comment: "")
        let plusImage = UIImage(named: "PlusButton")?.withRenderingMode(.alwaysOriginal)
        let resetImage = UIImage(named: "ResetButton")?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(handleAdd))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: resetImage, style: .plain, target: self, action: #selector(handleReset))
    }

    @objc private func handleAdd() {
        let newListViewController = NewListViewController()
        let navigationController = BaseNavigationController(rootViewController: newListViewController)
        newListViewController.delegate = self
        present(navigationController, animated: true, completion: nil)
    }

    @objc private func handleReset() {
        viewModel.resetTodoLists()
    // This provides a smoother animation over over tableView.reloadData()
        var indexPathsToRemove = [IndexPath]()

        for (index, _) in viewModel.todoLists.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            indexPathsToRemove.append(indexPath)
        }
        
        viewModel.todoLists.removeAll()
        tableView.deleteRows(at: indexPathsToRemove, with: .left)
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

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return FooterView()
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.todoLists.isEmpty ? 150 : 0
    }
}

// MARK: - UITableViewDataSource
extension HomeTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editTodoListViewController = NewListViewController()
        editTodoListViewController.delegate = self
        editTodoListViewController.list = viewModel.todoLists[indexPath.row]
        navigationController?.pushViewController(editTodoListViewController, animated: true)
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = NSLocalizedString("HomeVC.TableView.Delete", comment: "")
        let deleteAction = UITableViewRowAction(style: .destructive, title: delete) { (_, indexPath) in
            self.viewModel.deleteTodoList(index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction]
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

    func addTodoList(description: String, date: Date) {
        viewModel.addTodoList(description: description, date: date)
        let newIndexPath = IndexPath(row: viewModel.todoLists.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
}
