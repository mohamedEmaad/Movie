//
//  SearchViewController.swift
//  MoviewTask
//
//  Created by Mohamed Emad on 1/13/19.
//  Copyright © 2019 Baianat. All rights reserved.
//

import UIKit
import NewBaseFrameWork
import RxSwift
import RxCocoa

class SearchViewController: ParentViewController {

    @IBOutlet weak var searchBarView: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
    var presenter: SearchPresenter!
    let disposeBag = DisposeBag()
    var searchList: BehaviorRelay<[Results]> = BehaviorRelay(value: [])
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
        self.searchTableView.estimatedRowHeight = 100
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        self.searchTableView.contentInset = insets
    }
    
    func setupListener(){
        
        // on update for the list
        self.searchList.asObservable().subscribe(onNext: { (newList) in
            self.searchTableView.reloadSectionData()
        }).disposed(by: self.disposeBag)
        
        // on click for each item in the tableview
        self.searchTableView.rx.itemSelected.subscribe({ [weak self] indexPath in
            self?.searchTableView.reloadRows(at: [indexPath.element!], with: .none)
            let selectedUser = self?.searchList.value[(indexPath.element?.row)!]
            self?.singlePersonData.tempUserDetails = (userId: selectedUser?.id ?? 0, username: selectedUser?.name ?? "", userImage: "\(profileImageLink)\(selectedUser?.profile_path ?? "")")
            self?.parent?.navigationController?.pushViewController((self?.singlePersonData)!, animated: true)
            self?.endEditing()
        }).disposed(by: self.disposeBag)
        
        self.searchBarView
            .rx.text
            .orEmpty
            .throttle(0.2, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [unowned self] query in
                self.hideEmptyLabel()
                self.page = 1
                self.searchList.accept([])
                self.presenter.searchFor(keyword: query, page: self.page)
            }).disposed(by: disposeBag)
    }
    
    func hideEmptyLabel(){
        if !self.emptyLabel.isHidden{
            self.emptyLabel.isHidden = true
        }
        
    }

    func showEmptyLabel(){
        self.emptyLabel.isHidden = false
        self.emptyLabel.text = "No results for this keyword"
    }
    
    /**
     connection the preseneter with this view controller
     */
    func setupPresenter(){
        self.presenter = SearchPresenter(disposeBag: self.disposeBag, viewPresenter: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.animateNavigationBarTitle(text: "Search")
    }
    
    class func getObject() -> SearchViewController{
        return self.create(viewControllerId: "SearchViewController", storyBoardId: "Main") as! SearchViewController
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing()
    }
}

extension SearchViewController: SearchViewPresenter{
    
    func postPageNum(page: Int) {
        self.page = page
    }
    
    func postEmptyData() {
        self.showEmptyLabel()
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    func postSearchData(persons: [Results]) {
        self.searchList.accept(self.searchList.value + persons)
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func onError(message: String) {
        self.showSnackBar(text: message, bottomMargin: -30, snackBarStatus: .error)
    }
    
    func onFailure(message: String) {
        self.showSnackBar(text: message, bottomMargin: -30, snackBarStatus: .error)
    }
    
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row >= self.searchList.value.count{
            if let cell = tableView.dequeueReusableCell(withIdentifier: loadingReusableCell, for: indexPath) as? LoadingTableViewCell{
                if !self.loading{
                    self.page = self.page + 1
                }
                cell.startLoading()
                return cell
            }
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: popularReusableCell, for: indexPath) as? PopularPersonTableViewCell{
            
            // update the cell with the data
            cell.setupViewWithPersonData(person: self.searchList.value[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    
}
