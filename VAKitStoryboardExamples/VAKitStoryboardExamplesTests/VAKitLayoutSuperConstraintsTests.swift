//
//  VAKitLayoutSuperConstraintsTests.swift
//  VAKitStoryboardExamplesTests
//
//  Created by Vladimir Andrienko on 23.05.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import XCTest

class VAKitLayoutSuperConstraintsTests: XCTestCase {
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
    
    // MARK: - Single constraint to super view
    
    func test_toSuper_returnViewType() {
        view = MockView()
        parentView.addAutolayoutSubview(view)
        let testView = view.toSuper(.top)
        XCTAssertTrue(testView is MockView)
    }
    
    func test_toSuper_constraintConstantDefault() {
        var constraint: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuper(.top, configuring: { constraint = $0 })
        XCTAssertTrue(constraint.constant.isZero)
    }
    
    func test_toSuper_constraintConstant() {
        let constant: CGFloat = 10
        var constraint: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuper(.top, constant: constant, configuring: { constraint = $0 })
        XCTAssertEqual(constant, constraint.constant)
    }
    
    func test_toSuper_constraintPriorityDefault() {
        var constraint: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuper(.top, configuring: { constraint = $0 })
        constraintPriorityCheck(constraint: constraint, priority: 1000)
    }
    
    func test_toSuper_constraintPriority() {
        var constraint: NSLayoutConstraint!
        let priority: Float = 999
        parentView.addAutolayoutSubview(view)
        view.toSuper(.top, priority: priority, configuring: { constraint = $0 })
        constraintPriorityCheck(constraint: constraint, priority: priority)
    }
    
    func test_toSuper_constraintRelationDefault() {
        var constraint: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuper(.top, configuring: { constraint = $0 })
        XCTAssertEqual(NSLayoutConstraint.Relation.equal, constraint.relation)
    }
    
    func test_toSuper_constraintRelation() {
        let relation: NSLayoutConstraint.Relation = .greaterThanOrEqual
        var constraint: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuper(.top, relation: relation, configuring: { constraint = $0 })
        XCTAssertEqual(relation, constraint.relation)
    }
    
    func test_toSuper_constraintActivation() {
        var constraint: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuper(.top, isActive: false, configuring: { constraint = $0 })
        XCTAssertFalse(constraint.isActive)
    }
    
    func test_toSuper_constraintAttribute() {
        let attribute: NSLayoutConstraint.Attribute = .top
        var constraint: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuper(attribute, configuring: { constraint = $0 })
        XCTAssertEqual(attribute, constraint.firstAttribute)
        XCTAssertEqual(attribute, constraint.secondAttribute)
    }
    
    func test_toSuper_constraintMultiplierDefault() {
        var constraint: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuper(.top, configuring: { constraint = $0 })
        XCTAssertEqual(1, constraint.multiplier)
    }
    
    func test_toSuper_constraintMultiplier() {
        let muptiplier: CGFloat = 42
        var constraint: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuper(.top, multiplier: muptiplier, configuring: { constraint = $0 })
        XCTAssertEqual(muptiplier, constraint.multiplier)
    }
    
    func test_toSuper_constraintSafeAreaDefault() {
        var constraint: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuper(.top, configuring: { constraint = $0 })
        XCTAssertEqual(parentView, (constraint.secondItem as? UIView))
    }
    
    func test_toSuper_constraintSafeArea() {
    }
}
