//
//  ListController.swift
//  List
//
//  Created by Xiaoheng Pan on 9/7/19.
//  Copyright © 2019 Xiaoheng Pan. All rights reserved.
//

import UIKit
import CoreData

protocol TodoListDelegate: AnyObject {
    func editTodoList(list: List)
    func addTodoList(description: String, date: Date?)
}

class NewListViewController: UIViewController {

    weak var delegate: TodoListDelegate?
    
    var list: List? {
        didSet {
            textView.text = list?.name
            textView.textColor = .black
        }
    }

    private let textView: UITextView = {
        let tv = UITextView()
        tv.text = "Describe what this list is for"
        tv.textColor = .lightGray
        tv.textAlignment = .left
        tv.font = UIFont.homeListLabel
        return tv
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.homeListLabel
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        textView.delegate = self
        setupNavigationBar()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = list == nil ? "Create New List" : "Edit List"
    }

    private func setupUI() {
        view.addSubview(textView)
        view.addConstraintsWithFormat("H:|-[v0]-|", views: textView)
        view.addConstraintsWithFormat("V:|-[v0]-|", views: textView)
    }

    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }

    @objc private func handleCancel() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func handleSave() {
        list == nil ? createList() : editList()
    }

    private func createList() {
        guard let text = textView.text, text != "Describe what this list is for" else { return }
        dismiss(animated: true) {
            self.delegate?.addTodoList(description: self.textView.text, date: nil)
        }
    }

    private func editList() {
        dismiss(animated: true) {
            guard let list = self.list else { return }
            list.name = self.textView.text
            self.delegate?.editTodoList(list: list)
        }
    }
}

extension NewListViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .lightGray else { return }
        textView.textColor = .black
        textView.text = nil
    }
}
