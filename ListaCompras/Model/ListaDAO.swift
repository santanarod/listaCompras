//
//  ListaManager.swift
//  ListaCompras
//
//  Created by Aluno on 24/09/22.
//

import Foundation
import UIKit

class ListaDAO {
    
    private (set) var listas = [Lista]()
    private let arquivo = FileManager
                    .default
                    .urls(for: .documentDirectory, in: .userDomainMask)
                    .first?
                    .appendingPathComponent("Listas.plist")
    
    private let defaults = UserDefaults.standard
    
    init() {}
    
    func addLista(_ lista: Lista) {
        listas.append(lista)
        persistirDados()
    }
    
    func removeLista(_ sequencia: Int) {
        defaults.removeObject(forKey: "\(listas[sequencia].nome)\(0)")
        defaults.removeObject(forKey: "\(listas[sequencia].nome)\(1)")
        listas.remove(at: sequencia)
        persistirDados()
    }
    
    func addItem(lista sequencia: Int, item: Item) {
        if listas[sequencia].itens != nil {
            listas[sequencia].itens?.append(item)

        } else {
            listas[sequencia] = Lista(nome: listas[sequencia].nome, itens: [item])
        }
        
        persistirDados()
    }
    
    func removeItem(lista sequencia: Int, item index: Int) {
        listas[sequencia].itens?.remove(at: index)
        persistirDados()
    }
    
    func persistirDados() {
        let codificador = PropertyListEncoder()
        
        do {
            let dados = try codificador.encode(listas)
            try dados.write(to: self.arquivo!)
            
        } catch {
            print("Erro ao gravar listas: \(error)")
        }
    }
    
    func recuperarDados() {
        do {
            if let dados = try? Data(contentsOf: arquivo!) {
                let decodificador = PropertyListDecoder()
                self.listas = try decodificador.decode([Lista].self, from: dados)
            }
            
        } catch {
            print("Erro ao ler o arquivo")
        }
    }
}
