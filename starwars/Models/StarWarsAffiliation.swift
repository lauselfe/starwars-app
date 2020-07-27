//
//  StarWarsAffiliation.swift
//  starwars
//
//  Created by Master on 15/7/20.
//  Copyright © 2020 Master. All rights reserved.
//

import Foundation

enum StarWarsAffiliation : String {
    case galacticEmpire = "Galatic Empire"
    case rebelAlliance = "Rebel Alliance"
    case firstOrder = "First Order"
    case jabbaCriminalEmpire = "Jabba's Criminal Empire"
    case unknow = "Unknown"
    
    static func byName(_ name : String) -> StarWarsAffiliation {
        
        let aff: StarWarsAffiliation
        
        switch name {
        case StarWarsAffiliation.galacticEmpire.rawValue:
            aff = .galacticEmpire
        case StarWarsAffiliation.rebelAlliance.rawValue:
            aff = .rebelAlliance
        case StarWarsAffiliation.jabbaCriminalEmpire.rawValue:
            aff = .jabbaCriminalEmpire
        case StarWarsAffiliation.firstOrder.rawValue:
            aff = .firstOrder
        default:
            aff = .unknow
            
        }
        
        return aff
    }
    
    static func byName (_ name : String?) -> StarWarsAffiliation {
        
        guard case .some(let affiliationName) = name else {
            return .unknow
            
        }
        
        return byName(affiliationName)
        
        
    }
}
