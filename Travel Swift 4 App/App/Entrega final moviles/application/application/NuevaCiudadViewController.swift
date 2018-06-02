//
//  NuevaCiudadViewController.swift
//  application
//
//  Created by Macosx on 11/4/18.
//  Copyright © 2018 Grupo. All rights reserved.
//

//Esta clase, es la encargada de crear una nueva ciudad en nuestra lista de ciudades
import UIKit
import os.log

class NuevaCiudadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    //Para ello hemos establecido un nombre, una fecha, una imagen, y boton de guardado, un reconocimiento de gestos y en scrollview
    @IBOutlet weak var nombreCiudad: UITextField!
    @IBOutlet weak var fecha: UIDatePicker!
    @IBOutlet weak var foto: UIImageView!
    
    @IBOutlet weak var saveBoton: UIBarButtonItem!
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //Creamos nuestra nueva variable ciudad
    var ciudad: Ciudad?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Añadimos el tapGesture a nuestro Scroll View
        scrollView.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    //Cancelamos la acción de crear una nueva ciudad
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //Este metodo te permite configurar la vista antes de que sea presentada, es necesaria para pasar datos entre vistas posteriormente
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        
        //Configura el destino de la vista solo cuando se pulsa el boton save
        guard let button = sender as? UIBarButtonItem, button === saveBoton else{
            os_log("El boton save no ha sido pulsado, cancelando", log: OSLog.default, type: .debug)
            return
        }
        
        //Asignamos nombre y foto
        let nombre = nombreCiudad.text ?? ""
        let foto = self.foto.image
        
        //Pasamos de formato fecha a un string
        let formatoFecha = DateFormatter()
        formatoFecha.dateStyle = DateFormatter.Style.short
        formatoFecha.timeStyle = DateFormatter.Style.short
        let fecha = formatoFecha.string(from: self.fecha.date)
        
        //Hacemos que la nueva ciudad almacene todos los datos que necesita
        ciudad = Ciudad(nombreCiudad: nombre, fecha: fecha, foto: foto, comentarios: [""])
        
    }
    
    // MARK: UIImagePickerControllerDelegate
    //Función que cancela la acción de coger una imagen
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //Función que se encarga de coger la imagen seleccionada, y guardarla en la variable foto
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            fatalError("Se esperaba un diccionario con la imagen pero se dio lo siguiente: \(info)")
        }
        
        foto.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }

    // MARK: Actions
    //Función que se encarga de administrar el tapGestureRecognizer, para poder (clicando en cualquier lugar) acceder a la galería de fotos del dispositivo
    @IBAction func seleccionarImagen(_ sender: UITapGestureRecognizer) {
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
    
    
    
    
    /*// In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
