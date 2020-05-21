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
    
    // MARK: - Size height
    
    func testFunction_sizeHeight_returnTypeCheckView() {
        view = MockView().size(height: 10)
        XCTAssertTrue(view is MockView)
    }
    
    func testFunction_sizeHeight_constraintWithConstant() {
        let height: CGFloat = 10
        var constraint: NSLayoutConstraint!
        view.size(height: height, configuring: { constraint = $0 })
        XCTAssertEqual(height, constraint.constant)
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
    
    // MARK: - Size width
    
    func testFunction_sizeWidth_returnTypeCheckView() {
        view = MockView().size(width: 10)
        XCTAssertTrue(view is MockView)
    }
    
    func testFunction_sizeWidth_constraintWithConstant() {
        let width: CGFloat = 10
        var constraint: NSLayoutConstraint!
        view.size(width: width, configuring: { constraint = $0 })
        XCTAssertEqual(width, constraint.constant)
    }
    
    func testFunction_sizeWidth_constraintWithConstantView() {
        let width: CGFloat = 10
        view.size(width: width)
        layoutViews()
        XCTAssertEqual(width, view.frame.width)
    }
    
    func testFunction_sizeWidth_constraintPriority() {
        let width: CGFloat = 10
        let priority: Float = 999
        var constraint: NSLayoutConstraint?
        view.size(width: width, priority: priority, configuring: { constraint = $0 })
        constraintPriorityCheck(constraint: constraint, priority: priority)
    }
    
    func testFunction_sizeWidth_constraintPriorityView() {
        let width: CGFloat = 10
        let priority: Float = 999
        view.size(width: width, priority: priority)
        constraintPriorityCheck(constraint: view.constraints.first, priority: priority)
    }
    
    func testFunction_sizeWidth_constraintRelation() {
        let relation: NSLayoutConstraint.Relation = .greaterThanOrEqual
        var constraint: NSLayoutConstraint!
        view.size(width: 10, relation: relation, configuring: { constraint = $0 })
        XCTAssertEqual(relation, constraint.relation)
    }
    
    func testFunction_sizeWidth_constraintActivation() {
        var constraint: NSLayoutConstraint!
        view.size(width: 10, isActive: false, configuring: { constraint = $0 })
        XCTAssertFalse(constraint.isActive)
    }
    
    // MARK: - Size
    
    func testFunction_size_returnTypeCheckView() {
        view = MockView().size(10)
        XCTAssertTrue(view is MockView)
    }
    
    func testFunction_size_constraintWithConstant() {
        let size: CGFloat = 10
        var widthConstraint: NSLayoutConstraint!
        var heightConstraint: NSLayoutConstraint!
        view.size(size, configuring: { (widthConstraint, heightConstraint) = $0 })
        XCTAssertEqual(size, widthConstraint.constant)
        XCTAssertEqual(size, heightConstraint.constant)
    }
    
    func testFunction_size_constraintWithConstantView() {
        let size: CGFloat = 10
        view.size(size)
        layoutViews()
        XCTAssertEqual(size, view.frame.width)
        XCTAssertEqual(size, view.frame.height)
    }
    
    func testFunction_size_constraintPriority() {
        let size: CGFloat = 10
        let priority: Float = 999
        var widthConstraint: NSLayoutConstraint!
        var heightConstraint: NSLayoutConstraint!
        view.size(size, priority: priority, configuring: { (widthConstraint, heightConstraint) = $0 })
        constraintPriorityCheck(constraint: widthConstraint, priority: priority)
        constraintPriorityCheck(constraint: heightConstraint, priority: priority)
    }
    
    func testFunction_size_constraintRelation() {
        let relation: NSLayoutConstraint.Relation = .greaterThanOrEqual
        var widthConstraint: NSLayoutConstraint!
        var heightConstraint: NSLayoutConstraint!
        view.size(10, relation: relation, configuring: { (widthConstraint, heightConstraint) = $0 })
        XCTAssertEqual(relation, widthConstraint.relation)
        XCTAssertEqual(relation, heightConstraint.relation)
    }
    
    func testFunction_size_constraintActivation() {
        var widthConstraint: NSLayoutConstraint!
        var heightConstraint: NSLayoutConstraint!
        view.size(10, isActive: false, configuring: { (widthConstraint, heightConstraint) = $0 })
        XCTAssertFalse(widthConstraint.isActive)
        XCTAssertFalse(heightConstraint.isActive)
    }
    
    // MARK: - Support
    
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
