//
//  SearchViewModel.swift
//  MovieBrowser
//
//  Created by Ranjith on 10/18/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
import Combine

class SearchViewModel {

    var movieModel: MovieModel?
    let errorPublisher: PassthroughSubject<String, Never> = PassthroughSubject()
    let update: PassthroughSubject<Void, Never> = PassthroughSubject()
    let spinnerVisible: PassthroughSubject<Bool, Never> = PassthroughSubject()

    func  getSearchData(searchText: String)  {
        spinnerVisible.send(true)
        RestAPIClient.getSearchData(searchText: searchText) {[weak self]  result in
            self?.spinnerVisible.send(false)
            switch  result {
            case .success(let model):
                self?.movieModel = model
                self?.update.send()
            case .failure(let error):
                self?.errorPublisher.send(error.localizedDescription)
            }
        }
    }
}

