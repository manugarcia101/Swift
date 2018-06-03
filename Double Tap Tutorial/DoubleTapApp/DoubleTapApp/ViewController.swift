//
//  ViewController.swift
//  DoubleTapApp
//
//  Created by Macosx on 6/4/18.
//  Copyright © 2018 Macosx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet var variable: UITapGestureRecognizer!
    @IBOutlet weak var texto: UILabel!
    var check = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        variable.numberOfTapsRequired = 2
    }
    
    //MARK: Actions
    @IBAction func funcion(_ sender: UITapGestureRecognizer) {
        if check {
            texto.font = UIFont(name: texto.font.fontName, size: 50)
            check = false
        } else {
            texto.font = UIFont(name: texto.font.fontName, size: 17)
            check = true
        }
    }
    
}


