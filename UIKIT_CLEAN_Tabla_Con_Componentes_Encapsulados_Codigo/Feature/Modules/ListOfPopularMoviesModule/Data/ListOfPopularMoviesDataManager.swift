//
//  ListOfPopularMoviesDataManager.swift
//  UIKIT_CLEAN_Tabla_Con_Componentes_Encapsulados_Codigo
//
//  Created by Gonzalo Arques on 2/2/25.
//

import Foundation

class ListOfPopularMoviesDataManager {}

// MARK: - API Services data methods
extension ListOfPopularMoviesDataManager {
    
    func getListOfPopularMoviesFromAPI() async -> ListOfPopularMovieResultsResponseEntity {
        let apiEndpointURL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(SensitiveConfiguration.apiKey)")!
        let (dataObtained, _) = try! await URLSession.shared.data(from: apiEndpointURL)
        do {
            let popularMovieResponseEntity = try JSONDecoder().decode(ListOfPopularMovieResultsResponseEntity.self, from: dataObtained)
            return popularMovieResponseEntity
        } catch {
            print("Error decoding API response: \(error)")
            return ListOfPopularMovieResultsResponseEntity(results: [])
        }
    }
    
    internal func fetchListOfPopularMoviesVMFromAPI() async -> [PopularMovieListCellViewModel] {
        let listOfPopularMoviesEntities = await getListOfPopularMoviesFromAPI().results
        
        let mapper = PopularMovieListCellMapper()
        let listOfPopularMoviesVM = listOfPopularMoviesEntities.map(mapper.mapEntityToViewModel(entity:))
        
        return listOfPopularMoviesVM
    }
    
}

// MARK: - Local data methods
extension ListOfPopularMoviesDataManager {
    
    internal func fetchListOfPopularMoviesVMFromLocal() -> [PopularMovieListCellViewModel] {
        var listOfPopularMoviesVMLocal: [PopularMovieListCellViewModel] = []
        
        let firstHardcodedPopularMovieVM = PopularMovieListCellViewModel(title: "La sustancia", overview: "(hardcoded)", imageURL: URL(string: ""))
        listOfPopularMoviesVMLocal.append(firstHardcodedPopularMovieVM)
        
        let secondHardcodedPopularMovieVM = PopularMovieListCellViewModel(title: "Hereje", overview: "(hardcoded)", imageURL: URL(string: ""))
        listOfPopularMoviesVMLocal.append(secondHardcodedPopularMovieVM)
        
        return listOfPopularMoviesVMLocal
    }
    
    internal func fetchListOfInfoMessagesFromLocal() -> [InfoMessageCellViewModel] {
        var listOfInfoMessagesLocal: [InfoMessageCellViewModel] = []
        
        let firstHardcodedInfoMessage = InfoMessageCellViewModel(message: "Primer mensaje de info (hardcoded)")
        listOfInfoMessagesLocal.append(firstHardcodedInfoMessage)
        
        let secondHardcodedInfoMessage = InfoMessageCellViewModel(message: "Segundo mensaje de info (hardcoded)")
        listOfInfoMessagesLocal.append(secondHardcodedInfoMessage)
        
        return listOfInfoMessagesLocal
    }
    
}
