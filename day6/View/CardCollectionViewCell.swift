//
//  CardCollectionViewCell.swift
//  day6
//
//  Created by Doeun Kwon on 2024-09-17.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "cardCollectionViewCell"
    
    let suit: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 15)
        return view
    }()
    
    lazy var rank: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 15, weight: .black).rounded()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateBorderGlow(role: Role) {
        if role == .hole {
            contentView.layer.borderColor = UIColor.blue.cgColor
            contentView.layer.shadowColor = UIColor.blue.cgColor
            contentView.layer.borderWidth = 2
            contentView.layer.shadowOpacity = 0.2
        } else if role == .community {
            contentView.layer.borderColor = UIColor.red.cgColor
            contentView.layer.shadowColor = UIColor.red.cgColor
            contentView.layer.borderWidth = 2
            contentView.layer.shadowOpacity = 0.2
        } else if role == .burn {
            contentView.layer.borderColor = UIColor.clear.cgColor
            contentView.layer.shadowColor = UIColor.black.cgColor
            contentView.layer.borderWidth = 0
            contentView.layer.shadowOpacity = 0.05
        }
    }
    
    private func setupView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.05
        contentView.layer.shadowOffset = CGSize(width: 0, height: 7)
        contentView.layer.shadowRadius = 5
        
        let stackView = UIStackView(arrangedSubviews: [rank, suit])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        
        ])
    }
    
    func setColor(to newColor: UIColor) {
        rank.textColor = newColor
    }
    
}
