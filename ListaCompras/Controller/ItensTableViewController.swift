//
//  ItensTableViewController.swift
//  ListaCompras
//
//  Created by Aluno on 24/09/22.
//

import UIKit

class ItensTableViewController: UITableViewController {
    
    var index: Int = 0
    var itens = ListaViewModel.shared
    let gradientLayer = CAGradientLayer()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addGradient()
    }
    
    //Aplica gradient color conforme cores selecionadas pelo usuário ao cadastrar a lista de compras
    private func addGradient() {
        gradientLayer.frame = tableView.bounds
        
        let colorPrincipal = defaults.colorForKey(key: "\(itens.nomeLista(index))\(0)")
        let colorSecundaria = defaults.colorForKey(key: "\(itens.nomeLista(index))\(1)")
        
        let colorSet = [colorPrincipal!.withAlphaComponent(0.2), colorSecundaria!.withAlphaComponent(0.2)]
        let location = [0.2, 1.0]
        let backgroundView = UIView(frame: tableView.bounds)
        backgroundView.addGradient(with: gradientLayer, colorSet: colorSet, locations: location)
        tableView.backgroundView = backgroundView
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.countItens(lista: index)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let item = itens.listas[index].itens {
            cell.textLabel?.text = item[indexPath.row].nome
        }
        
        cell.backgroundColor = .clear
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            itens.removeItem(lista: index, item: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none

        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Adicionar item", message: "Informe o item de compra", preferredStyle: .alert)
        
        var textField = UITextField()

        alertController.addTextField { texto in
            textField = texto
        }
        
        let action = UIAlertAction(title: "OK", style: .default) { action in
            if textField.text?.trimmingCharacters(in: .whitespaces).isEmpty == false {
                self.itens.addItem(lista: self.index, item: Item(nome: textField.text!))
                
                //Refresh tableview
                self.tableView.reloadData()

            }
        }
        
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
}

