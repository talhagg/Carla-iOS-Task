//
//  RoverListVC.swift
//  Case
//
//  Created by Talha Gölcügezli on 14.06.2024.
//

import UIKit

final class RoverListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, RoversListViewModelDelegate {

    private let tableView = UITableView()
    private let loadingView = UIActivityIndicatorView(style: .large)
    
    var viewModel : RoversListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    var roversList: [RoversPresentation] = []
       
    // MARK: - Lifecycle
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.load()
        setupTableView()
        setupNavigationItem()
        setupLoadingView()
    }
       
    // MARK: - Setup
       
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
           
        tableView.register(RoversListCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
    }
       
    private func setupNavigationItem() {
        navigationItem.title = LocalizableStrings.headerTitle
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
    
    func handleViewOutput(_ output: RoversListViewModelOutput) {
        //todo
        switch output {
        case .isLoading(let isLoading):
            isLoading ? loadingView.startAnimating() : loadingView.stopAnimating()
        case .showCryptoList(let array):
            self.roversList = array
            self.tableView.reloadData()
        }
    }
    
    func navigate(to route: RoversListViewRoute) {

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roversList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! RoversListCell
        let rovers = roversList[indexPath.row]
        let imageURL = URL(string: "https://example.com/image.jpg")
        cell.configure(with: imageURL, title: rovers.name, subText1: rovers.landing_date, subText2: rovers.launch_date, status: rovers.status, statusColor: .green)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
