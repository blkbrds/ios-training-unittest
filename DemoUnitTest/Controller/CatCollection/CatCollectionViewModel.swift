//
//  CatCollectionViewModel.swift
//  DemoUnitTest
//
//  Created by Thuy Nguyen T.H on 11/10/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import MVVM

enum Errors: Error {
    case indexOutOfBound
}

extension Errors: CustomStringConvertible {

    var description: String {
        switch self {
        case .indexOutOfBound:
            return "Index is out of bound"
        }
    }
}

final class CatCollectionViewModel: ViewModel {

    var cats: [Cat] = []

    func getCats(completion: @escaping APICompletion) {
        let params = CatParams(attachBreed: 0, page: nil, limit: nil)
        CatService.getCatImages(params: params) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let cats):
                this.cats = cats
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - ViewModel
extension CatCollectionViewModel {

    func numberOfItems(inSection section: Int) -> Int {
        return cats.count
    }

    func viewModelForItem(at indexPath: IndexPath) throws -> CatCellViewModel {
        guard indexPath.row < cats.count else {
            throw Errors.indexOutOfBound
        }
        let cat = cats[indexPath.row]
        let viewModel = CatCellViewModel(cat: cat)
        return viewModel
    }
}
