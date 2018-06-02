//
//  Item4ViewController.swift
//  application
//
//  Created by Macosx on 11/4/18.
//  Copyright © 2018 Grupo. All rights reserved.
//

//Esta es la clase que se encarga de cargar la vista del mapa de la aplicación
import UIKit
//Biblioteca que se necesita en mapKit
import MapKit
//Biblioteca necesaria para poder usar las aplicaciones del sistema
import CoreLocation

class Item4ViewController: UIViewController {

    // MARK: Properties
    //Inicializamos el sistema de localización
    let locationManager = CLLocationManager()
    //Variable que usa el map View
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //Establecemos nuestro map view, y lo abrimos cuando el usuarios pulsa el boton de: "abrir en mapas"
    @IBAction func maps(_ sender: UIButton) {

        let mapItem = MKMapItem ()
        mapItem.openInMaps()
        
    }
    
    //Colocamos una orientación concreta para abrir la visión de la cámara sobre el mapa
    private func cameraSetup(){
        //Altitud, ángulo y vertical de la cámara
        mapView.camera.altitude = 575
        mapView.camera.pitch = 50
        mapView.camera.heading = 180
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
