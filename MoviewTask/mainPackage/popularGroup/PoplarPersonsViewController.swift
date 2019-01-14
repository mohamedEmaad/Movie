//
//  PoplarPersonsViewController.swift
//  MoviewTask
//
//  Created by Mohamed Emad on 1/13/19.
//  Copyright © 2019 Baianat. All rights reserved.
//

import UIKit
import NewBaseFrameWork
import RxSwift
import RxCocoa

class PoplarPersonsViewController: ParentViewController{
    
    @IBOutlet weak var popularTableView: UITableView!
    var presenter: PopularPersonsPresenter!
    var refreshController: UIRefreshControl!
    let disposeBag = DisposeBag()
    var popularPersonList: BehaviorRelay<[Results]> = BehaviorRelay(value: [])
    var loading = false
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupViews()
        self.setupPresenter()
        self.setupListener()
    }
    
    func setupViews(){
        self.popularTableView.estimatedRowHeight = 100
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        self.popularTableView.contentInset = insets
        self.refreshController = self.popularTableView.addRefreshSubview()
        self.refreshController.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
    }
    
    func setupListener(){
        self.popularPersonList.asObservable().subscribe(onNext: { (newList) in
            self.popularTableView.reloadSectionData()
        }).disposed(by: self.disposeBag)
    }
    
    /**
        handles refreshing data
     */
    @objc func refreshData(){
        self.popularPersonList.accept([])
        self.getPopularListNow(showLoading: false)
    }
    
    func getPopularListNow(showLoading: Bool){
        self.presenter.getPopularPesons(page: self.page, showLoading: showLoading)
    }
    
    /**
        connection the preseneter with this view controller
     */
    func setupPresenter(){
        self.presenter = PopularPersonsPresenter(disposeBag: self.disposeBag, viewPresenter: self)
        self.getPopularListNow(showLoading: true)
    }

    class func getObject() -> PoplarPersonsViewController{
        return self.create(viewControllerId: "PoplarPersonsViewController", storyBoardId: "Main") as! PoplarPersonsViewController
    }
}

extension PoplarPersonsViewController: PopularPersonViewPresenter{
    func postPopularPersons(persons: [Results]) {
        self.loading = false
        self.popularPersonList.accept(self.popularPersonList.value + persons)
    }
    
    func showLoading() {
        self.refreshController.programaticallyBeginRefreshing(in: self.popularTableView)
    }
    
    func hideLoading() {
        self.refreshController.endRefreshing()
    }
    
    func onError(message: String) {
        self.showSnackBar(text: message)
    }
    
    func onFailure(message: String) {
        self.showSnackBar(text: message)
    }
    
}

extension PoplarPersonsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.popularPersonList.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: popularReusableCell, for: indexPath) as? PopularPersonTableViewCell{

            // update the cell with the data
            cell.setupViewWithPersonData(person: self.popularPersonList.value[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }


}
