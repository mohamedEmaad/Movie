//
//  ApiHelperImp.swift
//  MoviewTask
//
//  Created by Mohamed Emad on 1/12/19.
//  Copyright © 2019 Baianat. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class ApiHelperImp: ApiHelper {
   
    func searchForPerson(text: String, page: Int) -> Observable<PopluarPersonsResponse> {
        return Observable<PopluarPersonsResponse>.create({ (observer) -> Disposable in
            
            let todosEndpoint = "\(BASE_URL)search/person?api_key=\(apiKey)&language=en-US&query=\(text)&page=\(page)&include_adult=false"
            
            Alamofire.request(todosEndpoint, method: .get, encoding: JSONEncoding.default)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        do{
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(PopluarPersonsResponse.self, from: response.data! )
                            
                            observer.onNext(responseModel)
                            observer.onCompleted()
                            
                        }catch{
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
            }
            return Disposables.create()
        })
    }
    
    func getUserImages(userId: Int) -> Observable<ImagesResponse> {
        return Observable<ImagesResponse>.create({ (observer) -> Disposable in
            let todosEndpoint = "\(BASE_URL)person/\(userId)/images?api_key=\(apiKey)"
            
            Alamofire.request(todosEndpoint, method: .get, encoding: JSONEncoding.default)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        do{
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(ImagesResponse.self, from: response.data! )
                            
                            observer.onNext(responseModel)
                            observer.onCompleted()
                            
                        }catch{
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
            }
            return Disposables.create()
        })
    }
    
    
    func getUserDetails(userId: Int) -> Observable<SinglePersonDetails> {
        return Observable<SinglePersonDetails>.create({ (observer) -> Disposable in
            let todosEndpoint: String = "\(BASE_URL)person/\(userId)?api_key=\(apiKey)&language=en-US"
            
            Alamofire.request(todosEndpoint, method: .get, encoding: JSONEncoding.default)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        do{
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(SinglePersonDetails.self, from: response.data! )
                            
                            observer.onNext(responseModel)
                            observer.onCompleted()
                            
                        }catch{
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
            }
            return Disposables.create()
        })
    }
    
    func getPopularPersons(page: Int) -> Observable<PopluarPersonsResponse> {
        return Observable<PopluarPersonsResponse>.create({ (observer) -> Disposable in
            let todosEndpoint: String = "\(BASE_URL)person/popular?api_key=\(apiKey)&language=en-US&page=\(page)"
            
            Alamofire.request(todosEndpoint, method: .get, encoding: JSONEncoding.default)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        do{
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(PopluarPersonsResponse.self, from: response.data! )
                            
                            observer.onNext(responseModel)
                            observer.onCompleted()
                            
                        }catch{
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
            }
            return Disposables.create()
        })
    }
    
}
