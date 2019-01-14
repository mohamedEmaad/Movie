//
//  SearchPresenterImp.swift
//  MoviewTask
//
//  Created by Mohamed Emad on 1/13/19.
//  Copyright © 2019 Baianat. All rights reserved.
//

import Foundation
import RxSwift

class SearchPresenter {
    
    let disposeBag: DisposeBag!
    let viewPresenter: SearchViewPresenter!
    private let dataManger: DataManager = (UIApplication.shared.delegate as! AppDelegate).dataManger
    
    init(disposeBag: DisposeBag, viewPresenter: SearchViewPresenter) {
        self.disposeBag = disposeBag
        self.viewPresenter = viewPresenter
    }
    
    func searchFor(keyword: String, page: Int){
        self.getSearchResponse(observable: self.dataManger.searchForPerson(text: keyword, page: page), page: page)
    }
    
    func getSearchResponse(observable: Observable<PopluarPersonsResponse>, page: Int){
        
        observable.asObservable().subscribe(onNext: { (response) in
            self.viewPresenter.hideLoading()
            let theResponse = response.results
            if theResponse?.count == 0 && page == 1{
                self.viewPresenter.postEmptyData()
            }
            self.viewPresenter.postSearchData(persons: theResponse ?? [])
            
        }, onError: { (error) in
            self.viewPresenter.hideLoading()
            self.viewPresenter.postPageNum(page: page == 1 ? 1: page - 1)
            self.viewPresenter.onFailure(message: "networkError")
        }).disposed(by: self.disposeBag)
    }
    
}
