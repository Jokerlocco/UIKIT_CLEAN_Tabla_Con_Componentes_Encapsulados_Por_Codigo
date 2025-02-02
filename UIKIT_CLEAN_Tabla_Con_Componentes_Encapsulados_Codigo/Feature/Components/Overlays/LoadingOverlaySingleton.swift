//
//  LoadingOverlaySingleton.swift
//  UIKIT_CLEAN_Tabla_Con_Componentes_Encapsulados_Codigo
//
//  Created by Gonzalo Arques on 2/2/25.
//

import UIKit

/// Singleton para mostrar un overlay con un spinner.
/// Se usa `LoadingOverlay.shared.show(over:)` para mostrar y `LoadingOverlay.shared.hide()` para ocultar.
class LoadingOverlaySingleton {
    
    // Instancia única en la app (singleton)
    static let shared = LoadingOverlaySingleton()
    
    // Constructor privado para evitar instancias adicionales
    private init() {}

    private var overlayView: UIView?
    private var spinner: UIActivityIndicatorView?
    private var messageLabel: UILabel?
    
    func show(over viewController: UIViewController, message: String? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard self?.overlayView == nil else { return } // Evita duplicados
            
            // Fondo con desenfoque
            let overlay = UIView(frame: viewController.view.bounds)
            overlay.backgroundColor = UIColor.black.withAlphaComponent(0.4) // Semi-transparente
            
            let blurEffect = UIBlurEffect(style: .light)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = overlay.bounds
            overlay.addSubview(blurView)
            
            // Spinner
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.color = CustomColors.magenta
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.startAnimating()
            overlay.addSubview(activityIndicator)

            // Etiqueta opcional de mensaje
            let label = UILabel()
            label.text = message
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            overlay.addSubview(label)
            
            // Auto Layout
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: overlay.centerYAnchor, constant: -10),
                
                label.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 10),
                label.leadingAnchor.constraint(equalTo: overlay.leadingAnchor, constant: 20),
                label.trailingAnchor.constraint(equalTo: overlay.trailingAnchor, constant: -20)
            ])
            
            // Añadir el overlay a la vista principal del controlador
            viewController.view.addSubview(overlay)
            // Asegurarnos de que el overlay esté por encima de todas las demás vistas
            viewController.view.bringSubviewToFront(overlay)

            self?.overlayView = overlay
            self?.spinner = activityIndicator
            self?.messageLabel = label
        }
    }
    
    func hide() {
        // Aplicamos un retraso de un segundo para que la animación sea más natural
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            UIView.animate(withDuration: 0.3, animations: {
                self?.overlayView?.alpha = 0
            }) { _ in
                self?.spinner?.stopAnimating()
                self?.overlayView?.removeFromSuperview()
                // Liberamos memoria:
                self?.overlayView = nil
                self?.spinner = nil
                self?.messageLabel = nil
            }
        }
    }
}
