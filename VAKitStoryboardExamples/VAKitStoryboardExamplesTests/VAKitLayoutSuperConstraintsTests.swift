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
        var constraint: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuper(.top, isSafe: true, configuring: { constraint = $0 })
        XCTAssertEqual(parentView.safeAreaLayoutGuide, (constraint.secondItem as? UILayoutGuide))
    }
    
    // MARK: - Constraints to center
    
    func test_toSuperCenter_returnViewType() {
        view = MockView()
        parentView.addAutolayoutSubview(view)
        let testView = view.toSuperCenter()
        XCTAssertTrue(testView is MockView)
    }
    
    func test_toSuperCenter_constraintConstantDefault() {
        var constraintCenterX: NSLayoutConstraint!
        var constraintCenterY: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperCenter(configuring: { (constraintCenterX, constraintCenterY) = $0 })
        XCTAssertTrue(constraintCenterX.constant.isZero)
        XCTAssertTrue(constraintCenterY.constant.isZero)
    }
    
    func test_toSuperCenter_constraintConstant() {
        let constant: CGFloat = 111
        var constraintCenterX: NSLayoutConstraint!
        var constraintCenterY: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperCenter(offset: CGPoint(x: constant, y: constant), configuring: { (constraintCenterX, constraintCenterY) = $0 })
        XCTAssertEqual(constant, constraintCenterX.constant)
        XCTAssertEqual(constant, constraintCenterY.constant)
    }
    
    func test_toSuperCenter_constraintPriorityDefault() {
        var constraintCenterX: NSLayoutConstraint!
        var constraintCenterY: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperCenter(configuring: { (constraintCenterX, constraintCenterY) = $0 })
        constraintPriorityCheck(constraint: constraintCenterX, priority: 1000)
        constraintPriorityCheck(constraint: constraintCenterY, priority: 1000)
    }
    
    func test_toSuperCenter_constraintPriority() {
        let priority: Float = 999
        var constraintCenterX: NSLayoutConstraint!
        var constraintCenterY: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperCenter(priority: priority, configuring: { (constraintCenterX, constraintCenterY) = $0 })
        constraintPriorityCheck(constraint: constraintCenterX, priority: priority)
        constraintPriorityCheck(constraint: constraintCenterY, priority: priority)
    }
    
    func test_toSuperCenter_constraintRelationDefault() {
        var constraintCenterX: NSLayoutConstraint!
        var constraintCenterY: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperCenter(configuring: { (constraintCenterX, constraintCenterY) = $0 })
        XCTAssertEqual(NSLayoutConstraint.Relation.equal, constraintCenterX.relation)
        XCTAssertEqual(NSLayoutConstraint.Relation.equal, constraintCenterY.relation)
    }
    
    func test_toSuperCenter_constraintRelation() {
        let relation: NSLayoutConstraint.Relation = .greaterThanOrEqual
        var constraintCenterX: NSLayoutConstraint!
        var constraintCenterY: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperCenter(relation: relation, configuring: { (constraintCenterX, constraintCenterY) = $0 })
        XCTAssertEqual(relation, constraintCenterX.relation)
        XCTAssertEqual(relation, constraintCenterY.relation)
    }
    
    func test_toSuperCenter_constraintActivation() {
        var constraintCenterX: NSLayoutConstraint!
        var constraintCenterY: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperCenter(isActive: false, configuring: { (constraintCenterX, constraintCenterY) = $0 })
        XCTAssertFalse(constraintCenterX.isActive)
        XCTAssertFalse(constraintCenterY.isActive)
    }
    
    func test_toSuperCenter_constraintMultiplierDefault() {
        var constraintCenterX: NSLayoutConstraint!
        var constraintCenterY: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperCenter(configuring: { (constraintCenterX, constraintCenterY) = $0 })
        XCTAssertEqual(1, constraintCenterX.multiplier)
        XCTAssertEqual(1, constraintCenterY.multiplier)
    }
    
    func test_toSuperCenter_constraintMultiplier() {
        let multiplier: CGFloat = 42
        var constraintCenterX: NSLayoutConstraint!
        var constraintCenterY: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperCenter(multiplier: multiplier, configuring: { (constraintCenterX, constraintCenterY) = $0 })
        XCTAssertEqual(multiplier, constraintCenterX.multiplier)
        XCTAssertEqual(multiplier, constraintCenterY.multiplier)
    }
    
    func test_toSuperCenter_constraintSafeAreaDefault() {
        var constraintCenterX: NSLayoutConstraint!
        var constraintCenterY: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperCenter(configuring: { (constraintCenterX, constraintCenterY) = $0 })
        XCTAssertEqual(parentView, (constraintCenterX.secondItem as? UIView))
        XCTAssertEqual(parentView, (constraintCenterY.secondItem as? UIView))
    }
    
    func test_toSuperCenter_constraintSafeArea() {
        var constraintCenterX: NSLayoutConstraint!
        var constraintCenterY: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperCenter(isSafe: true, configuring: { (constraintCenterX, constraintCenterY) = $0 })
        XCTAssertEqual(parentView.safeAreaLayoutGuide, (constraintCenterX.secondItem as? UILayoutGuide))
        XCTAssertEqual(parentView.safeAreaLayoutGuide, (constraintCenterY.secondItem as? UILayoutGuide))
    }
    
    // MARK: - Constraints to super edges
    
    func test_toSuperEdges_returnViewType() {
        view = MockView()
        parentView.addAutolayoutSubview(view)
        let testView = view.toSuperEdges()
        XCTAssertTrue(testView is MockView)
    }
    
    func test_toSuperEdges_constraintConstantDefault() {
        var constraintTop: NSLayoutConstraint!
        var constraintLeading: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperEdges(configuring: { (constraintTop, constraintLeading, constraintBottom, constraintTrailing) = $0 })
        XCTAssertTrue(constraintTop.constant.isZero)
        XCTAssertTrue(constraintLeading.constant.isZero)
        XCTAssertTrue(constraintBottom.constant.isZero)
        XCTAssertTrue(constraintTrailing.constant.isZero)
    }
    
    func test_toSuperEdges_constraintConstant() {
        let constant: CGFloat = 111
        var constraintTop: NSLayoutConstraint!
        var constraintLeading: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperEdges(insets: .init(top: constant, leading: constant, bottom: constant, trailing: constant), configuring: { (constraintTop, constraintLeading, constraintBottom, constraintTrailing) = $0 })
        XCTAssertEqual(constant, constraintTop.constant)
        XCTAssertEqual(constant, constraintLeading.constant)
        XCTAssertEqual(constant, -constraintBottom.constant)
        XCTAssertEqual(constant, -constraintTrailing.constant)
    }
    
    func test_toSuperEdges_constraintPriorityDefault() {
        var constraintTop: NSLayoutConstraint!
        var constraintLeading: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperEdges(configuring: { (constraintTop, constraintLeading, constraintBottom, constraintTrailing) = $0 })
        constraintPriorityCheck(constraint: constraintTop, priority: 1000)
        constraintPriorityCheck(constraint: constraintLeading, priority: 1000)
        constraintPriorityCheck(constraint: constraintBottom, priority: 1000)
        constraintPriorityCheck(constraint: constraintTrailing, priority: 1000)
    }
    
    func test_toSuperEdges_constraintPriority() {
        let priority: Float = 999
        var constraintTop: NSLayoutConstraint!
        var constraintLeading: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperEdges(priority: priority, configuring: { (constraintTop, constraintLeading, constraintBottom, constraintTrailing) = $0 })
        constraintPriorityCheck(constraint: constraintTop, priority: priority)
        constraintPriorityCheck(constraint: constraintLeading, priority: priority)
        constraintPriorityCheck(constraint: constraintBottom, priority: priority)
        constraintPriorityCheck(constraint: constraintTrailing, priority: priority)
    }
    
    func test_toSuperEdges_constraintRelationDefault() {
        var constraintTop: NSLayoutConstraint!
        var constraintLeading: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperEdges(configuring: { (constraintTop, constraintLeading, constraintBottom, constraintTrailing) = $0 })
        XCTAssertEqual(NSLayoutConstraint.Relation.equal, constraintTop.relation)
        XCTAssertEqual(NSLayoutConstraint.Relation.equal, constraintLeading.relation)
        XCTAssertEqual(NSLayoutConstraint.Relation.equal, constraintBottom.relation)
        XCTAssertEqual(NSLayoutConstraint.Relation.equal, constraintTrailing.relation)
    }
    
    func test_toSuperEdges_constraintRelation() {
        let relation: NSLayoutConstraint.Relation = .greaterThanOrEqual
        var constraintTop: NSLayoutConstraint!
        var constraintLeading: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperEdges(relation: relation, configuring: { (constraintTop, constraintLeading, constraintBottom, constraintTrailing) = $0 })
        XCTAssertEqual(relation, constraintTop.relation)
        XCTAssertEqual(relation, constraintLeading.relation)
        XCTAssertEqual(relation, constraintBottom.relation)
        XCTAssertEqual(relation, constraintTrailing.relation)
    }
    
    func test_toSuperEdges_constraintActivation() {
        var constraintTop: NSLayoutConstraint!
        var constraintLeading: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperEdges(isActive: false, configuring: { (constraintTop, constraintLeading, constraintBottom, constraintTrailing) = $0 })
        XCTAssertFalse(constraintTop.isActive)
        XCTAssertFalse(constraintLeading.isActive)
        XCTAssertFalse(constraintBottom.isActive)
        XCTAssertFalse(constraintTrailing.isActive)
    }
    
    func test_toSuperEdges_constraintMultiplierDefault() {
        var constraintTop: NSLayoutConstraint!
        var constraintLeading: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperEdges(configuring: { (constraintTop, constraintLeading, constraintBottom, constraintTrailing) = $0 })
        XCTAssertEqual(1, constraintTop.multiplier)
        XCTAssertEqual(1, constraintLeading.multiplier)
        XCTAssertEqual(1, constraintBottom.multiplier)
        XCTAssertEqual(1, constraintTrailing.multiplier)
    }
    
    func test_toSuperEdges_constraintMultiplier() {
        let multiplier: CGFloat = 42
        var constraintTop: NSLayoutConstraint!
        var constraintLeading: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperEdges(multiplier: multiplier, configuring: { (constraintTop, constraintLeading, constraintBottom, constraintTrailing) = $0 })
        XCTAssertEqual(multiplier, constraintTop.multiplier)
        XCTAssertEqual(multiplier, constraintLeading.multiplier)
        XCTAssertEqual(multiplier, constraintBottom.multiplier)
        XCTAssertEqual(multiplier, constraintTrailing.multiplier)
    }
    
    func test_toSuperEdges_constraintSafeAreaDefault() {
        var constraintTop: NSLayoutConstraint!
        var constraintLeading: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperEdges(configuring: { (constraintTop, constraintLeading, constraintBottom, constraintTrailing) = $0 })
        XCTAssertEqual(parentView, (constraintTop.secondItem as? UIView))
        XCTAssertEqual(parentView, (constraintLeading.secondItem as? UIView))
        XCTAssertEqual(parentView, (constraintBottom.secondItem as? UIView))
        XCTAssertEqual(parentView, (constraintTrailing.secondItem as? UIView))
    }
    
    func test_toSuperEdges_constraintSafeArea() {
        var constraintTop: NSLayoutConstraint!
        var constraintLeading: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperEdges(isSafe: true, configuring: { (constraintTop, constraintLeading, constraintBottom, constraintTrailing) = $0 })
        XCTAssertEqual(parentView.safeAreaLayoutGuide, (constraintTop.secondItem as? UILayoutGuide))
        XCTAssertEqual(parentView.safeAreaLayoutGuide, (constraintLeading.secondItem as? UILayoutGuide))
        XCTAssertEqual(parentView.safeAreaLayoutGuide, (constraintBottom.secondItem as? UILayoutGuide))
        XCTAssertEqual(parentView.safeAreaLayoutGuide, (constraintTrailing.secondItem as? UILayoutGuide))
    }
    
    func test_toSuperEdges_constraintType() {
        var constraintTop: NSLayoutConstraint!
        var constraintLeading: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperEdges(configuring: { (constraintTop, constraintLeading, constraintBottom, constraintTrailing) = $0 })
        XCTAssertEqual(NSLayoutConstraint.Attribute.top, constraintTop.firstAttribute)
        XCTAssertEqual(NSLayoutConstraint.Attribute.leading, constraintLeading.firstAttribute)
        XCTAssertEqual(NSLayoutConstraint.Attribute.bottom, constraintBottom.firstAttribute)
        XCTAssertEqual(NSLayoutConstraint.Attribute.trailing, constraintTrailing.firstAttribute)
    }
    
    // MARK: - Constraints to super view's axis
    
    func test_toSuperAxis_returnViewType() {
        view = MockView()
        parentView.addAutolayoutSubview(view)
        let testView = view.toSuperAxis(.horizontal)
        XCTAssertTrue(testView is MockView)
    }
    
    func test_toSuperAxis_horizontal_constraintConstantDefault() {
        var constraintLeading: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.horizontal, configuring: { (constraintLeading, constraintTrailing) = $0 })
        XCTAssertTrue(constraintLeading.constant.isZero)
        XCTAssertTrue(constraintTrailing.constant.isZero)
    }
    
    func test_toSuperAxis_vertical_constraintConstantDefault() {
        var constraintTop: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.vertical, configuring: { (constraintTop, constraintBottom) = $0 })
        XCTAssertTrue(constraintTop.constant.isZero)
        XCTAssertTrue(constraintBottom.constant.isZero)
    }
    
    func test_toSuperAxis_horizontal_constraintConstant() {
        let constant: CGFloat = 111
        var constraintLeading: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.horizontal, insets: (constant, constant), configuring: { (constraintLeading, constraintTrailing) = $0 })
        XCTAssertEqual(constant, constraintLeading.constant)
        XCTAssertEqual(-constant, constraintTrailing.constant)
    }
    
    func test_toSuperAxis_vertical_constraintConstant() {
        let constant: CGFloat = 111
        var constraintTop: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.vertical, insets: (constant, constant), configuring: { (constraintTop, constraintBottom) = $0 })
        XCTAssertEqual(constant, constraintTop.constant)
        XCTAssertEqual(-constant, constraintBottom.constant)
    }
    
    func test_toSuperAxis_horizontal_constraintPriorityDefault() {
        var constraintLeading: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.horizontal, configuring: { (constraintLeading, constraintTrailing) = $0 })
        constraintPriorityCheck(constraint: constraintLeading, priority: 1000)
        constraintPriorityCheck(constraint: constraintTrailing, priority: 1000)
    }
    
    func test_toSuperAxis_vertical_constraintPriorityDefault() {
        var constraintTop: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.vertical, configuring: { (constraintTop, constraintBottom) = $0 })
        constraintPriorityCheck(constraint: constraintTop, priority: 1000)
        constraintPriorityCheck(constraint: constraintBottom, priority: 1000)
    }
    
    func test_toSuperAxis_horizontal_constraintPriority() {
        let priority: Float = 999
        var constraintLeading: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.horizontal, priority: priority, configuring: { (constraintLeading, constraintTrailing) = $0 })
        constraintPriorityCheck(constraint: constraintLeading, priority: priority)
        constraintPriorityCheck(constraint: constraintTrailing, priority: priority)
    }
    
    func test_toSuperAxis_vartical_constraintPriority() {
        let priority: Float = 999
        var constraintTop: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.vertical, priority: priority, configuring: { (constraintTop, constraintBottom) = $0 })
        constraintPriorityCheck(constraint: constraintTop, priority: priority)
        constraintPriorityCheck(constraint: constraintBottom, priority: priority)
    }
    
    func test_toSuperAxis_horizontal_constraintRelationDefault() {
        var constraintLeading: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.horizontal, configuring: { (constraintLeading, constraintTrailing) = $0 })
        XCTAssertEqual(NSLayoutConstraint.Relation.equal, constraintLeading.relation)
        XCTAssertEqual(NSLayoutConstraint.Relation.equal, constraintTrailing.relation)
    }
    
    func test_toSuperAxis_vertical_constraintRelationDefault() {
        var constraintTop: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.vertical, configuring: { (constraintTop, constraintBottom) = $0 })
        XCTAssertEqual(NSLayoutConstraint.Relation.equal, constraintTop.relation)
        XCTAssertEqual(NSLayoutConstraint.Relation.equal, constraintBottom.relation)
    }
    
    func test_toSuperAxis_horizontal_constraintRelation() {
        let relation: NSLayoutConstraint.Relation = .greaterThanOrEqual
        var constraintLeading: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.horizontal, relation: relation, configuring: { (constraintLeading, constraintTrailing) = $0 })
        XCTAssertEqual(relation, constraintLeading.relation)
        XCTAssertEqual(relation, constraintTrailing.relation)
    }
    
    func test_toSuperAxis_vertical_constraintRelation() {
        let relation: NSLayoutConstraint.Relation = .greaterThanOrEqual
        var constraintTop: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.vertical, relation: relation, configuring: { (constraintTop, constraintBottom) = $0 })
        XCTAssertEqual(relation, constraintTop.relation)
        XCTAssertEqual(relation, constraintBottom.relation)
    }
    
    func test_toSuperAxis_horizontal_constraintActivation() {
        var constraintLeading: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.horizontal, isActive: false, configuring: { (constraintLeading, constraintTrailing) = $0 })
        XCTAssertFalse(constraintLeading.isActive)
        XCTAssertFalse(constraintTrailing.isActive)
    }
    
    func test_toSuperAxis_vertical_constraintActivation() {
        var constraintTop: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.vertical, isActive: false, configuring: { (constraintTop, constraintBottom) = $0 })
        XCTAssertFalse(constraintTop.isActive)
        XCTAssertFalse(constraintBottom.isActive)
    }
    
    func test_toSuperAxis_horizontal_constraintMultiplierDefault() {
        var constraintLeading: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.horizontal, configuring: { (constraintLeading, constraintTrailing) = $0 })
        XCTAssertEqual(1, constraintLeading.multiplier)
        XCTAssertEqual(1, constraintTrailing.multiplier)
    }
    
    func test_toSuperAxis_vertical_constraintMultiplierDefault() {
        var constraintTop: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.vertical, configuring: { (constraintTop, constraintBottom) = $0 })
        XCTAssertEqual(1, constraintTop.multiplier)
        XCTAssertEqual(1, constraintBottom.multiplier)
    }
    
    func test_toSuperAxis_horizontal_constraintMultiplier() {
        let multiplier: CGFloat = 42
        var constraintLeading: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.horizontal, multiplier: multiplier, configuring: { (constraintLeading, constraintTrailing) = $0 })
        XCTAssertEqual(multiplier, constraintLeading.multiplier)
        XCTAssertEqual(multiplier, constraintTrailing.multiplier)
    }
    
    func test_toSuperAxis_vertical_constraintMultiplier() {
        let multiplier: CGFloat = 42
        var constraintTop: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.vertical, multiplier: multiplier, configuring: { (constraintTop, constraintBottom) = $0 })
        XCTAssertEqual(multiplier, constraintTop.multiplier)
        XCTAssertEqual(multiplier, constraintBottom.multiplier)
    }
    
    func test_toSuperAxis_horizontal_constraintSafeAreaDefault() {
        var constraintLeading: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.horizontal, configuring: { (constraintLeading, constraintTrailing) = $0 })
        XCTAssertEqual(parentView, (constraintLeading.secondItem as? UIView))
        XCTAssertEqual(parentView, (constraintTrailing.secondItem as? UIView))
    }
    
    func test_toSuperAxis_vertical_constraintSafeAreaDefault() {
        var constraintTop: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.vertical, configuring: { (constraintTop, constraintBottom) = $0 })
        XCTAssertEqual(parentView, (constraintTop.secondItem as? UIView))
        XCTAssertEqual(parentView, (constraintBottom.secondItem as? UIView))
    }
    
    func test_toSuperAxis_horizontal_constraintSafeArea() {
        var constraintLeading: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.horizontal, isSafe: true, configuring: { (constraintLeading, constraintTrailing) = $0 })
        XCTAssertEqual(parentView.safeAreaLayoutGuide, (constraintLeading.secondItem as? UILayoutGuide))
        XCTAssertEqual(parentView.safeAreaLayoutGuide, (constraintTrailing.secondItem as? UILayoutGuide))
    }
    
    func test_toSuperAxis_vertical_constraintSafeArea() {
        var constraintTop: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.vertical, isSafe: true, configuring: { (constraintTop, constraintBottom) = $0 })
        XCTAssertEqual(parentView.safeAreaLayoutGuide, (constraintTop.secondItem as? UILayoutGuide))
        XCTAssertEqual(parentView.safeAreaLayoutGuide, (constraintBottom.secondItem as? UILayoutGuide))
    }
    
    // MARK: - Constraints to super view's axis wrapper
    
    func test_toSuperAxisSymmetric_returnViewType() {
        view = MockView()
        parentView.addAutolayoutSubview(view)
        let testView = view.toSuperAxis(.horizontal, symmetric: 1)
        XCTAssertTrue(testView is MockView)
    }
    
    func test_toSuperAxisSymmetric_horizontal_constraintConstant() {
        let constant: CGFloat = 111
        var constraintLeading: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.horizontal, symmetric: constant, configuring: { (constraintLeading, constraintTrailing) = $0 })
        XCTAssertEqual(constant, constraintLeading.constant)
        XCTAssertEqual(-constant, constraintTrailing.constant)
    }
    
    func test_toSuperAxisSymmetric_vertical_constraintConstant() {
        let constant: CGFloat = 111
        var constraintTop: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.vertical, symmetric: constant, configuring: { (constraintTop, constraintBottom) = $0 })
        XCTAssertEqual(constant, constraintTop.constant)
        XCTAssertEqual(-constant, constraintBottom.constant)
    }
    
    func test_toSuperAxisSymmetric_horizontal_constraintPriorityDefault() {
        var constraintLeading: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.horizontal, symmetric: 1, configuring: { (constraintLeading, constraintTrailing) = $0 })
        constraintPriorityCheck(constraint: constraintLeading, priority: 1000)
        constraintPriorityCheck(constraint: constraintTrailing, priority: 1000)
    }
    
    func test_toSuperAxisSymmetric_vertical_constraintPriorityDefault() {
        var constraintTop: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.vertical, symmetric: 1, configuring: { (constraintTop, constraintBottom) = $0 })
        constraintPriorityCheck(constraint: constraintTop, priority: 1000)
        constraintPriorityCheck(constraint: constraintBottom, priority: 1000)
    }
    
    func test_toSuperAxisSymmetric_horizontal_constraintPriority() {
        let priority: Float = 999
        var constraintLeading: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.horizontal, symmetric: 1, priority: priority, configuring: { (constraintLeading, constraintTrailing) = $0 })
        constraintPriorityCheck(constraint: constraintLeading, priority: priority)
        constraintPriorityCheck(constraint: constraintTrailing, priority: priority)
    }
    
    func test_toSuperAxisSymmetric_vartical_constraintPriority() {
        let priority: Float = 999
        var constraintTop: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.vertical, symmetric: 1, priority: priority, configuring: { (constraintTop, constraintBottom) = $0 })
        constraintPriorityCheck(constraint: constraintTop, priority: priority)
        constraintPriorityCheck(constraint: constraintBottom, priority: priority)
    }
    
    func test_toSuperAxisSymmetric_horizontal_constraintRelationDefault() {
        var constraintLeading: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.horizontal, symmetric: 1, configuring: { (constraintLeading, constraintTrailing) = $0 })
        XCTAssertEqual(NSLayoutConstraint.Relation.equal, constraintLeading.relation)
        XCTAssertEqual(NSLayoutConstraint.Relation.equal, constraintTrailing.relation)
    }
    
    func test_toSuperAxisSymmetric_vertical_constraintRelationDefault() {
        var constraintTop: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.vertical, symmetric: 1, configuring: { (constraintTop, constraintBottom) = $0 })
        XCTAssertEqual(NSLayoutConstraint.Relation.equal, constraintTop.relation)
        XCTAssertEqual(NSLayoutConstraint.Relation.equal, constraintBottom.relation)
    }
    
    func test_toSuperAxisSymmetric_horizontal_constraintRelation() {
        let relation: NSLayoutConstraint.Relation = .greaterThanOrEqual
        var constraintLeading: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.horizontal, symmetric: 1, relation: relation, configuring: { (constraintLeading, constraintTrailing) = $0 })
        XCTAssertEqual(relation, constraintLeading.relation)
        XCTAssertEqual(relation, constraintTrailing.relation)
    }
    
    func test_toSuperAxisSymmetric_vertical_constraintRelation() {
        let relation: NSLayoutConstraint.Relation = .greaterThanOrEqual
        var constraintTop: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.vertical, symmetric: 1, relation: relation, configuring: { (constraintTop, constraintBottom) = $0 })
        XCTAssertEqual(relation, constraintTop.relation)
        XCTAssertEqual(relation, constraintBottom.relation)
    }
    
    func test_toSuperAxisSymmetric_horizontal_constraintActivation() {
        var constraintLeading: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.horizontal, symmetric: 1, isActive: false, configuring: { (constraintLeading, constraintTrailing) = $0 })
        XCTAssertFalse(constraintLeading.isActive)
        XCTAssertFalse(constraintTrailing.isActive)
    }
    
    func test_toSuperAxisSymmetric_vertical_constraintActivation() {
        var constraintTop: NSLayoutConstraint!
        var constraintBottom: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.vertical, symmetric: 1, isActive: false, configuring: { (constraintTop, constraintBottom) = $0 })
        XCTAssertFalse(constraintTop.isActive)
        XCTAssertFalse(constraintBottom.isActive)
    }
    
    func test_toSuperAxisSymmetric_horizontal_constraintMultiplierDefault() {
        var constraintLeading: NSLayoutConstraint!
        var constraintTrailing: NSLayoutConstraint!
        parentView.addAutolayoutSubview(view)
        view.toSuperAxis(.horizontal, symmetric: 1, configuring: { (constraintLeading, constraintTrailing) = $0 })
        XCTAssertEqual(1, constraintLeading.multiplier)
        XCTAssertEqual(1, constraintTrailing.multiplier)
    }
    
    func test_toSuperAxisSymmetric_vertical_constraintMultiplierDefault() {
    }
    
    }
    
    // MARK: - Multiple constraints to super view
    
}
