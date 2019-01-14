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
    private lazy var singlePersonData = SinglePersonViewController.getObject()

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
        
        // on update for the list
        self.popularPersonList.asObservable().subscribe(onNext: { (newList) in
            self.page == 1 ? self.popularTableView.reloadSectionData() : self.popularTableView.reloadData()
        }).disposed(by: self.disposeBag)
        
        // on click for each item in the tableview
        self.popularTableView.rx.itemSelected.subscribe({ [weak self] indexPath in
            self?.popularTableView.reloadRows(at: [indexPath.element!], with: .none)
            let selectedUser = self?.popularPersonList.value[(indexPath.element?.row)!]
            self?.singlePersonData.tempUserDetails = (userId: selectedUser?.id ?? 0, username: selectedUser?.name ?? "", userImage: "\(profileImageLink)\(selectedUser?.profile_path ?? "")")
            self?.parent?.navigationController?.pushViewController((self?.singlePersonData)!, animated: true)
        }).disposed(by: self.disposeBag)
    }
    
    /**
        handles refreshing data
     */
    @objc func refreshData(){
        self.page = 1
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.animateNavigationBarTitle(text: "Popular")
    }

    class func getObject() -> PoplarPersonsViewController{
        return self.create(viewControllerId: "PoplarPersonsViewController", storyBoardId: "Main") as! PoplarPersonsViewController
    }
}

extension PoplarPersonsViewController: PopularPersonViewPresenter{
    func postPageNumber(page: Int) {
        self.page = page
    }
    
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
        self.showSnackBar(text: message, bottomMargin: -30, snackBarStatus: .error)
    }
    
    func onFailure(message: String) {
        self.showSnackBar(text: message, bottomMargin: -30, snackBarStatus: .error)
    }
    
}

extension PoplarPersonsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.popularPersonList.value.count > 0 ? self.popularPersonList.value.count + 1 : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row >= self.popularPersonList.value.count{
            if let cell = tableView.dequeueReusableCell(withIdentifier: loadingReusableCell, for: indexPath) as? LoadingTableViewCell{
                if !self.loading{
                    self.page = self.page + 1
                    self.getPopularListNow(showLoading: false)
                }
                cell.startLoading()
                return cell
            }
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: popularReusableCell, for: indexPath) as? PopularPersonTableViewCell{

            // update the cell with the data
            cell.setupViewWithPersonData(person: self.popularPersonList.value[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }


}
