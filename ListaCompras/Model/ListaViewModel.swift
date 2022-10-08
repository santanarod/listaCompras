//
//  ListaViewModel.swift
//  ListaCompras
//
//  Created by Aluno on 24/09/22.
//

import Foundation
import UIKit

class ListaViewModel {
    
    static let shared = ListaViewModel()
    private let listaDAO = ListaDAO()
    let defaults = UserDefaults.standard
    
    var countListas: Int {
        return listaDAO.listas.count
    }
    
    var listas: [Lista] {
        return listaDAO.listas
    }
    
    func nomeLista(_ sequencia: Int) -> String {
        return listaDAO.listas[sequencia].nome
    }
    
    func addLista(_ lista: Lista) {
        listaDAO.addLista(lista)
    }
    
    func removeLista(_ sequencia: Int) {
        listaDAO.removeLista(sequencia)
    }
    
    func addItem(lista sequencia: Int, item: Item) {
        listaDAO.addItem(lista: sequencia, item: item)
    }
    
    func removeItem(lista sequencia: Int, item index: Int) {
        listaDAO.removeItem(lista: sequencia, item: index)
    }
    
    func countItens(lista sequencia: Int) -> Int {
        return listaDAO.listas[sequencia].itens?.count ?? 0
    }
    
    func persistirDados() {
        listaDAO.persistirDados()
    }
    
    func recuperarDados() {
        listaDAO.recuperarDados()
    }
}
