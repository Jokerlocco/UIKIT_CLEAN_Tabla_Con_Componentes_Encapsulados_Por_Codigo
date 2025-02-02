//
//  ItemListCell.swift
//  UIKIT_CLEAN_Tabla_Con_Componentes_Encapsulados_Codigo
//
//  Created by Gonzalo Arques on 2/2/25.
//

import UIKit
import Kingfisher

class ItemListCell: UITableViewCell {
    
    // MARK: - UI Closures
    let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let itemTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16,
                                 weight: .bold,
                                 width: .condensed)
        label.textColor = CustomColors.magenta
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let itemDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12,
                                 weight: .regular,
                                 width: .standard)
        label.textColor = CustomColors.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    func setupViews() {
        addSubview(itemImageView)
        addSubview(itemTitleLabel)
        addSubview(itemDescriptionLabel)
        
        NSLayoutConstraint.activate([
            itemImageView.heightAnchor.constraint(equalToConstant: 200),
            itemImageView.widthAnchor.constraint(equalToConstant: 100),
            itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            itemImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            itemImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -12),
            
            itemTitleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 18),
            itemTitleLabel.topAnchor.constraint(equalTo: itemImageView.topAnchor, constant: 24),
            itemTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            itemDescriptionLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 20),
            itemDescriptionLabel.topAnchor.constraint(equalTo: itemTitleLabel.bottomAnchor, constant: 8),
            itemDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            itemDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10)
        ])
    }
    
    // MARK: - Configure methods
    internal func configure(viewModel: PopularMovieListCellViewModel) {
        itemTitleLabel.text = viewModel.title
        itemDescriptionLabel.text = viewModel.overview
        itemImageView.kf.setImage(with: viewModel.imageURL) // Usamos este método del framework externo que hemos importado (KingFisher) para obtener la imagen por URL de una forma más cómoda que con UIKIT base.
        
    }
    
}
