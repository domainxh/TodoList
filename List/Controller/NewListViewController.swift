//
//  ListController.swift
//  List
//
//  Created by Xiaoheng Pan on 9/7/19.
//  Copyright © 2019 Xiaoheng Pan. All rights reserved.
//

import UIKit

protocol CreateTodoListDelegate: AnyObject {
    func AddTodoList(listModel: ListModel)
}

class NewListViewController: UIViewController {

    weak var delegate: CreateTodoListDelegate?
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.text = "Describe what this list is for"
        tv.textColor = .lightGray
        tv.textAlignment = .left
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.homeListLabel
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        textView.delegate = self
        setupNavigationBar()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(textView)
        view.addConstraintsWithFormat("H:|-[v0]-|", views: textView)
        view.addConstraintsWithFormat("V:|-[v0]-|", views: textView)
    }

    private func setupNavigationBar() {
        navigationItem.title = "Create New List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }

    @objc private func handleCancel() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func handleSave() {
        if let text = textView.text, text != "Describe what this list is for" {
            dismiss(animated: true) {
                let listModel = ListModel(name: self.textView.text)
                self.delegate?.AddTodoList(listModel: listModel)
            }
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
