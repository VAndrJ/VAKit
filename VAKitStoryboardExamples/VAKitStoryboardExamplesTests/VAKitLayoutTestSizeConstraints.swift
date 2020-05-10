//
//  VAKitLayoutTestSizeConstraints.swift
//  VAKitStoryboardExamplesTests
//
//  Created by VAndrJ on 07.05.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import XCTest

class VAKitLayoutTestSizeConstraints: XCTestCase {
    var view: UIView!
    var parentView: UIView!
    
    override func setUp() {
        view = UIView()
        parentView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
    }
    
    override func tearDown() {
        view = nil
        parentView = nil
    }
    
    func testFunction_sizeHeight_returnTypeCheck() {
        view = MockView().size(height: 10)
        XCTAssertTrue(view is MockView)
    }
    
    func testFunction_sizeHeight_constraintWithConstant() {
    }
    
    func testFunction_sizeHeight_constraintWithConstantSetView() {
        let height: CGFloat = 10
        view.size(height: height)
        layoutViews()
        XCTAssertEqual(height, view.frame.height)
    }
    
    func testFunction_sizeHeight_constraintPriority() {
        let height: CGFloat = 10
        let priority: Float = 999
        var constraint: NSLayoutConstraint?
        view.size(height: height, priority: priority, configuring: { constraint = $0 })
        constraintPriorityCheck(constraint: constraint, priority: priority)
    }
    
    func testFunction_sizeHeight_constraintPriorityView() {
        let height: CGFloat = 10
        let priority: Float = 999
        view.size(height: height, priority: priority)
        constraintPriorityCheck(constraint: view.constraints.first, priority: priority)
    }
    
    func testFunction_sizeHeight_constraintPriorities() {
        let primaryHeight: CGFloat = 100
        let secondaryHeight: CGFloat = 10
        let secondaryPriority: Float = 999
        var primaryConstraint: NSLayoutConstraint?
        var secondaryConstraint: NSLayoutConstraint?
        view.size(height: secondaryHeight, priority: secondaryPriority, configuring: { secondaryConstraint = $0 })
        view.size(height: primaryHeight, configuring: { primaryConstraint = $0 })
        layoutViews()
        constraintPriorityCheck(constraint: secondaryConstraint, priority: secondaryPriority)
        constraintPriorityCheck(constraint: primaryConstraint, priority: 1000)
        XCTAssertEqual(primaryHeight, primaryConstraint?.constant)
    }
    
    func testFunction_sizeHeight_constraintRelation() {
        let relation: NSLayoutConstraint.Relation = .greaterThanOrEqual
        var constraint: NSLayoutConstraint!
        view.size(height: 10, relation: relation, configuring: { constraint = $0 })
        XCTAssertEqual(relation, constraint.relation)
    }
    
    func testFunction_sizeHeight_constraintRelationView() {
        let height: CGFloat = 10
        let relation: NSLayoutConstraint.Relation = .greaterThanOrEqual
        view.size(height: height, relation: relation)
        layoutViews()
        XCTAssertEqual(height, view.frame.height)
        XCTAssertEqual(relation, view.constraints.first?.relation)
    }
    
    func testFunction_sizeHeight_constraintActivation() {
        var constraint: NSLayoutConstraint!
        view.size(height: 10, isActive: false, configuring: { constraint = $0 })
        XCTAssertFalse(constraint.isActive)
    }
    
    func testFunction_sizeHeight_constraintActivationView() {
        let height: CGFloat = 10
        view.size(height: height, isActive: false)
        layoutViews()
        XCTAssertNotEqual(height, view.frame.height)
    }
    
    private func constraintPriorityCheck(constraint: NSLayoutConstraint?, priority: Float, file: StaticString = #file, line: UInt = #line) {
        XCTAssertNotNil(constraint, file: file, line: line)
        XCTAssertEqual(priority, constraint!.priority.rawValue, file: file, line: line)
    }
    
    private func layoutViews() {
        parentView.addAutolayoutSubview(view)
        parentView.setNeedsLayout()
        parentView.layoutIfNeeded()
    }
}

fileprivate class MockView: UIView {
    
}
