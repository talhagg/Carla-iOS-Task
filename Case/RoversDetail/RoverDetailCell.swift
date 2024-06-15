//
//  RoverDetailCell.swift
//  Case
//
//  Created by Talha Gölcügezli on 14.06.2024.
//

import Foundation
import UIKit
import SDWebImage

class RoversDetailCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let customContentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let roversImage: UIImageView = {
        let imageView = UIImageView()
        imageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        imageView.layer.cornerRadius = 4.0
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .brown
        return label
    }()
    
    private let mainTextLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    private let subTextLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    

    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        contentView.addSubview(customContentView)
        customContentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            customContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            customContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            customContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        customContentView.addSubview(roversImage)
        roversImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            roversImage.centerYAnchor.constraint(equalTo: customContentView.centerYAnchor),
            roversImage.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor, constant: 8)
        ])
        
        customContentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: roversImage.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -8)
        ])
        
        customContentView.addSubview(mainTextLabel1)
        mainTextLabel1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTextLabel1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            mainTextLabel1.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            mainTextLabel1.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -8),
            
        ])
        
        customContentView.addSubview(subTextLabel1)
        subTextLabel1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subTextLabel1.topAnchor.constraint(equalTo: mainTextLabel1.bottomAnchor, constant: 16),
            subTextLabel1.leadingAnchor.constraint(equalTo: mainTextLabel1.leadingAnchor)
        ])
        

    }
    
    // MARK: - Configuration
    
    func configure(with imageURL: URL?, title: Int, mainLabel: String, subText1: String) {
        roversImage.sd_setImage(with: imageURL)
        titleLabel.text = "ID: \(title)"
        mainTextLabel1.text = mainLabel
        let formattedSubText1 = DateFormatterHelper.shared.formatDate(subText1)
        subTextLabel1.text = formattedSubText1
    }
    
    // MARK: DEINIT
    
    deinit {
        print("RoverDetailCell Deinited.")
    }
}


