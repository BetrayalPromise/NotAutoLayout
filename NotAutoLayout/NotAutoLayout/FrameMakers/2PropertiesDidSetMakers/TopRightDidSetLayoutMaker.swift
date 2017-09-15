//
//  TopRightDidSetLayoutMaker.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct TopRightDidSetLayoutMaker {
	
	public unowned let parentView: UIView
	
	let topRight: CGRect.Point
	
}

extension TopRightDidSetLayoutMaker {
	
	private func makeFrame(topRight: CGPoint, bottomLeft: CGPoint) -> CGRect {
		
		let width = topRight.x - bottomLeft.x
		let height = bottomLeft.y - topRight.y
		let x = bottomLeft.x
		let y = topRight.y
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
	private func makeFrame(topRight: CGPoint, size: CGSize) -> CGRect {
		
		let x = topRight.x - size.width
		let y = topRight.y
		let width = size.width
		let height = size.height
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
}

extension TopRightDidSetLayoutMaker {
	
	public func pinLeft(to referenceView: UIView?, s reference: CGRect.HorizontalBasePoint, offsetBy offset: CGFloat = 0, ignoresTransform: Bool = false) -> TopRightLeftDidSetLayoutMaker {
		
    	let referenceView = { [weak referenceView] in referenceView }
    	
    	return self.pinLeft(by: referenceView, s: reference, offsetBy: offset, ignoresTransform: ignoresTransform)
    	
	}
	
	@available(iOS 11.0, *)
	public func pinLeft(to referenceView: UIView?, s reference: CGRect.HorizontalBasePoint, offsetBy offset: CGFloat = 0, ignoresTransform: Bool = false, safeAreaOnly shouldOnlyIncludeSafeArea: Bool) -> TopRightLeftDidSetLayoutMaker {
		
		let referenceView = { [weak referenceView] in referenceView }
		
		return self.pinLeft(by: referenceView, s: reference, offsetBy: offset, ignoresTransform: ignoresTransform, safeAreaOnly: shouldOnlyIncludeSafeArea)
		
	}
	
	public func pinLeft(by referenceView: @escaping () -> UIView?, s reference: CGRect.HorizontalBasePoint, offsetBy offset: CGFloat = 0, ignoresTransform: Bool = false) -> TopRightLeftDidSetLayoutMaker {
		
		let left = self.parentView.horizontalReference(reference, of: referenceView, offsetBy: offset, ignoresTransform: ignoresTransform, safeAreaOnly: false)
		
		let maker = TopRightLeftDidSetLayoutMaker(parentView: self.parentView,
		                                          topRight: self.topRight,
		                                          left: left)
		
		return maker
		
	}
	
	@available(iOS 11.0, *)
	public func pinLeft(by referenceView: @escaping () -> UIView?, s reference: CGRect.HorizontalBasePoint, offsetBy offset: CGFloat = 0, ignoresTransform: Bool = false, safeAreaOnly shouldOnlyIncludeSafeArea: Bool) -> TopRightLeftDidSetLayoutMaker {
		
		let left = self.parentView.horizontalReference(reference, of: referenceView, offsetBy: offset, ignoresTransform: ignoresTransform, safeAreaOnly: shouldOnlyIncludeSafeArea)
		
		let maker = TopRightLeftDidSetLayoutMaker(parentView: self.parentView,
		                                          topRight: self.topRight,
		                                          left: left)
		
		return maker
		
	}
	
}

extension TopRightDidSetLayoutMaker {
	
	public func setBottomLeft(to bottomLeft: CGPoint) -> Layout.Individual {
		
		if let topRight = self.topRight.constantValue {
			let frame = self.makeFrame(topRight: topRight, bottomLeft: bottomLeft)
			let layout = Layout.Individual.makeAbsolute(frame: frame)
			
			return layout
			
		} else {
			let layout = Layout.Individual.makeCustom { (boundSize) -> CGRect in
				let topRight = self.topRight.closureValue(boundSize)
				let frame = self.makeFrame(topRight: topRight, bottomLeft: bottomLeft)
				return frame
			}
			
			return layout
			
		}
		
	}
	
	public func setBottomLeft(by bottomLeft: @escaping (_ parameter: LayoutControlParameter) -> CGPoint) -> Layout.Individual {
		
		let layout = Layout.Individual.makeCustom { (parameter) -> CGRect in
			let topRight = self.topRight.closureValue(parameter)
			let bottomLeft = bottomLeft(parameter)
			let frame = self.makeFrame(topRight: topRight, bottomLeft: bottomLeft)
			
			return frame
			
		}
		
		return layout
		
	}
	
	public func pinBottomLeft(to referenceView: UIView?, s reference: CGRect.PlaneBasePoint, offsetBy offset: CGVector = .zero, ignoresTransform: Bool = false) -> Layout.Individual {
		
		let referenceView = { [weak referenceView] in referenceView }
		
		return self.pinBottomLeft(by: referenceView, s: reference, offsetBy: offset, ignoresTransform: ignoresTransform)
		
	}
	
	@available(iOS 11.0, *)
	public func pinBottomLeft(to referenceView: UIView?, s reference: CGRect.PlaneBasePoint, offsetBy offset: CGVector = .zero, ignoresTransform: Bool = false, safeAreaOnly shouldOnlyIncludeSafeArea: Bool) -> Layout.Individual {
		
		let referenceView = { [weak referenceView] in referenceView }
		
		return self.pinBottomLeft(by: referenceView, s: reference, offsetBy: offset, ignoresTransform: ignoresTransform, safeAreaOnly: shouldOnlyIncludeSafeArea)
		
	}
	
	public func pinBottomLeft(by referenceView: @escaping () -> UIView?, s reference: CGRect.PlaneBasePoint, offsetBy offset: CGVector = .zero, ignoresTransform: Bool = false) -> Layout.Individual {
		
		let layout = Layout.Individual.makeCustom { [unowned parentView] (boundSize) -> CGRect in
			let topRight = self.topRight.closureValue(boundSize)
			let bottomLeft = parentView.pointReference(reference, of: referenceView, offsetBy: offset, ignoresTransform: ignoresTransform, safeAreaOnly: false).closureValue(boundSize)
			let frame = self.makeFrame(topRight: topRight, bottomLeft: bottomLeft)
			
			return frame
			
		}
		
		return layout
		
	}
	
	@available(iOS 11.0, *)
	public func pinBottomLeft(by referenceView: @escaping () -> UIView?, s reference: CGRect.PlaneBasePoint, offsetBy offset: CGVector = .zero, ignoresTransform: Bool = false, safeAreaOnly shouldOnlyIncludeSafeArea: Bool) -> Layout.Individual {
		
		let layout = Layout.Individual.makeCustom { [unowned parentView] (boundSize) -> CGRect in
			let topRight = self.topRight.closureValue(boundSize)
			let bottomLeft = parentView.pointReference(reference, of: referenceView, offsetBy: offset, ignoresTransform: ignoresTransform, safeAreaOnly: shouldOnlyIncludeSafeArea).closureValue(boundSize)
			let frame = self.makeFrame(topRight: topRight, bottomLeft: bottomLeft)
			
			return frame
			
		}
		
		return layout
		
	}
	
}

extension TopRightDidSetLayoutMaker {
	
	public func setSize(to size: CGSize) -> Layout.Individual {
		
		if let topRight = self.topRight.constantValue {
			let frame = self.makeFrame(topRight: topRight, size: size)
			let layout = Layout.Individual.makeAbsolute(frame: frame)
			
			return layout
			
		} else {
			let layout = Layout.Individual.makeCustom { (boundSize) -> CGRect in
				let topRight = self.topRight.closureValue(boundSize)
				let frame = self.makeFrame(topRight: topRight, size: size)
				
				return frame
				
			}
			
			return layout
			
		}
		
	}
	
	public func setSize(by size: @escaping (_ parameter: LayoutControlParameter) -> CGSize) -> Layout.Individual {
		
		let layout = Layout.Individual.makeCustom { (parameter) -> CGRect in
			
			let topRight = self.topRight.closureValue(parameter)
			let size = size(parameter)
			let frame = self.makeFrame(topRight: topRight, size: size)
			
			return frame
			
		}
		
		return layout
		
	}
	
	public func fitSize(by fittingSize: CGSize = .zero) -> Layout.Individual {
		
		let layout = Layout.Individual.makeCustom { (fitting, boundSize) -> CGRect in
			
			let topRight = self.topRight.closureValue(boundSize)
			let size = fitting(fittingSize)
			let frame = self.makeFrame(topRight: topRight, size: size)
			
			return frame
			
		}
		
		return layout
		
	}
	
}