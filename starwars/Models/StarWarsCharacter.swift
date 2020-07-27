//
//  StarWarsCharacter.swift
//  starwars
//
//  Created by Master on 15/7/20.
//  Copyright © 2020 Master. All rights reserved.
//

import Foundation
import UIKit

class StarWarsCharacter {
    
    let firstName : String?
    let lastName : String?
    let alias : String?
    let soundData : Data
    let photo : UIImage
    let url : URL
    let affiliation : StarWarsAffiliation
    
    var name : String? {
        get {
            
            guard let first = firstName else {
                if lastName == nil {
                    return "Nameless"
                }
                return lastName
        }
            guard let last = lastName else{
                
                return first
            }
            return "\(first) \(last)"
        }

    }
    
    init(firstName : String?,
        lastName : String?,
        alias : String?,
        soundData : Data,
        photo: UIImage,
        url : URL,
        affiliation: StarWarsAffiliation){
        
        self.firstName = firstName
        self.lastName = lastName
        self.alias = alias
        self.soundData = soundData
        self.photo = photo
        self.url = url
        self.affiliation = affiliation
        
        
    }
    
    convenience init (alias : String?, soundData : Data, photo : UIImage, url : URL, affiliation : StarWarsAffiliation){
        
        self.init(firstName : nil, lastName: nil, alias: alias, soundData: soundData, photo: photo, url: url, affiliation : affiliation)
    }
    
}

extension StarWarsCharacter : CustomStringConvertible {
    
    var description: String {
        get {
            if let name = name, let alias = alias {
                return "<\(type(of:self)) \(name)\(alias)>"
            }
            return "<\(type(of: self))>"
        }
    }
    
    
    
}
