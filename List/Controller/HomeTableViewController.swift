//
//  ViewController.swift
//  List
//
//  Created by Xiaoheng Pan on 9/5/19.
//  Copyright © 2019 Xiaoheng Pan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    private var todoLists = [
        ListModel(name: "place holder 1"),
        ListModel(name: "place holder 2"),
        ListModel(name: "place holder 3"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
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

// MARK: - UITableViewDataSource
extension HomeTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.reuseIdentifier, for: indexPath) as? HomeCell else {
            return UITableViewCell()
        }

        let model = todoLists[indexPath.row]
        cell.configureCell(listModel: model)
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoLists.count
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
}

// MARK: - CreateTodoListDelegate
extension HomeTableViewController: CreateTodoListDelegate {
    func AddTodoList(listModel: ListModel) {
        todoLists.append(listModel)
        let newIndexPath = IndexPath(row: todoLists.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
}
