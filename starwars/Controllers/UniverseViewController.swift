

import UIKit

let CharacterDidChangeNotification = Notification.Name(rawValue: "Selected Character did change")

let CharacterKey = "key"


class UniverseViewController: UITableViewController {

    var delegate :  UniverseViewControllerDelegate?
    
    let model : StarWarsUniverse
    
    //inicializador
    
    init(model : StarWarsUniverse) {
        self.model = model
        super.init(nibName : nil, bundle : nil)
        title = "Star Wars"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //metodos de ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNib()

        
    }
    
    func registerNib() {
        
        let nib = UINib(nibName: "CharacterTableViewCell", bundle: Bundle.main)
        
        tableView.register(nib, forCellReuseIdentifier: CharacterTableViewCell.cellID)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        
        imageView.image = UIImage(named: "logoSW")
        
        navigationItem.titleView = imageView
        
        navigationController?.navigationBar.barStyle = .black
        
    }

   //metodo de delegado

    override func numberOfSections(in tableView: UITableView) -> Int {
        // numero de afiliaciones
        return model.affiliationCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // personajes que hay en cada seccion
        return model.characterCount(forAffiliation: getAffiliation(forSection: section))
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        ///creacion de la celda
        
        let char = character(forIndexPath: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.cellID, for: indexPath) as! CharacterTableViewCell
        
        cell.syncCellWithChar(char: char)
        
        return cell
     
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CharacterTableViewCell.cellHeigth
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //titulo de la seccion
        return getAffiliation(forSection: section).rawValue
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ///sin rellenar
        let char = character(forIndexPath: indexPath)
        //let charVC = CharacterViewController(model: char)
       // navigationController?.pushViewController(charVC, animated: true)
        delegate?.universeViewController(self, didSelectCharacter : char)
        
        //se crea el centro de notificaciones
        
        let nc = NotificationCenter.default
        
        // creo la informacion
        
        let notif = Notification(name: CharacterDidChangeNotification, object: self, userInfo: [CharacterKey : char])
        
        //lanzar la notificacion
        
        nc.post(notif)
        
    }

    //funciones de utilidad
    
    func getAffiliation(forSection section : Int) -> StarWarsAffiliation {
        
        var aff : StarWarsAffiliation = .unknow
        
        switch section {
        case 0:
            aff = .galacticEmpire
        case 1:
            aff = .rebelAlliance
        case 2:
            aff = .firstOrder
        case 3:
            aff = .jabbaCriminalEmpire
        default:
            aff = .unknow
            
        }
        
        return aff
    }
    
    func character(forIndexPath indexPath : IndexPath) -> StarWarsCharacter {
        return model.character(atIndex: indexPath.row, forAffiliation: getAffiliation(forSection: indexPath.section))
        
    }
    
}

extension UniverseViewController : UniverseViewControllerDelegate {
    func universeViewController(_ vc: UniverseViewController, didSelectCharacter character: StarWarsCharacter) {
        let charVC = CharacterViewController(model: character)
        
        navigationController?.pushViewController(charVC, animated: true)
        
    }
    
    
}


protocol UniverseViewControllerDelegate {
    func universeViewController( _ vc : UniverseViewController, didSelectCharacter character : StarWarsCharacter)
}
