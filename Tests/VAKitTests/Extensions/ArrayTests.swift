//
//  ArrayTests.swift
//  VAKit
//
//  Created by VAndrJ on 8/28/24.
//

import Testing
import Foundation
@testable import VAKit

@Suite("Array extensions")
struct ArrayTests {

    @Suite("Array builder")
    struct ArrayBuilderTests {

        @Test("Array builder empty initializer")
        func builderEmpty() {
            let sut: [Int] = Array {}
            
            #expect([] == sut)
        }

        @Test("Array builder initializer", arguments: [20])
        func builder(value: Int...) {
            let condition = true
            let optionalValue: Int? = 13
            let optionalNilValue: Int? = nil
            let optionalElementsArray: [Int?] = [14, nil, 15]
            let optionalArray: [Int]? = [16, 17]
            let optionalNilArray: [Int]? = nil
            let expected = [1, 2, 3, 4, 5, 6, 7, 10, 11, 13, 14, 15, 16, 17, 20]
            let sut: [Int] = Array {
                1
                [2, 3]
                for i in 4...6 {
                    i
                }
                if condition {
                    7
                } else {
                    8
                }
                if !condition {
                    9
                } else {
                    10
                }
                switch condition {
                case true: 11
                case false: 12
                }
                optionalValue
                optionalNilValue
                optionalElementsArray
                if let optionalArray {
                    optionalArray
                }
                if let optionalNilArray {
                    optionalNilArray
                }
                value
            }

            #expect(expected == sut)
        }
    }
}
