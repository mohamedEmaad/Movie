//
//  PopularPersonViewPresenter.swift
//  MoviewTask
//
//  Created by Mohamed Emad on 1/13/19.
//  Copyright © 2019 Baianat. All rights reserved.
//

import Foundation
import NewBaseFrameWork

protocol PopularPersonViewPresenter: StatusClass {
    func postPopularPersons(persons: [Results])
    func postPageNumber(page: Int)
}
