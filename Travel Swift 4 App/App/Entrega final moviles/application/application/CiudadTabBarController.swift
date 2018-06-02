//
//  CiudadTabBarController.swift
//  application
//
//  Created by Macosx on 27/4/18.
//  Copyright © 2018 Grupo. All rights reserved.
//

import UIKit

class CiudadTabBarController: UITabBarController {

    var ciudad: Ciudad?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let ciudad = ciudad {
            print("Estoy en viewDidLoad y leo la ciudad")
            print("\(ciudad.nombreCiudad)")
            self.ciudad?.nombreCiudad = ciudad.nombreCiudad
            self.ciudad?.foto = ciudad.foto
            //Parseamos string a date
            //let dateFormatter = DateFormatter()
            //fecha = dateFormatter.date(from: ciudad.fecha)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("LLego al prepare de tab bar")
        let barViewControllers = segue.destination as! CiudadTabBarController
        let nav = barViewControllers.viewControllers![0] as! UINavigationController
        let destinationViewControllers = nav.topViewController as! Item5ViewController
        destinationViewControllers.ciudad = self.ciudad
    }
    

}
