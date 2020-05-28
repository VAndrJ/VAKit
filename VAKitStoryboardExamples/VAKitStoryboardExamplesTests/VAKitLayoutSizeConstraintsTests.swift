//
//  VAKitLayoutSizeConstraintsTests.swift
//  VAKitStoryboardExamplesTests
//
//  Created by VAndrJ on 07.05.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import XCTest

class VAKitLayoutSizeConstraintsTests: XCTestCase {
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
    
    func test_sizeHeight_returnViewType() {
        view = MockView().size(height: 10)
        XCTAssertTrue(view is MockView)
    }
    
    func test_sizeHeight_constraintConstant() {
        let height: CGFloat = 10
        var constraint: NSLayoutConstraint!
        view.size(height: height, configuring: { constraint = $0 })
        XCTAssertEqual(height, constraint.constant)
    }
    
    func test_sizeHeight_constraintConstantView() {
        let height: CGFloat = 10
        view.size(height: height)
        layoutViews()
        XCTAssertEqual(height, view.frame.height)
    }
    
    func test_sizeHeight_constraintPriorityDefault() {
        var constraint: NSLayoutConstraint!
        view.size(height: 10, configuring: { constraint = $0 })
        constraintPriorityCheck(constraint: constraint, priority: 1000)
    }
    
    func test_sizeHeight_constraintPriority() {
        let priority: Float = 999
        var constraint: NSLayoutConstraint?
        view.size(height: 42, priority: priority, configuring: { constraint = $0 })
        constraintPriorityCheck(constraint: constraint, priority: priority)
    }
    
    func test_sizeHeight_constraintPriorityView() {
        let priority: Float = 999
        view.size(height: 42, priority: priority)
        constraintPriorityCheck(constraint: view.constraints.first, priority: priority)
    }
    
    func test_sizeHeight_constraintRelationDefault() {
        var constraint: NSLayoutConstraint!
        view.size(height: 42, configuring: { constraint = $0 })
        XCTAssertEqual(NSLayoutConstraint.Relation.equal, constraint.relation)
    }
    
    func test_sizeHeight_constraintRelation() {
        let relation: NSLayoutConstraint.Relation = .greaterThanOrEqual
        var constraint: NSLayoutConstraint!
        view.size(height: 10, relation: relation, configuring: { constraint = $0 })
        XCTAssertEqual(relation, constraint.relation)
    }
    
    func test_sizeHeight_constraintActivation() {
        var constraint: NSLayoutConstraint!
        view.size(height: 10, isActive: false, configuring: { constraint = $0 })
        XCTAssertFalse(constraint.isActive)
    }
    
    func test_sizeHeight_constraintActivationView() {
        let height: CGFloat = 10
        view.size(height: height, isActive: false)
        layoutViews()
        XCTAssertNotEqual(height, view.frame.height)
    }
    
    // MARK: - Size width
    
    func test_sizeWidth_returnViewType() {
        view = MockView().size(width: 10)
        XCTAssertTrue(view is MockView)
    }
    
    func test_sizeWidth_constraintConstant() {
        let width: CGFloat = 10
        var constraint: NSLayoutConstraint!
        view.size(width: width, configuring: { constraint = $0 })
        XCTAssertEqual(width, constraint.constant)
    }
    
    func test_sizeWidth_constraintConstantView() {
        let width: CGFloat = 10
        view.size(width: width)
        layoutViews()
        XCTAssertEqual(width, view.frame.width)
    }
    
    func test_sizeWidth_constraintPriority() {
        let priority: Float = 999
        var constraint: NSLayoutConstraint?
        view.size(width: 42, priority: priority, configuring: { constraint = $0 })
        constraintPriorityCheck(constraint: constraint, priority: priority)
    }
    
    func test_sizeWidth_constraintPriorityView() {
        let width: CGFloat = 10
        let priority: Float = 999
        view.size(width: width, priority: priority)
        constraintPriorityCheck(constraint: view.constraints.first, priority: priority)
    }
    
    func test_sizeWidth_constraintRelation() {
        let relation: NSLayoutConstraint.Relation = .greaterThanOrEqual
        var constraint: NSLayoutConstraint!
        view.size(width: 10, relation: relation, configuring: { constraint = $0 })
        XCTAssertEqual(relation, constraint.relation)
    }
    
    func test_sizeWidth_constraintActivation() {
        var constraint: NSLayoutConstraint!
        view.size(width: 10, isActive: false, configuring: { constraint = $0 })
        XCTAssertFalse(constraint.isActive)
    }
    
    // MARK: - Size
    
    func test_size_returnViewType() {
        view = MockView().size(10)
        XCTAssertTrue(view is MockView)
    }
    
    func test_size_constraintConstant() {
        let size: CGFloat = 10
        var widthConstraint: NSLayoutConstraint!
        var heightConstraint: NSLayoutConstraint!
        view.size(size, configuring: { (widthConstraint, heightConstraint) = $0 })
        XCTAssertEqual(size, widthConstraint.constant)
        XCTAssertEqual(size, heightConstraint.constant)
    }
    
    func test_size_constraintConstantView() {
        let size: CGFloat = 10
        view.size(size)
        layoutViews()
        XCTAssertEqual(size, view.frame.width)
        XCTAssertEqual(size, view.frame.height)
    }
    
    func test_size_constraintPriority() {
        let size: CGFloat = 10
        let priority: Float = 999
        var widthConstraint: NSLayoutConstraint!
        var heightConstraint: NSLayoutConstraint!
        view.size(size, priority: priority, configuring: { (widthConstraint, heightConstraint) = $0 })
        constraintPriorityCheck(constraint: widthConstraint, priority: priority)
        constraintPriorityCheck(constraint: heightConstraint, priority: priority)
    }
    
    func test_size_constraintRelation() {
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
    
    private func layoutViews() {
        parentView.addAutolayoutSubview(view)
        parentView.setNeedsLayout()
        parentView.layoutIfNeeded()
    }
}
