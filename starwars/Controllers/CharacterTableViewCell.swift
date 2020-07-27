//
//  CharacterTableViewCell.swift
//  starwars
//
//  Created by Master on 23/7/20.
//  Copyright © 2020 Master. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    static let cellID = "CharacterTableViewCellId"
    
    static let cellHeigth : CGFloat = 70.0
    
    private var _char : StarWarsCharacter?
    
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var aliasView: UILabel!
    @IBOutlet weak var nameView: UILabel!
    
    func syncCellWithChar(char : StarWarsCharacter) {
        _char = char
        
        photoView.image = _char?.photo
        
        aliasView.text = _char?.alias
        
        nameView.text = _char?.name
        
    }
    
}

