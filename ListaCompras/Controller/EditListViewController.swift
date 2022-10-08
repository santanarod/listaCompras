//
//  EditListViewController.swift
//  ListaCompras
//
//  Created by Allan Santana on 25/09/22.
//

import UIKit

protocol EditListViewControllerDelegate: AnyObject {
    func updateTableView()
}

class EditListViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var iconeLista: UIImageView!
    @IBOutlet weak var nomeLista: UITextField!
    @IBOutlet weak var corPrincipal: UIColorWell!
    @IBOutlet weak var corSecundaria: UIColorWell!
    @IBOutlet weak var btSalvar: UIButton!
    let lista = ListaViewModel.shared
    let defaults = UserDefaults.standard
    
    weak var delegate: EditListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btSalvar.isEnabled = false
        nomeLista.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nomeLista.resignFirstResponder()
        return true
    }

    @IBAction func inserirNome(_ sender: UITextField) {
        if nomeLista.text?.trimmingCharacters(in: .whitespaces).isEmpty == false {
            btSalvar.isEnabled = true
        } else {
            btSalvar.isEnabled = false
        }
    }
    
    @IBAction func cancelar(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func salvar(_ sender: UIButton) {
        lista.addLista(Lista(nome: nomeLista.text!))
        defaults.setColor(color: corPrincipal.selectedColor, forKey: "\(nomeLista.text!)\(0)")
        defaults.setColor(color: corSecundaria.selectedColor, forKey: "\(nomeLista.text!)\(1)")
        delegate?.updateTableView()
        dismiss(animated: true)
    }
}
