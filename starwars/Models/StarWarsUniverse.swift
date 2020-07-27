//
//  StarWarsUniverse.swift
//  starwars
//
//  Created by Master on 20/7/20.
//  Copyright © 2020 Master. All rights reserved.
//

import Foundation
import UIKit

class StarWarsUniverse {
    
    //Typealias
    
    typealias StarWarsArray = [StarWarsCharacter]
    typealias StarWarsDictionary = [StarWarsAffiliation : StarWarsArray]
    
    var dict : StarWarsDictionary = StarWarsDictionary()
    
    init(character chars: StarWarsArray) {
        
        dict = makeEmptyAffiliations()
        
        for each in chars {
            dict[each.affiliation]?.append(each)
        }
    }
    
    // metodos para responder al Data Source
    
    //secciones de la tabla
    
    var affiliationCount : Int {
        get {
            // numero de afiliaciones
            return dict.count
            
        }
    }
    
    ///cuantas filas hay en cada seccion
    
    
    func characterCount(forAffiliation affiliation : StarWarsAffiliation) -> Int {
      //  return (dict[affiliation]?.count)
        
        guard let count = dict[affiliation]?.count else {
            return 0
        }
        return count
        
    }
    
    //Rellenar en cada fila el personaje
    func character(atIndex index : Int, forAffiliation affiliation : StarWarsAffiliation) -> StarWarsCharacter {
        
        let chars = dict[affiliation]!
        let char = chars[index]
        
        return char
        
        
    }
    
    //titulo de cada seccion de la tabla
    
    func affiliationName(_ affiliation : StarWarsAffiliation) -> String {
        return  affiliation.rawValue
    }
    
    
    ///funciones de utilidad
    
    func makeEmptyAffiliations() -> StarWarsDictionary {
        
        var d = StarWarsDictionary()
        
        d[.rebelAlliance] = StarWarsArray()
        d[.galacticEmpire] = StarWarsArray()
        d[.firstOrder] = StarWarsArray()
        d[.jabbaCriminalEmpire] = StarWarsArray()
        d[.unknow] = StarWarsArray()
        
        
        
        return d
        
    }
}
