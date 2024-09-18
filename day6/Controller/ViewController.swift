//
//  ViewController.swift
//  day6
//
//  Created by Doeun Kwon on 2024-09-17.
//

import UIKit

class ViewController: UIViewController {
    
    private let session = Session()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.allowsMultipleSelection = true
        view.backgroundColor = .white
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        
        return view
    }()
    
    let calculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("get odds", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold).rounded()
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .white
        
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor(gray: 0.9, alpha: 0.5)
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 0, height: 14)
        button.layer.shadowRadius = 10
        button.layer.cornerRadius = 30
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        session.generateDeck()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        view.addSubview(calculateButton)
        
        calculateButton.addTarget(self, action: #selector(calculateOdds), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
        
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            calculateButton.widthAnchor.constraint(equalToConstant: 160),
            calculateButton.heightAnchor.constraint(equalToConstant: 60),
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calculateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        
        ])
        
    }
    
    @objc private func calculateOdds() {
        calculateButton.isEnabled = false
        calculateButton.setTitle("thinking", for: .normal)
        calculateButton.setTitleColor(.gray, for: .normal)
        calculateButton.layer.opacity = 0.5
        DispatchQueue.global(qos: .default).async {
            let odds = self.session.calculateOdds(numSimulations: 100000)
            DispatchQueue.main.async {
                self.calculateButton.layer.opacity = 1.0
                self.calculateButton.setTitle(String(format: "%.2f", odds * 100) + "%", for: .normal)
                self.calculateButton.setTitleColor(intToUIColor(value: odds), for: .normal)
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.calculateButton.setTitle("get odds", for: .normal)
                    self.calculateButton.setTitleColor(.blue, for: .normal)
                    self.calculateButton.isEnabled = true
                }
            }
        }
    }
    
}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return session.deck.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cardCell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as? CardCollectionViewCell else {
            fatalError("Could not dequeue CardCollectionViewCell")
        }
        
        let card = session.deck[indexPath.item]
        
        // Reset the cell's appearance to avoid issues with reused cells
        cardCell.contentView.layer.borderWidth = 0
        cardCell.contentView.layer.borderColor = UIColor.clear.cgColor
        cardCell.contentView.layer.shadowOpacity = 0.05
        
        // Check if the card is selected (either as a hole card or community card) and update the appearance
        if session.holeCards.contains(card) {
            cardCell.updateBorderGlow(role: .hole)  // Green border for hole cards
        } else if session.communityCards.contains(card) {
            cardCell.updateBorderGlow(role: .community) // Blue border for community cards
        } else {
            // Default appearance for unselected cards
            cardCell.contentView.layer.borderWidth = 0
            cardCell.contentView.layer.borderColor = UIColor.clear.cgColor
        }

        // Configure the card's content (rank, suit, etc.)
        cardCell.setColor(to: card.suit == "♥️" || card.suit == "♦️" ? .red : .black)
        cardCell.rank.text = {
            if card.rank > 10 {
                switch card.rank {
                case 11:
                    return "J"
                case 12:
                    return "Q"
                case 13:
                    return "K"
                case 14:
                    return "A"
                default:
                    return "?"
                }
            }
            return String(card.rank)
        }()
        cardCell.suit.text = card.suit
        
        return cardCell
    }
}

// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard session.holeCards.count + session.communityCards.count <= 6 else {
            collectionView.deselectItem(at: indexPath, animated: true)
            return
        }
        
        let card = session.deck[indexPath.item]
        session.addCardToPicked(card)
        
        guard let cardCell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell else { fatalError("Could not dequeue CardCollectionViewCell") }
                
        if session.holeCards.contains(card) {
            cardCell.updateBorderGlow(role: .hole)
        } else if session.communityCards.contains(card) {
            cardCell.updateBorderGlow(role: .community)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let card = session.deck[indexPath.item]
        session.removeCardFromPicked(card)
        
        guard let cardCell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell else { fatalError("Could not dequeue CardCollectionViewCell") }
        
        cardCell.updateBorderGlow(role: .burn)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.frame.width / session.cardsPerRow) - ceil((session.spacingBetweenCards * (session.cardsPerRow - 1)) / session.cardsPerRow) - ceil((session.spacingBetweenCards * 2) / session.cardsPerRow)
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return session.spacingBetweenCards
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return session.spacingBetweenCards
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: session.spacingBetweenCards, bottom: 100, right: session.spacingBetweenCards)
    }
    
}
