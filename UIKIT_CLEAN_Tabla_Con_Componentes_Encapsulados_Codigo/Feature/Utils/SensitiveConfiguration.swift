//
//  SensitiveConfiguration.swift
//  UIKIT_CLEAN_Tabla_Con_Componentes_Encapsulados_Codigo
//
//  Created by Gonzalo Arques on 2/2/25.
//

import Foundation

struct SensitiveConfiguration {
    
    /// Obtiene la API Key desde el archivo `SensitiveConfiguration.plist`.
    ///
    /// Para que esta propiedad funcione correctamente, se debe crear un archivo `.plist` llamado `"SensitiveConfiguration"`
    /// dentro del target de la app (asegurándose de que esté marcado en `Target Membership`).
    ///
    /// El archivo debe contener una clave `"API_KEY"` con el valor de la API Key necesaria para la aplicación.
    ///
    /// Este archivo **no se sube a GitHub** y debe ser gestionado localmente para evitar la exposición de credenciales sensibles.
    static var apiKey: String {
        guard let path = Bundle.main.path(forResource: "SensitiveConfiguration", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let key = dict["API_KEY"] as? String
        else {
            fatalError("No se encontró la API Key en Secrets.plist")
        }
        return key
    }
    
}



