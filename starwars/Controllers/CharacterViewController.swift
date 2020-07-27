//
//  CharacterViewController.swift
//  starwars
//
//  Created by Master on 15/7/20.
//  Copyright © 2020 Master. All rights reserved.
//

import UIKit
import AVFoundation


class CharacterViewController: UIViewController {

    
    @IBOutlet weak var photoView: UIImageView!
   
    var model : StarWarsCharacter
    
    var player = AVAudioPlayer()
    
    
    init(model : StarWarsCharacter){
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        syncModelWithView()
    }
    
    @IBAction func playSound(_ sender: Any) {
        player.play()
        print("Sonido")
        
    }
    
    
    @IBAction func wiki(_ sender: Any) {
        let wVC = WikiViewController(model: model)
        
        navigationController?.pushViewController(wVC, animated: true)
        
    }
    
    func syncModelWithView()
    {
        navigationController?.navigationBar.barStyle = .black
        
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        
        photoView.image = model.photo
        
        title = model.name
        
        do {
            try   player = AVAudioPlayer(data: model.soundData)
            
        } catch  {
            print("Ha habido un error")
        }
    }
}

extension CharacterViewController : UniverseViewControllerDelegate {
    
    func universeViewController(_ vc: UniverseViewController, didSelectCharacter character: StarWarsCharacter) {
        
        model = character
        
        syncModelWithView()
    }
    
    
}
