//
//  SinglePersonPreseneter.swift
//  MoviewTask
//
//  Created by Mohamed Emad on 1/14/19.
//  Copyright © 2019 Baianat. All rights reserved.
//

import Foundation
import RxSwift

class SinglePersonPreseneter {
    
    let viewPresneter: SinglePersonViewPresenter!
    let disposeBag: DisposeBag
    private let dataManger: DataManager = (UIApplication.shared.delegate as! AppDelegate).dataManger
    
    init(disposeBag: DisposeBag, viewPresenter: SinglePersonViewPresenter) {
        self.disposeBag = disposeBag
        self.viewPresneter = viewPresenter
    }
    
    func getUserDetails(userId: Int){
        self.getUserDetailsResponse(observable: self.dataManger.getUserDetails(userId: userId))
        self.getUserImages(userId: userId)
    }
    
    func getUserDetailsResponse(observable: Observable<SinglePersonDetails>){
        
        observable.asObservable().subscribe(onNext: { (response) in
            self.viewPresneter.hideLoading()
            self.viewPresneter.postUserData(userDetails: response)
            
        }, onError: { (error) in
            self.viewPresneter.hideLoading()
            self.viewPresneter.onFailure(message: "network error")
        }).disposed(by: self.disposeBag)
        
    }
    
    func getUserImages(userId: Int){
        self.getUserImagesResponse(observable: self.dataManger.getUserImages(userId: userId))
    }
    
    func getUserImagesResponse(observable:  Observable<ImagesResponse>){
        
        observable.asObservable().subscribe(onNext: { (response) in
            self.viewPresneter.hideLoading()
            self.viewPresneter.postUserImages(profiles: response.profiles ?? [])
        }, onError: { (error) in
            self.viewPresneter.onFailure(message: "networkError")
        }).disposed(by: self.disposeBag)
        
    }
}
