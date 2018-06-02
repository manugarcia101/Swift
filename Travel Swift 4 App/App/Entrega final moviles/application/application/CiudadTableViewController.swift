//
//  CiudadTableViewController.swift
//  application
//
//  Created by Macosx on 20/4/18.
//  Copyright © 2018 Grupo. All rights reserved.
//

import UIKit
import os.log

class CiudadTableViewController: UITableViewController {
    
    // MARK: Properties
    //Array de ciudades que serán mostradas en nuestra tabla
    var ciudades = [Ciudad]()
        
    
    //Cuando cargamos la vista, creamos el boton de editar, ademas de cargar las ciudades desde los archivos si hay ciudades guardades y si no cargamos las de por defecto.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        //Cargamos las de por defecto o las guardas segun si tenemos ciudades guardadas o no.
        if let ciudadesGuardadas = cargarCiudades() {
            ciudades += ciudadesGuardadas
        }else{
            cargarCiudadesEjemplo()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    //Funcion para el numero de secciones.
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    //Función en el que devolvemos el tamaño de nuestro array de ciudades para que sea leido por la tabla.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ciudades.count
    }

    //Funcion donde creamos las celdas de nuestra tabla con los atributos de una ciudad en particular.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier = "CiudadTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CiudadTableViewCell else {
            fatalError("la celda no ha sido instanciada por ciudadTableViewCell")
        }
        
        let ciudad = ciudades[indexPath.row]
        
        cell.nombreCiudad.text = ciudad.nombreCiudad
        cell.foto.image = ciudad.foto
        cell.fecha.text = ciudad.fecha

        return cell
    }
    
    // Override to support conditional editing of the table view.
    //Para hacer que nuestras celdas sean editables.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    //Función para cuando editamos el contenido de nuestra tabla que la ciudad eliminada desaparezca de nuestro array.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ciudades.remove(at: indexPath.row)
            guardarCiudades()
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //Funcion que se carga antes de que nos movamos a otra vista, preparamos el segue y segun la vista donde nos desplacemos proporcionamos los datos de la ciudad seleccionada.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        //El segue por el que nos vamos a mover es aquel que nos dirige al Tab Bar Controller.
        if(segue.identifier == "TabBar"){
            //Conjunto de condiciones por si ocurre un error.
            guard let ciudadDetailViewController = segue.destination as? UITabBarController else{
                fatalError("Destino inesperado: \(segue.destination)")
            }
            guard let selectedCiudadCell = sender as? CiudadTableViewCell else{
                fatalError("Emisor inesperado: \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selectedCiudadCell) else{
                fatalError("La celda seleccionada no ha sido mostrada por la tabla")
            }
            //Guardamos la ciudad sobre la que hemos pulsado.
            let selectedCiudad = ciudades[indexPath.row]
            //Si la vista a la que nos queremos dirigir es en la que modificamos la ciudad le indicamos todos los atributos.
            let nav1 = ciudadDetailViewController.viewControllers![0] as! Item5ViewController
            nav1.ciudad = selectedCiudad
            //Si la vista a la que nos queremos dirigir es en la que mostramos la busqueda por el web kit view le pasamos el nombre de la ciudad.
            let nav2 = ciudadDetailViewController.viewControllers![1] as! Item1ViewController
            nav2.texto = selectedCiudad.nombreCiudad
            //Si la vista a la que nos queremos dirigir es en la que mostramos los comentarios de la ciudad le indicamos todos los atributos.
            let nav3 = ciudadDetailViewController.viewControllers![3] as! Item3ViewController
            nav3.ciudad = selectedCiudad
        }
    }
    
    // MARK: Actions
    //Funcion que es llamada cuando se vuelve de otra vista a esta vista de la tabla de nuestras ciudades.
    @IBAction func unwindListaCiudades(sender: UIStoryboardSegue){
        //Esta funcion se llama desde dos distintos origines por tanto comprobamos la vista desde la que se llama.
        //Si llamamos desde la vista en la que creamos una nueva ciudad la guardamos en nuestra table view controller como una nueva celdad
        if let origenViewController1 = sender.source as? NuevaCiudadViewController, let ciudad = origenViewController1.ciudad {
            
            //Añadir una nueva ciudad
            let indexPath = IndexPath(row: ciudades.count, section: 0)
            ciudades.append(ciudad)
            tableView.insertRows(at: [indexPath], with: .automatic)
            
        }
        
        //Si llamamos desde guardar cambios en la vista de editar en el tab bar modificamos los cambios de la celda que hemos pulsado.
        //Aquí cambiamos los atributos de nuestra clase ciudad.
        if let origenViewController2 = sender.source as? Item5ViewController, let ciudad = origenViewController2.ciudad {
            //Actualizar una ciudad
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                ciudades[selectedIndexPath.row] = ciudad
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
        }
        
        //Si llamamos desde guardar cambios en la vista de editar en el tab bar modificamos los cambios de la celda que hemos pulsado.
        //Aquí cambiamos solamente los comentarios.
        if let origenViewController3 = sender.source as? Item3ViewController, let ciudad = origenViewController3.ciudad {
            //Actualizar una ciudad
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                ciudades[selectedIndexPath.row] = ciudad
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
        }
        //Guardamos los cambios en nuestros archivos para poder utilizar Persist Data.
        guardarCiudades()
    }
    
    //MARK: Private Methods
    //Cargamos las ciudades por defecto con los datos que nosotros queremos.
    private func cargarCiudadesEjemplo(){
        let foto1 = UIImage(named:"ciudad1")
        let foto2 = UIImage(named:"ciudad2")
        let foto3 = UIImage(named:"ciudad3")
        
        guard let ciudad1 = Ciudad(nombreCiudad: "St. Petersburgo", fecha: "6/15/18, 11:34 PM", foto: foto1, comentarios: [""])else{
            fatalError("no ha sido posible cargar la ciudad 1")
        }
        
        guard let ciudad2 = Ciudad(nombreCiudad: "St. Francisco", fecha: "8/25/18, 3:30 AM", foto: foto2, comentarios: [""])else{
            fatalError("no ha sido posible cargar la ciudad 2")
        }
        
        guard let ciudad3 = Ciudad(nombreCiudad: "Londres", fecha: "12/22/18, 2:00 PM", foto: foto3, comentarios: [""])else{
            fatalError("no ha sido posible cargar la ciudad 3")
        }
        
        //Lo añadimos a nuestro array de ciudades.
        ciudades += [ciudad1,ciudad2,ciudad3]
    }
    
    //Guardamos los cambios en los archivos de las ciudades que estan en nuestro array.
    private func guardarCiudades(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(ciudades, toFile: Ciudad.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Ciudad guardada correctamente", log: OSLog.default, type: .debug)
        }else{
            os_log("Se ha producido un fallo al guardar", log: OSLog.default, type: .error)
        }
    }
    
    //Cargamos las ciudades desde los archivos de Persist Data.
    private func cargarCiudades() -> [Ciudad]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Ciudad.ArchiveURL.path) as? [Ciudad]
    }
}

