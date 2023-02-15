//
//  NamesTableViewCell.swift
//  Navigation
//
//  Created by Sokolov on 06.01.2023.
//

import UIKit

class NamesTableViewCell: UITableViewCell {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup(names: String) {
        self.label.text = names
    }
    private func setupView() {
        
        self.contentView.backgroundColor = .systemGray6
        
        self.contentView.addSubview(self.label)
        
        NSLayoutConstraint.activate([
        
        self.label.topAnchor.constraint(equalTo: self.contentView.topAnchor),
        self.label.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
        self.label.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
        self.label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }

}
