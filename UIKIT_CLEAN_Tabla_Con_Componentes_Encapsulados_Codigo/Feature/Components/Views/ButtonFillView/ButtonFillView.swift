//
//  ButtonFillView.swift
//  UIKIT_CLEAN_Tabla_Con_Componentes_Encapsulados_Codigo
//
//  Created by Gonzalo Arques on 2/2/25.
//

import UIKit

class ButtonFillView: UIView {
    
    // MARK: - UI Closures
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = CustomColors.magenta
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
    }()
    
    // MARK: - Variables
    weak var delegate: ButtonFillViewDelegate?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        addSubview(contentView)
        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // MARK: - Button Action
    private func setupButtonAction() {
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        delegate?.buttonDidTapped(self)
    }
    
}

// Patrón de delegado:
protocol ButtonFillViewDelegate: AnyObject {
    func buttonDidTapped(_ sender: ButtonFillView)
}
