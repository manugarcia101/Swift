//
//  Item5ViewController.swift
//  application
//
//  Created by Macosx on 11/4/18.
//  Copyright © 2018 Grupo. All rights reserved.
//

//Clase que sirve para la edición de cada una de las ciudades de la lista
import UIKit
import os.log

class Item5ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    // MARK: Properties
    //Creamos las mismas variables que tiene nuestro elemento ciudad
    @IBOutlet weak var nombreCiudad: UITextField!
    @IBOutlet weak var fecha: UIDatePicker!
    @IBOutlet weak var foto: UIImageView!
    
    @IBOutlet weak var saveBoton: UIButton!
    
    //Creamos también un scrollbar View y una opción de reconocimiento de gestos
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    //Obtenemos las variables de la ciudad correspondiente
    var ciudad: Ciudad?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Añadimos el tapGesture a nuestro Scroll View
        scrollView.addGestureRecognizer(tapGesture)
        
        //Poner la vista con la ciudad que vamos a editar
        if let ciudad = ciudad {
            //Recuperamos la información necesaria de la ciudad para editarla
            nombreCiudad.text = ciudad.nombreCiudad
            foto.image = ciudad.foto
            
            let nuevaFecha = "2018-05-31T00:00:00+0200"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from: nuevaFecha)!
            fecha.setDate(date, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    //Cogemos la imagen asociada a la ciudad
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //Guardamos la nueva imagen de la ciudad
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            fatalError("Se esperaba un diccionario con la imagen pero se dio lo siguiente: \(info)")
        }
        
        foto.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Actions
    //Esta funció se ejecuta cuando el usuario decide guardar los cambios hechos en la ciudad correspondiente
    @IBAction func guardarCambios(_ sender: UIButton) {
        //Cada uno de los datos, es sobreescrito por los datos nuevos.
        self.ciudad?.nombreCiudad = nombreCiudad.text!
        self.ciudad?.foto = foto.image
        //Pasamos de formato fecha a un string
        let formatoFecha = DateFormatter()
        formatoFecha.dateStyle = DateFormatter.Style.short
        formatoFecha.timeStyle = DateFormatter.Style.short
        self.ciudad?.fecha = formatoFecha.string(from: self.fecha.date)
    }
    
    //Esta imagen se encargará de seleccionar la imagen nueva paa la ciudad
    @IBAction func seleccionarImage(_ sender: UITapGestureRecognizer) {
        //Ocultar teclado
        nombreCiudad.resignFirstResponder()
        
        //UIImagePickerController es un controlador de vista que deja que al usuario escoger la foto
        let imagePickerController = UIImagePickerController()
        
        //Solo las fotos de la galeria pueden ser aceptadas
        imagePickerController.sourceType = .photoLibrary
        
        //Asegurarse de que el controlador de vista ha sido notificado cuando el usuario coge la imagen
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        //Entro al tab bar y le damos los detllaes de la ciudad seleccionada
        
        //print(segue.destination)
        //print(segue.source)
        //print(sender ?? <#default value#>)
        /*
        guard let vistaDestino = segue.destination as? Item1ViewController else{
            fatalError("Destino inesperado: \(segue.destination)")
        }
        guard let vistaEmisora = sender as? Item5ViewController else{
            fatalError("Emisor inesperado: \(String(describing: sender))")
        }
        let texto = nombreCiudad.text
        let nav = vistaDestino as! Item1ViewController
        nav.texto = texto*/
    }*/
    
}
