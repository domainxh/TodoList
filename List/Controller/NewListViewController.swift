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
    func addTodoList(description: String, date: Date)
}

class NewListViewController: UIViewController {

    weak var delegate: TodoListDelegate?
    private let dateLabelHeight = 30
    private let currentDate = Date()
    
    var list: List? {
        didSet {
            textView.text = list?.name
            textView.textColor = .black
            dateLabel.text = list?.date?.convertToStringWithDetail()
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

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.text = self.currentDate.convertToStringWithDetail()
        label.textAlignment = .center
        label.font = UIFont.subtitleLabel
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
        view.addSubviews(textView, dateLabel)
        view.addConstraintsWithFormat("H:|-[v0]-|", views: textView)
        view.addConstraintsWithFormat("H:|-[v0]-|", views: dateLabel)
        view.addConstraintsWithFormat("V:|-14-[v0(\(dateLabelHeight))]-[v1]-|", views: dateLabel, textView)
    }

    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }

    @objc private func handleCancel() {
        if let _ = list {
            navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }

    @objc private func handleSave() {
        list == nil ? createList() : editList()
    }

    private func createList() {
        guard let text = textView.text, text != "Describe what this list is for" else { return }
        dismiss(animated: true) {
            guard let description = self.textView.text else { return }
            self.delegate?.addTodoList(description: description, date: self.currentDate)
        }
    }

    private func editList() {
        guard let list = self.list else { return }
        list.name = textView.text
        list.date = currentDate
        delegate?.editTodoList(list: list)
        navigationController?.popViewController(animated: true)
    }
}

extension NewListViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .lightGray else { return }
        textView.textColor = .black
        textView.text = nil
    }
}
