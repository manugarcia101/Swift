//
//  Item3ViewController.swift
//  application
//
//  Created by Macosx on 11/4/18.
//  Copyright © 2018 Grupo. All rights reserved.
//

//Esta vista será la encargada de gestionar los comentarios (cuarta vista de nuestro tab Bar)
import UIKit

class Item3ViewController: UIViewController {

    //Capturamos los datos que nos llegan desde el segue del tab Bar (los datos de la ciudad correspondiente)
    var ciudad: Ciudad?
    
    //Etiqueta en la que se mostrarán los comentarios
    @IBOutlet weak var comentarioPantalla: UILabel!
    //Campo de texto a través del cual se añadirán nueos comentarios
    @IBOutlet weak var nuevoComentario: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Si lo que he recibido es una ciudad, cargaremos todos los comentarios asociados a dicha ciudad
        if let ciudad = ciudad {
            
            var textoAux = ""
            //Contador usado para contar el número de comentarios que hay en cada ciudad, e identificar cada uno de estos comentarios de forma más visual
            var cont: Int
            cont = 1
            for comentario in (ciudad.comentarios) {
                //Si el comentario es vacío, no se listará, además se mostrará un contador con el número de comentario
                if(comentario != ""){
                    textoAux += "Comentario \(cont): " + comentario + "\r\n\r\n"
                    cont = cont + 1
                }
            }
            
            //Finalmente, se mostrarán los comentarios por pantalla
            comentarioPantalla.text = textoAux
            
        }
        
        // Do any additional setup after loading the view.
    }

    //En esta función, nos encargamos de añadir los nuevos comentarios 
    @IBAction func addComent(_ sender: UIButton) {
        ciudad?.comentarios.append(nuevoComentario.text!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
