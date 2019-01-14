//
//  DataManagerImp.swift
//  MoviewTask
//
//  Created by Mohamed Emad on 1/12/19.
//  Copyright © 2019 Baianat. All rights reserved.
//

import Foundation
import RxSwift

class DataManagerImp: DataManager {
    
    let apiHelper: ApiHelper
    
    init(apiHelper: ApiHelper) {
        self.apiHelper = apiHelper
    }
    
    func getPopularPersons(page: Int) -> Observable<PopluarPersonsResponse> {
        return apiHelper.getPopularPersons(page: page)
    }
}
