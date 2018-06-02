//
//  Item2ViewController.swift
//  application
//
//  Created by Macosx on 11/4/18.
//  Copyright © 2018 Grupo. All rights reserved.
//

//Esta es la vista encargada de abrir la cámra de fotos del dispositivo móvil, para así poder tomar fotos
import UIKit
//Biblioteca necesaria para almacenar las estructuras que almacenen nuestros datos
import Foundation

class Item2ViewController: UIViewController,
UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Properties
    
    @IBOutlet weak var foto: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Funcion necesaria para coger la foto de la cámara
    @IBAction func picture(_ sender: UIButton) {
        //Para ello, abriremos el controlador de la cámara, y veremos si la cámara está disponible en nuestro dispositivo
        if UIImagePickerController.isSourceTypeAvailable(.camera) { //En caso de estarlo, abrirá la cámara
            print("abriendo la camara del dispositivo")
            let imagePicker = UIImagePickerController() //Creamos la constante de tipo image picker controller
            imagePicker.delegate = self // La asignamos como delegate
            imagePicker.sourceType = .camera; //Le indicamos el tipo de eleccion como cámara
            imagePicker.allowsEditing = false // Y la definimos como no editable
            present(imagePicker, animated: true, completion: nil) //Por ultimo presentamos el controlador de la camara que asignará la imagen tomada a nuestro image picker controller
        }else{
            print("no se pudo abrir la camara del dispositivo") //En caso de no estar la cámara presente en el dispositivo, lanzará un mensaje de error y no seguirá ejecutando la cámara
        }

    }
    
    //Ahora haremos que la imagen tomada, se guarde de forma permanente en el sistema
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {// Esta limea recogerá nuestra imagen del picker controller
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        //De este modo asignaremos la foto a nuestro imageView
        foto.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
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
