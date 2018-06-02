//
//  Ciudad.swift
//  application
//
//  Created by Macosx on 20/4/18.
//  Copyright © 2018 Grupo. All rights reserved.
//

import UIKit
import os.log

class Ciudad: NSObject, NSCoding{
    
    // MARK: Properties
    //Variables que posee nuestro modelo de Ciudad.
    var nombreCiudad: String
    var fecha: String
    var foto: UIImage?
    var comentarios = [String]()
    
    // MARK: Archiving Paths
    //Directorios donde guardamos los datos cuando creamos nuevas ciudades o borramos ciudades con Persist Data.
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("ciudades")
    
    // MARK: Types
    //Atributos que tendros en nuestros archivos con Persist Data.
    struct PropertyKey{
        static let nombreCiudad = "nombreCiudad"
        static let fecha = "fecha"
        static let foto = "foto"
        static let comentarios = "comentarios"
    }
    
    // MARK: Initialization
    //Constructor de nuestra clase Ciudad, nombre y fecha son campos con los que sin ellos no podemos crear una Ciudad.
    init?(nombreCiudad: String, fecha: String, foto: UIImage?, comentarios: [String]?){
        //Initialize store properties
        //Comprobamos que nuestro nombre de ciudad es distinto de vacio.
        guard !nombreCiudad.isEmpty else{
            return nil
        }
        //Comprobamos que nuestra fecha es distinto de vacio.
        guard !fecha.isEmpty else{
            return nil
        }
        //Si las anteriores comprobaciones se han cumplido satisfactoriamente, creamos nuestra nueva ciudad con sus atributos.
        self.nombreCiudad = nombreCiudad
        self.fecha = fecha
        self.foto = foto
        self.comentarios = comentarios!
    }
    
    // MARK: NSCoding
    //Codificamos los atributos para nuestro archivo con Persist Data.
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nombreCiudad, forKey: PropertyKey.nombreCiudad)
        aCoder.encode(fecha, forKey: PropertyKey.fecha)
        aCoder.encode(foto, forKey: PropertyKey.foto)
        aCoder.encode(comentarios, forKey: PropertyKey.comentarios)
    }
    
    //Constructor que es utilizado por Persist Data cuando obtenemos los datos del archivo y despues llamamos a nuestro construcor propio.
    required convenience init?(coder aDecoder: NSCoder) {
        guard let nombreCiudad = aDecoder.decodeObject(forKey: PropertyKey.nombreCiudad) as? String else{
            os_log("Ha fallado al decodificar la ciudad", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let fecha = aDecoder.decodeObject(forKey: PropertyKey.fecha) as? String else{
            os_log("Ha fallado al decodificar la ciudad", log: OSLog.default, type: .debug)
            return nil
        }
        
        let foto = aDecoder.decodeObject(forKey: PropertyKey.foto) as? UIImage
        
        let comentarios = aDecoder.decodeObject(forKey: PropertyKey.comentarios) as? [String]
        
        self.init(nombreCiudad: nombreCiudad, fecha: fecha, foto: foto, comentarios: comentarios)
    }
}
