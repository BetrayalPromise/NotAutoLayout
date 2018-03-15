//
//  LayoutPropertyCanStoreTopRightType.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/11/12.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public protocol LayoutPropertyCanStoreTopRightType: LayoutMakerPropertyType {
	
	associatedtype WillSetTopRightProperty: LayoutMakerPropertyType
	
	func storeTopRight(_ topRight: LayoutElement.Point, to maker: LayoutMaker<Self>) -> LayoutMaker<WillSetTopRightProperty>
	
}

extension LayoutMaker where Property: LayoutPropertyCanStoreTopRightType {
	
	public func setTopRight(to topRight: CGPoint) -> LayoutMaker<Property.WillSetTopRightProperty> {
		
		let topRight = LayoutElement.Point.constant(topRight)
		let maker = self.didSetProperty.storeTopRight(topRight, to: self)
		
		return maker
		
	}
	
	public func setTopRight(by topRight: @escaping (_ property: ViewLayoutGuides) -> CGPoint) -> LayoutMaker<Property.WillSetTopRightProperty> {
		
		let topRight = LayoutElement.Point.byParent(topRight)
		let maker = self.didSetProperty.storeTopRight(topRight, to: self)
		
		return maker
		
	}
	
	public func pinTopRight(to referenceView: UIView?, with topRight: @escaping (ViewPinProperty<ViewPinPropertyType.Point>) -> CGPoint) -> LayoutMaker<Property.WillSetTopRightProperty> {
		
		return self.pinTopRight(by: { [weak referenceView] in referenceView }, with: topRight)
		
	}
	
	public func pinTopRight(by referenceView: @escaping () -> UIView?, with topRight: @escaping (ViewPinProperty<ViewPinPropertyType.Point>) -> CGPoint) -> LayoutMaker<Property.WillSetTopRightProperty> {
		
		let topRight = LayoutElement.Point.byReference(referenceGetter: referenceView, topRight)
		let maker = self.didSetProperty.storeTopRight(topRight, to: self)
		
		return maker
		
	}
	
}

public protocol LayoutPropertyCanStoreTopRightToEvaluateFrameType: LayoutPropertyCanStoreTopRightType {
	
	func evaluateFrame(topRight: LayoutElement.Point, parameters: IndividualFrameCalculationParameters) -> CGRect
	
}

extension LayoutPropertyCanStoreTopRightToEvaluateFrameType {
	
	public func storeTopRight(_ topRight: LayoutElement.Point, to maker: LayoutMaker<Self>) -> LayoutMaker<IndividualLayout> {
		
		let layout = IndividualLayout(frame: { (parameters) -> CGRect in
			return self.evaluateFrame(topRight: topRight, parameters: parameters)
		})
		let maker = LayoutMaker(parentView: maker.parentView, didSetProperty: layout)
		
		return maker
		
	}
	
}
