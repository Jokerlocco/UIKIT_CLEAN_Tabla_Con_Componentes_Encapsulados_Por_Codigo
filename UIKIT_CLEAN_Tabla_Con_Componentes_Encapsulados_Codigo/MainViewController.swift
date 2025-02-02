//
//  MainViewController.swift
//  UIKIT_CLEAN_Tabla_Con_Componentes_Encapsulados_Codigo
//
//  Created by Gonzalo Arques on 2/2/25.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loadListOfPopularMoviesModule(_ sender: Any) {
        loadListOfPopularMoviesModule()
    }
    
    private func loadListOfPopularMoviesModule() {
        let viewController = ListOfPopularMoviesViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
    private func loadTestingModule() {
        let viewController = TestingViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
}

