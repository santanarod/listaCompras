//
//  Lista.swift
//  ListaCompras
//
//  Created by Aluno on 24/09/22.
//

import Foundation

struct Lista: Encodable, Decodable {
    var nome: String
    var itens: [Item]?
}
