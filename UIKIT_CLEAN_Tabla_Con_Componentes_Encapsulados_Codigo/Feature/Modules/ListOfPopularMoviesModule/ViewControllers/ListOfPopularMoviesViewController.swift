//
//  ListOfPopularMoviesController.swift
//  UIKIT_CLEAN_Tabla_Con_Componentes_Encapsulados_Codigo
//
//  Created by Gonzalo Arques on 2/2/25.
//

import UIKit

class ListOfPopularMoviesViewController: UIViewController {
    
    // MARK: - UI Closures
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ItemListCell.self, forCellReuseIdentifier: ListOfCellIDs.itemListCellID)
        tableView.register(InfoMessageCell.self, forCellReuseIdentifier: ListOfCellIDs.infoMessageCellID)
        return tableView
    }()
    
    private let buttonFillView: ButtonFillView = {
        let view = ButtonFillView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.button.setTitle("Confirmar", for: .normal)
        return view
    }()
    
    // MARK: - Variables
    private var allDataSourceOfCells: [Any] = []
    
    // MARK: - LyfeCicle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
        Task {
            await fetchAllData()
            reloadTableViewData()
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        DispatchQueue.main.async {
            self.configureMainView()
            
            self.configureTableView()
            self.configureButtonFillView()
            
            self.addSubviews()
            self.configureConstraints()
        }
    }
    
    private func configureMainView() {
        view.backgroundColor = .white
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(buttonFillView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: buttonFillView.topAnchor),
            
            buttonFillView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonFillView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonFillView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

// MARK: - DataManager methods
extension ListOfPopularMoviesViewController {
    
    private func fetchAllData() async {
        LoadingOverlaySingleton.shared.show(over: self, message: "Cargando...")
        
        let dataManager = ListOfPopularMoviesDataManager()
        allDataSourceOfCells.append(contentsOf: await dataManager.fetchListOfPopularMoviesVMFromAPI())
        allDataSourceOfCells.append(contentsOf: dataManager.fetchListOfPopularMoviesVMFromLocal())
        allDataSourceOfCells.append(contentsOf: dataManager.fetchListOfInfoMessagesFromLocal())
        
        LoadingOverlaySingleton.shared.hide()
    }
    
}

// MARK: - TableView (and cells) methods
extension ListOfPopularMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func reloadTableViewData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInThisSection = allDataSourceOfCells.count
        return numberOfRowsInThisSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < allDataSourceOfCells.count {
            let item = allDataSourceOfCells[indexPath.row]
            
            switch item {
            case let popularMovieVM as PopularMovieListCellViewModel:
                if let cell = tableView.dequeueReusableCell(withIdentifier: ListOfCellIDs.itemListCellID, for: indexPath) as? ItemListCell {
                    cell.configure(viewModel: popularMovieVM)
                    return cell
                }
                
            case let infoMessageVM as InfoMessageCellViewModel:
                if let cell = tableView.dequeueReusableCell(withIdentifier: ListOfCellIDs.infoMessageCellID, for: indexPath) as? InfoMessageCell {
                    cell.configure(with: infoMessageVM)
                    return cell
                }
                
            default:
                return UITableViewCell()
            }
        }
        
        return UITableViewCell()
    }
    
}


// MARK: - UIViews Component methods
extension ListOfPopularMoviesViewController {
    
    private func configureButtonFillView() {
        buttonFillView.delegate = self
    }
    
}

// MARK: - ButtonFillViewDelegate
extension ListOfPopularMoviesViewController: ButtonFillViewDelegate {
    
    internal func buttonDidTapped(_ sender: ButtonFillView) {
        print("¡El botón ha sido presionado!")
    }
    
}
