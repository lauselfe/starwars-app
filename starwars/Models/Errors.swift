//
//  Errors.swift
//  starwars
//
//  Created by Master on 21/7/20.
//  Copyright © 2020 Master. All rights reserved.
//

import Foundation

enum StarWarsError : Error {
    
    case wrongURLFormatForJSONResource
    
    case resourcePointedByURLNotRechable
    
    case jsonParsingError

    case wrongJSONFormat
    
    case nilJSONObject
    
}
