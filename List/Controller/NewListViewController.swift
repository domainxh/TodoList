//
//  ListController.swift
//  List
//
//  Created by Xiaoheng Pan on 9/7/19.
//  Copyright © 2019 Xiaoheng Pan. All rights reserved.
//

import UIKit

protocol TodoListDelegate: AnyObject {
    func editTodoList(list: List)
    func addTodoList(description: String, date: Date)
}

private let kTopPadding = 13
private let kDateLabelHeight = 30

class NewListViewController: UIViewController {

    weak var delegate: TodoListDelegate?
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
        tv.text = NSLocalizedString("NewListVC.TextView.Description", comment: "")
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
        textView.delegate = self
        setupNavigationBar()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = list == nil ?
            NSLocalizedString("NewListVC.NavigationTitle.Create", comment: "") :
            NSLocalizedString("NewListVC.NavigationTitle.Edit", comment: "")
    }

    private func setupUI() {
        view.addSubviews(textView, dateLabel)
        view.addConstraintsWithFormat("H:|-[v0]-|", views: textView)
        view.addConstraintsWithFormat("H:|-[v0]-|", views: dateLabel)
        view.addConstraintsWithFormat("V:|-\(kTopPadding)-[v0(\(kDateLabelHeight))]-[v1]-|", views: dateLabel, textView)
    }

    private func setupNavigationBar() {
        let cancel = NSLocalizedString("NewListVC.NavigationItem.Cancel", comment: "")
        let save = NSLocalizedString("NewListVC.NavigationItem.Save", comment: "")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: cancel, style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: save, style: .plain, target: self, action: #selector(handleSave))
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
        guard let text = textView.text, text != NSLocalizedString("NewListVC.TextView.Description", comment: "") else {
            return
        }
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
