//
//  ExchangeVC.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 29.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import UIKit

class ExchangeVC: UIViewController {

    @IBOutlet weak var exchangeTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var showdDatas: [ExchangeData] = []
    
    var exchangeDatas: [ExchangeData] = []
    var cyriptoDatas: [ExchangeData] = []
    var stockDatas: [ExchangeData] = []
    
    var type: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        GetAllCurrency().get { (result) in
            switch result
            {
            case .succes(let data):
                self.exchangeDatas = data
                self.showdDatas = data
            case .error(errorType: let type):
                self.showError(message: "Bir problem oluştu lütfen yeniden deneyin. Hata kodu: \(type.rawValue)")
            }
            self.exchangeTableView.reloadData()
        }

        GetStocks().get { (result) in
            switch result
            {
            case .succes(let data):
                self.stockDatas = data
            case .error(errorType: let type):
                self.showError(message: "Bir problem oluştu lütfen yeniden deneyin. Hata kodu: \(type.rawValue)")
            }
        }

        GetCyriptoCurrency().get { (result) in
            switch result
            {
            case .succes(let data):
                self.cyriptoDatas = data
            case .error(errorType: let type):
                self.showError(message: "Bir problem oluştu lütfen yeniden deneyin. Hata kodu: \(type.rawValue)")
            }
        }
    }

    func showError(message: String)
    {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
   
    @IBAction func selectType(_ sender: UISegmentedControl)
    {
        type = sender.selectedSegmentIndex
        
        if type == 0
        { showdDatas = exchangeDatas }
        if type == 1
        { showdDatas = cyriptoDatas }
        if type == 2
        { showdDatas = stockDatas }
        self.exchangeTableView.reloadData()
    }
    
}

extension ExchangeVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return showdDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "exchangeCell", for: indexPath) as? exchangeCell
        {
            cell.nameLabel.text = showdDatas[indexPath.row].name
            cell.valueLabel.text = showdDatas[indexPath.row].value
            cell.rateLabel.text = showdDatas[indexPath.row].rate
            return cell
        }
        return UITableViewCell()
    }
    
}

extension ExchangeVC: UITextFieldDelegate
{
    @objc func textFieldDidChange(_ textField: UITextField)
    {
        var data: [ExchangeData] = []
        if type == 0
        { data = exchangeDatas }
        if type == 1
        { data = cyriptoDatas }
        if type == 2
        { data = stockDatas }
        
        showdDatas = data.filter { $0.name.lowercased().contains(textField.text!.lowercased()) }
        if textField.text!.isEmpty
        {
            showdDatas = data
        }
        exchangeTableView.reloadData()
    }
}

struct ExchangeData
{
    var name: String
    var rate: String
    var value: String
}
