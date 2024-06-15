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
    private let titleLabel = UILabel()
    
    let roverImageURLs = [
        LocalizableStrings.roverImageURLCuriosity,
        LocalizableStrings.roverImageURLSpirit,
        LocalizableStrings.roverImageURLOpportunity,
        LocalizableStrings.roverImageURLPerseverance
    ]
    
    var viewModel : RoversListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    var roversList: [RoversPresentation] = []
       
    // MARK: - Lifecycle
       
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.load()
        
        setupTitleLabel()
        setupTableView()
        setupNavigationItem()
        setupLoadingView()
    }
       
    // MARK: - Setup
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.text = LocalizableStrings.mainTitle
    }
       
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
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
        switch output {
        case .isLoading(let isLoading):
            isLoading ? loadingView.startAnimating() : loadingView.stopAnimating()
        case .showRoversList(let array):
            self.roversList = array
            self.tableView.reloadData()
        }
    }
    
    func navigate(to route: RoversListViewRoute) {
        switch route {
        case .detail:
            if let roverListViewModel = viewModel as? RoverListViewModel {
                let detailVC = RoverDetailBuilder.make(roverName: roverListViewModel.getSelectedRoverName())
                navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roversList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! RoversListCell
        let rovers = roversList[indexPath.row]
        
        if indexPath.row < roverImageURLs.count {
            let imageURL = URL(string: roverImageURLs[indexPath.row])
            cell.configure(with: imageURL, title: rovers.name, subText1: rovers.landing_date, subText2: rovers.launch_date, status: rovers.status)
        } else {
            cell.configure(with: nil, title: rovers.name, subText1: rovers.landing_date, subText2: rovers.launch_date, status: rovers.status)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRover = roversList[indexPath.row]
        viewModel.selectedRovers(selectedRover)
    }
}
