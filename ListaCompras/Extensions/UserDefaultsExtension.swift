//
//  UserDefaultsExtension.swift
//  ListaCompras
//
//  Created by Allan Santana on 26/09/22.
//

import Foundation
import UIKit

extension UserDefaults {
    func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            do {
                colorData = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true) as NSData?
                set(colorData, forKey: key)
            } catch {
                print("erro ao salvar cor em userdefaults \(error)")
            }
        }
    }
    
    func colorForKey(key: String) -> UIColor? {
        var color: UIColor?
        if let colorData = data(forKey: key) {
            do {
                color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData)
            } catch let err {
                print("erro ao recuperar cor em userdefaults \(err)")
            }
        }
        return color
    }
}


