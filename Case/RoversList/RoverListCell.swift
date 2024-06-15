//
//  RoverListCell.swift
//  Case
//
//  Created by Talha Gölcügezli on 14.06.2024.
//

import Foundation
import UIKit
import SDWebImage

class RoversListCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let customContentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    private let roversImage: UIImageView = {
        let imageView = UIImageView()
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let mainTextLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = LocalizableStrings.landingDateTitle
        return label
    }()
    
    private let mainTextLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = LocalizableStrings.launcDateTitle
        return label
    }()
    
    private let subTextLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private let subTextLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private let statusView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.right"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .brown
        return imageView
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
            titleLabel.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: roversImage.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -8)
        ])
        
        customContentView.addSubview(mainTextLabel1)
        mainTextLabel1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTextLabel1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            mainTextLabel1.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
        
        customContentView.addSubview(mainTextLabel2)
        mainTextLabel2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTextLabel2.topAnchor.constraint(equalTo: mainTextLabel1.topAnchor),
            mainTextLabel2.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -24)
        ])
        
        customContentView.addSubview(subTextLabel1)
        subTextLabel1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subTextLabel1.topAnchor.constraint(equalTo: mainTextLabel1.bottomAnchor, constant: 8),
            subTextLabel1.leadingAnchor.constraint(equalTo: mainTextLabel1.leadingAnchor)
        ])
        
        customContentView.addSubview(subTextLabel2)
        subTextLabel2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subTextLabel2.topAnchor.constraint(equalTo: subTextLabel1.topAnchor),
            subTextLabel2.leadingAnchor.constraint(equalTo: mainTextLabel2.leadingAnchor)
        ])
        
        customContentView.addSubview(statusView)
        statusView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusView.topAnchor.constraint(equalTo: subTextLabel1.bottomAnchor, constant: 8),
            statusView.leadingAnchor.constraint(equalTo: subTextLabel1.leadingAnchor),
            statusView.widthAnchor.constraint(equalToConstant: 80),
            statusView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        statusView.addSubview(statusLabel)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusLabel.centerXAnchor.constraint(equalTo: statusView.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: statusView.centerYAnchor)
        ])
        
        customContentView.addSubview(chevronImageView)
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chevronImageView.bottomAnchor.constraint(equalTo: customContentView.bottomAnchor, constant: -8),
            chevronImageView.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -8),
            chevronImageView.widthAnchor.constraint(equalToConstant: 24),
            chevronImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    // MARK: - Configuration
    
    func configure(with imageURL: URL?, title: String, subText1: String, subText2: String, status: String) {
        roversImage.sd_setImage(with: imageURL)
        titleLabel.text = title
        let formattedSubText1 = DateFormatterHelper.shared.formatDate(subText1)
        let formattedSubText2 = DateFormatterHelper.shared.formatDate(subText2)
           
        subTextLabel1.text = formattedSubText1
        subTextLabel2.text = formattedSubText2
        statusLabel.text = status
        
        if status == "Deactive" {
            statusView.backgroundColor = .red
            statusView.layer.borderColor = UIColor.lightGray.cgColor
        } else {
            statusView.backgroundColor = .systemGreen
            statusView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    // MARK: DEINIT
    
    deinit {
        print("RoversListCell Deinited.")
    }
}
