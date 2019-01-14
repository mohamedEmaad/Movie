//
//  SinglePersonViewPresenter.swift
//  MoviewTask
//
//  Created by Mohamed Emad on 1/14/19.
//  Copyright © 2019 Baianat. All rights reserved.
//

import Foundation
import NewBaseFrameWork

protocol SinglePersonViewPresenter: StatusClass {
    func postUserData(userDetails: SinglePersonDetails)
    func postUserImages(profiles: [Profiles])
}
