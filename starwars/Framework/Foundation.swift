//
//  Foundation.swift
//  starwars
//
//  Created by Master on 21/7/20.
//  Copyright © 2020 Master. All rights reserved.
//

import Foundation

extension Bundle {
    func URLForResource(_ name : String?) -> URL? {
        
        let components : [String]? = name?.components(separatedBy: ".")
        
        let fileTitle = components?.first
        let fileExtension = components?.last
        
        return url(forResource: fileTitle, withExtension: fileExtension)
        
    }
}
