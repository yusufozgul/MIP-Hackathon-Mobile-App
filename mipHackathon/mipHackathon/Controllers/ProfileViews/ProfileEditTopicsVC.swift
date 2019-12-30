//
//  ProfileEditTopicsVC.swift
//  WeventApp
//
//  Created by Yusuf Özgül on 25.11.2019.
//  Copyright © 2019 Ilao. All rights reserved.
//

import UIKit

class ProfileEditTopicsVC: UIViewController
{
    @IBOutlet weak var topicsTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var type: String = ""
    var fullTopics: [String] = []
    var selectedTopics: [String] = []
    var searchResultTopics: [String] = []
    weak var delegate: TopicDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        if let data = UserDefaults.standard.value(forKey: type) as? [String]
        {
            selectedTopics = data
        }
        searchResultTopics = fullTopics
        topicsTableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        delegate?.reload()
    }

    @IBAction func saveButton(_ sender: Any)
    {
        delegate?.save(topics: selectedTopics, type: type)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func closeButton(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ProfileEditTopicsVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return searchResultTopics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "profileEditTopicsResultCell", for: indexPath) as? ProfileEditTopicsSearchResultCell
        {
            cell.topicsLabel.text = searchResultTopics[indexPath.row]
            if selectedTopics.contains(searchResultTopics[indexPath.row])
            {
                cell.setSelectedTopics()
            }
            else
            {
                cell.setUnselected()
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let word = searchResultTopics[indexPath.row]
        if selectedTopics.contains(word)
        {
            selectedTopics = selectedTopics.filter { $0 != word }
        }
        else
        {
            selectedTopics.append(word)
        }
        topicsTableView.reloadData()
    }
}
extension ProfileEditTopicsVC: UITextFieldDelegate
{
    @objc func textFieldDidChange(_ textField: UITextField)
    {
        searchResultTopics = fullTopics.filter { $0.lowercased().contains(textField.text!.lowercased()) }
        if textField.text!.isEmpty
        {
            searchResultTopics = fullTopics
        }
        topicsTableView.reloadData()
    }
}

protocol TopicDelegate: class
{
    func save(topics: [String], type: String)
    func reload()
}
