//
//  PopularPersonsPresenter.swift
//  MoviewTask
//
//  Created by Mohamed Emad on 1/13/19.
//  Copyright © 2019 Baianat. All rights reserved.
//

import Foundation
import UIKit
import NewBaseFrameWork
import RxSwift

class PopularPersonsPresenter{
    
    let viewPresneter: PopularPersonViewPresenter!
    let disposeBag: DisposeBag
    private let dataManger: DataManager = (UIApplication.shared.delegate as! AppDelegate).dataManger
    
    init(disposeBag: DisposeBag, viewPresenter: PopularPersonViewPresenter) {
        self.disposeBag = disposeBag
        self.viewPresneter = viewPresenter
    }
    
    func getPopularPesons(page: Int, showLoading: Bool){
        if showLoading{
            self.viewPresneter.showLoading()
        }
        self.getPopularPersonsResponse(observable: self.dataManger.getPopularPersons(page: page), page: page)
    }
    
    func getPopularPersonsResponse(observable: Observable<PopluarPersonsResponse>, page: Int){
        
        observable.asObservable().subscribe(onNext: { (response) in
            self.viewPresneter.hideLoading()
            let theResponse = response.results
            self.viewPresneter.postPopularPersons(persons: theResponse ?? [Results]())
        }, onError: { (error) in
            self.viewPresneter.hideLoading()
            self.viewPresneter.onFailure(message: "network Error")
            self.viewPresneter.postPageNumber(page: page > 1 ? page - 1 : 1)
        }).disposed(by: self.disposeBag)
        
    }
    
}
