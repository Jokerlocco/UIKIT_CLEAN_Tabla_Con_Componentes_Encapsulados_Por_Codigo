//
//  ListOfPopularMoviesDataModel.swift
//  UIKIT_CLEAN_Tabla_Con_Componentes_Encapsulados_Codigo
//
//  Created by Gonzalo Arques on 2/2/25.
//

import Foundation

// MARK: - Entities
struct ListOfPopularMovieResultsResponseEntity: Decodable {
    let results: [PopularMovieEntity]
}

struct PopularMovieEntity: Decodable {
    var id: Int
    var title: String
    var overview: String
    var imageURL: String
    var votes: Double
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case imageURL = "poster_path" // Como la variable tiene un nombre distinto al de la API, lo indicamos de esta forma
        case votes = "vote_average"
    }
}

// MARK: - ViewModel
struct PopularMovieListCellViewModel {
    let title: String
    let overview: String
    var imageURL: URL?
}

// MARK: - Mapper
struct PopularMovieListCellMapper {
    
    func mapEntityToViewModel(entity: PopularMovieEntity) -> PopularMovieListCellViewModel {
        PopularMovieListCellViewModel(title: entity.title,
                                      overview: "Sinopsis: \n" + entity.overview,
                                      imageURL: URL(string: "https://image.tmdb.org/t/p/w200" + entity.imageURL))
    }
    
}
