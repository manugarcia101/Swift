//
//  CiudadTableViewCell.swift
//  application
//
//  Created by Macosx on 13/4/18.
//  Copyright © 2018 Grupo. All rights reserved.
//

//Clase utilizada para mostrar la lista de las distintas ciudades que existen en nuestra galería
import UIKit

class CiudadTableViewCell: UITableViewCell {
    
    // MARK: Properties
    //Etiqueta en la que mostraremos el nombre de la ciudad
    @IBOutlet weak var nombreCiudad: UILabel!
    //Etiqueta en la que mostraremos la fecha de visita a la ciudad
    @IBOutlet weak var fecha: UILabel!
    //Imagen en la que mostraremos la foto más carácterística de la ciudad
    @IBOutlet weak var foto: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: Actions
}
