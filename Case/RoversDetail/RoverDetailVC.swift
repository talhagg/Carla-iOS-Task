//
//  RoverDetailVC.swift
//  Case
//
//  Created by Talha Gölcügezli on 14.06.2024.
//

import Foundation
import UIKit
import SDWebImage

final class RoverDetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate, RoverDetailViewModelDelegate, UIScrollViewDelegate {
    
    var viewModel : RoverDetailViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    var roversDetailList: [LatestPhotosPresentation] = []
    
    private let loadingView = UIActivityIndicatorView(style: .large)
    
    let label1: UILabel = {
        let label = UILabel()
        label.text = LocalizableStrings.detailNumberTitle
        return label
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.text = LocalizableStrings.detailNumberTitle
        return label
    }()
    
    let imageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .systemYellow
        return pageControl
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        viewModel.load()
        
        let closeIcon = UIImage(systemName: "xmark")
        let closeButton = UIBarButtonItem(image: closeIcon, style: .plain, target: self, action: #selector(dismissPage))
        closeButton.tintColor = .black
        navigationItem.leftBarButtonItem = closeButton
        
        view.addSubview(imageScrollView)
        view.addSubview(pageControl)
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(tableView)
        
        setupImageScrollView()
        setupTableView()
        setupLoadingView()
    }
    
    
    func setupImageScrollView() {
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageScrollView.heightAnchor.constraint(equalToConstant: 200),
            
            pageControl.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: -24),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        imageScrollView.delegate = self
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(RoversDetailCell.self, forCellReuseIdentifier: "DetailCell")
        
        label1.translatesAutoresizingMaskIntoConstraints = false
        label2.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 16),
            label1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 8),
            label2.leadingAnchor.constraint(equalTo: label1.leadingAnchor),
            
            tableView.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupLoadingView() {
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        loadingView.color = .systemYellow
        loadingView.hidesWhenStopped = true
    }
    
    func handleViewOutput(_ output: RoverDetailViewModelOutput) {
        switch output {
        case .isLoading(let isLoading):
            isLoading ? loadingView.startAnimating() : loadingView.stopAnimating()
        case .updateTitle(let roverName):
            title = roverName
        case .showRoverDetailList(let array):
            roversDetailList = array
            tableView.reloadData()
            updateLabels()
            setupImageViews()
        }
    }
    
    func updateLabels() {
        if let firstItem = roversDetailList.first {
            label1.text = "\(LocalizableStrings.detailNumberTitle) \(firstItem.id)"
            label2.text = "\(LocalizableStrings.detailNumberPhotosTitle) \(firstItem.rovers.total_photos)"
        }
    }
    
    func setupImageViews() {
        imageScrollView.subviews.forEach { $0.removeFromSuperview() }
            
        let imageCount = min(roversDetailList.count, 3)
        pageControl.numberOfPages = imageCount
            
        guard imageCount > 0 else {
            imageScrollView.isHidden = true
            pageControl.isHidden = true
            return
        }
            
        imageScrollView.isHidden = false
        pageControl.isHidden = false
            
        for i in 0..<imageCount {
            let imageView = UIImageView()
            let item = roversDetailList[i]
            imageView.sd_setImage(with: URL(string: item.img_src))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
                
            let xPosition = imageScrollView.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: imageScrollView.frame.width, height: 200)
            
            imageScrollView.addSubview(imageView)
        }
        
        imageScrollView.contentSize.width = imageScrollView.frame.width * CGFloat(imageCount)
    }

    
    @objc func dismissPage() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roversDetailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! RoversDetailCell
        let rovers = roversDetailList[indexPath.row]
        
        let cameraName: String
        if indexPath.row < rovers.rovers.cameras.count {
            cameraName = rovers.rovers.cameras[indexPath.row].full_name ?? ""
        } else {
            cameraName = rovers.camera.full_name
        }
        
        cell.configure(with: URL(string: rovers.img_src), title: rovers.id, mainLabel: cameraName, subText1: rovers.earth_date)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = lround(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
