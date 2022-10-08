//
//  ListaTableViewController.swift
//  ListaCompras
//
//  Created by Aluno on 24/09/22.
//

import UIKit

class ListaTableViewController: UITableViewController {
    
    private let lista = ListaViewModel.shared
    var editListVC = EditListViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        editListVC.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lista.recuperarDados()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lista.countListas
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = lista.nomeLista(indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            lista.removeLista(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Crie listas e adicione os itens de compra"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LTVtoITV" {
            let destination = segue.destination as! ItensTableViewController
            destination.title = lista.nomeLista(tableView.indexPathForSelectedRow!.row)
            destination.index = tableView.indexPathForSelectedRow!.row
        }
        
        if segue.identifier == "AddList" {
            let destination = segue.destination as! EditListViewController
            destination.delegate = self
        }
    }
}

extension ListaTableViewController: EditListViewControllerDelegate {
    func updateTableView() {
        self.lista.recuperarDados()
        self.tableView.reloadData()
    }
}
