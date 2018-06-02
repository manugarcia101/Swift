//
//  Item1ViewController.swift
//  application
//
//  Created by Macosx on 11/4/18.
//  Copyright © 2018 Grupo. All rights reserved.
//

//Esta es la vista donde hacemos uso del webKit View, que es la segunda vista dentro de nuestro tab bar controller
import UIKit
//Importamos la librería webKit View
import WebKit
//Importamos la librería necesaria para manejar las distintas estructuras de datos
import Foundation

class Item1ViewController: UIViewController {
    
    //Asociamos una variable para introducir posteriormente el nombre de cada una de las ciudades ya existentes en la aplicación
    var texto: String?
    //Creamos una variable de control para manejar la llamada al viewDidLoad, permitiendo así a cargar nueva búsqueda el número de veces que se desee.
    var control = true
    
    //Url usada en nuestro caso para establecer la búsqueda (Google)
    var urlText: String? = "https://www.google.com"
    var definitiveText: String? = ""
    
    // MARK: Properties
    
    //Variable de enlace con el webKit View
    @IBOutlet weak var webkit: WKWebView!
    //Variable de enlace con el texto introducido
    @IBOutlet weak var text: UITextField!
    //Variable de enlace con el boton de búsqueda
    @IBOutlet weak var button: UIButton!
    //Función de activación de la búsqueda de texto
    @IBAction func busqueda(_ sender: Any) {
        //Introducimos un texto en el text field y lo extraemos en la variable txt
        let txt = text.text
        //Separamos los elementos de la variable txt según los espacios blancos introducidos (a fin de corregir el texto introducido para realizar la búsqueda adecuada)
        let array : [String] = (txt?.components(separatedBy: " "))!
        //Una vez divididos los distintos elementos, los volvermos a unir según el formato de búsqueda que usa Google en nuestro caso, y los vamos añadiendo a definitiveText
        for elements in array{
            definitiveText = definitiveText!+"+"+elements
        }
        //Siempre que hayamos introducido algún tipo de texto no nulo, añadiremos a la url de búsqueda de Google, el texto introducido (bien parseado ya)
        if txt != nil {
            urlText = "https://www.google.es/search?q="+definitiveText!;
            //A continuación, llamamos a viewDidLoad para cargar la respuesta correspondiente del navegador a nuestra búsqueda
            viewDidLoad()
        }
        //Reseteamos definitive text para poder hacer búsquedas limpias (sin datos de búsquedas previas)
        definitiveText = ""
    }
    
    //Esta función se encarga de cargar la vista de la búsqueda realizada en Google
    override func viewDidLoad() {
        super.viewDidLoad()
        //En caso de que dicha búsqueda nunca se haya establecido, cargaremos en dicha primera búsqueda, el nombre de la ciudad seleccionada, y pondremos control a false para poder realizar futuras búsquedas
        if control{
            control = false
            text.text = texto
            busqueda((Any).self)
        }
        //Siempre y cuando la Url no sea nula, se establecerá una petición al webKit, y este realizará la carga final de la vista
        if urlText != nil {
            let url = URL(string: urlText!)
            let request = URLRequest(url: url!)
            webkit.load(request)
        }// Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
