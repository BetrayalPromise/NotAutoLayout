//
//  DidStoreMiddleLeftCenterLayoutProperty.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct DidStoreMiddleLeftCenterLayoutProperty {
	
	let middleLeft: LayoutElement.Point
	
	let center: LayoutElement.Horizontal
	
}

// MARK: - Make Frame
extension DidStoreMiddleLeftCenterLayoutProperty {
	
	private func makeFrame(middleLeft: CGPoint, center: CGFloat, top: CGFloat) -> CGRect {
		
		let height = (middleLeft.y - top).doubled
		
		return self.makeFrame(middleLeft: middleLeft, center: center, height: height)
		
	}
	
	private func makeFrame(middleLeft: CGPoint, center: CGFloat, bottom: CGFloat) -> CGRect {
		
		let height = (bottom - middleLeft.y).doubled
		
		return self.makeFrame(middleLeft: middleLeft, center: center, height: height)
		
	}
	
	private func makeFrame(middleLeft: CGPoint, center: CGFloat, height: CGFloat) -> CGRect {
		
		let x = middleLeft.x
		let y = middleLeft.y - height.halved
		let width = (center - middleLeft.x).doubled
		let frame = CGRect(x: x, y: y, width: width, height: height)
		
		return frame
		
	}
	
}

// MARK: - Set A Line -
// MARK: Top
extension DidStoreMiddleLeftCenterLayoutProperty: LayoutPropertyCanStoreTopToEvaluateFrameType {
	
	public func evaluateFrame(top: LayoutElement.Vertical, property: ViewFrameProperty) -> CGRect {
		
		let middleLeft = self.middleLeft.evaluated(from: property)
		let center = self.center.evaluated(from: property)
		let top = top.evaluated(from: property)
		
		return self.makeFrame(middleLeft: middleLeft, center: center, top: top)
		
	}
	
}

// MARK: Bottom
extension DidStoreMiddleLeftCenterLayoutProperty: LayoutPropertyCanStoreBottomToEvaluateFrameType {
	
	public func evaluateFrame(bottom: LayoutElement.Vertical, property: ViewFrameProperty) -> CGRect {
		
		let middleLeft = self.middleLeft.evaluated(from: property)
		let center = self.center.evaluated(from: property)
		let bottom = bottom.evaluated(from: property)
		
		return self.makeFrame(middleLeft: middleLeft, center: center, bottom: bottom)
		
	}
	
}

// MARK: - Set A Length -
// MARK: Height
extension DidStoreMiddleLeftCenterLayoutProperty: LayoutPropertyCanStoreHeightToEvaluateFrameType {
	
	public func evaluateFrame(height: LayoutElement.Length, property: ViewFrameProperty) -> CGRect {
		
		let middleLeft = self.middleLeft.evaluated(from: property)
		let center = self.center.evaluated(from: property)
		let width = (center - middleLeft.x).doubled
		let height = height.evaluated(from: property, withTheOtherAxis: .width(width))
		
		return self.makeFrame(middleLeft: middleLeft, center: center, height: height)
		
	}
	
}
