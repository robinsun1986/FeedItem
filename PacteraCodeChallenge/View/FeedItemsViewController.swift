//
//  FeedItemsViewController.swift
//  SDWebImageTest
//
//  Created by Robin Sun on 13/8/17.
//  Copyright © 2017 abc. All rights reserved.
//

import UIKit

class FeedItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FeedItemsViewModelDelegate {

    var viewModel = FeedItemsViewModel()
    
    var tableView: UITableView?
    var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupNavigationBarStyle()
        setupTableView()
        setupViewModel()
        
        viewModel.getFeedItems()
    }
    
    private func setupView() {
        title = FeedItemsViewModel.kPageTitle
        view.backgroundColor = UIColor.white
    }

    // setup tableview
    private func setupTableView() {
        tableView = UITableView()
        view.addSubview(tableView!)
        
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: tableView!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: tableView!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: tableView!, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: tableView!, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0)
        view.addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
        
        tableView?.tableFooterView = UIView()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(FeedItemCell.self, forCellReuseIdentifier: FeedItemsViewModel.kCellId)
    }
    
    // setup navigation bar style
    func setupNavigationBarStyle() {
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.isTranslucent = true
    }
    
    // setup viewmodel
    func setupViewModel() {
        viewModel.delegate = self
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedItemsViewModel.kCellId, for: indexPath) as! FeedItemCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    // MARK: - FeedItemsViewModelDelegate
    func getFeedItemsOnSuccess() {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    func getFeedItemsOnFailure(errMsg: String) {
        DispatchQueue.main.async {
            UIUtils.alert(title: "", message: errMsg, viewController: self)
        }
    }
    
    func refreshOnComplete() {
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
        }
    }
}
