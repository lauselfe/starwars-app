
//
//  AppDelegate.swift
//  bbb
//
//  Created by Fernando on 18/06/2020.
//  Copyright © 2020 Fernando. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // crear una window
        window = UIWindow(frame:UIScreen.main.bounds)
        
        // crear instancia de modelo
        
        do{
            
            // Creo un array vacío de personajes
            
            var chars = [StarWarsCharacter]()
            
            // Array de Diccionarios de Swift, pero yo necesito para el model un array de StarWarsCharacter.
            
            let jsonRegular  = try loadFromLocalFile(fileName: "regularCharacters.json")
            
            for dict in jsonRegular{
                
                do{
                    // decode recibe un diccionario y me devuelve  un starWarsCharacter
                    let char = try decode(starWarsCharacter: dict)
                    chars.append(char)
                } catch {
                    print("Error al procesar \(dict)")
                }
            }
            
            // Arrays de Diccionarios de Swift (de ForceSensitives)
            
            let jsonForce  = try loadFromLocalFile(fileName: "forceSensitives.json")
            
            // Lo mismo que el for de arriba
            _ = jsonForce.map() {
                
                do{
                    let char = try decode(forceSensitive: $0)
                    chars.append(char)
                }catch{
                    print("Error al procesar \($0)")
                }
            }
            
            //print(chars)
            //iphone
            // Podemos crear el modelo
            let model = StarWarsUniverse(character: chars)
            
            // Crear un UniverseVC
            let uVC = UniverseViewController(model: model)
            
            // Empotrando en un Navigation
            let uNav = UINavigationController(rootViewController: uVC)
            
            if UIDevice.current.userInterfaceIdiom == .phone {
                
                window?.rootViewController = uNav
                
                uVC.delegate = uVC
                
                
                
            } else if UIDevice.current.userInterfaceIdiom == .pad {
                let charVC = CharacterViewController(model: model.character(atIndex: 0, forAffiliation: .galacticEmpire))
                
                let charNav = UINavigationController(rootViewController: charVC)
                
                let splitVC = UISplitViewController()
                
                splitVC.viewControllers = [uNav, charNav]
        
                // Asignar el nav como rootVC  ?.  Porque es una window opcional
                window?.rootViewController = splitVC
                
                uVC.delegate = charVC
                
            }
            
            // Mostramos la window. La vista está visible y tiene el foco
            window?.makeKeyAndVisible()
            
            return true
            
        }catch{
            fatalError("Error while loading JSON")
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}
