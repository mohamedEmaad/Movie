//
//  ApiHelper.swift
//  MoviewTask
//
//  Created by Mohamed Emad on 1/12/19.
//  Copyright © 2019 Baianat. All rights reserved.
//

import Foundation
import RxSwift

protocol ApiHelper {
    func getPopularPersons(page: Int) -> Observable<PopluarPersonsResponse>
    func getUserDetails(userId: Int) -> Observable<SinglePersonDetails>
    func getUserImages(userId: Int) -> Observable<ImagesResponse>
    func searchForPerson(text: String, page: Int) -> Observable<PopluarPersonsResponse>
}
