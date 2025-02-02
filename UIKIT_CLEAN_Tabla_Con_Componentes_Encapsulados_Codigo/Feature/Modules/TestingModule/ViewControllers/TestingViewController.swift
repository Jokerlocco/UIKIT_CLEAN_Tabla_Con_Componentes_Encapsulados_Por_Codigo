//
//  TestingViewController.swift
//  UIKIT_CLEAN_Tabla_Con_Componentes_Encapsulados_Codigo
//
//  Created by Gonzalo Arques on 2/2/25.
//

import UIKit

class TestingViewController: UIViewController {
    
    // MARK: - LyfeCicle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        LoadingOverlaySingleton.shared.show(over: self)
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        LoadingOverlaySingleton.shared.hide()
    }
    
    private func setupUI() {
        view.backgroundColor = .blue
    }
    
}
