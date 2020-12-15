//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0052 on 12/16/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Alamofire
import OHHTTPStubs

@testable import DemoUnitTest

final class CatCollectionViewModelTest: QuickSpec {
    override func spec() {
        var viewModel: CatCollectionViewModel!
        
        describe("Test func `getCats`") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
            }
            context("Get success response ") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { (result) in
                        switch result {
                        case .success:
                            expect {
                                try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                            }.to(beAnInstanceOf(CatCellViewModel.self))
                        case .failure:
                            fail("API must return Success")
                        }
                        done()
                    }
                }
            }
        }
        
    }
}
