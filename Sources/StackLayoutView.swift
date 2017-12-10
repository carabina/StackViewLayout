//  Copyright (c) 2017 Luc Dion
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
 
#if os(iOS) || os(tvOS)
import UIKit
 
public class StackLayoutView: UIView {
    internal var stackItems: [StackItemImpl] = []
    internal var direction = SDirection.column
    internal var justifyContent = SJustifyContent.start
    internal var alignItems = SAlignItems.stretch
    
    /**
     This method is used to structure your code so that it matches the stack view structure. The method has a closure parameter with a
     single parameter called `flex`. This parameter is in fact, the view's flex interface, it can be used to adds other flex items
     and containers.
     
     - Parameter closure:
     - Returns: Flex interface
     */
    public func define(_ closure: (_ stackView: StackLayoutView) -> Void) {
        closure(self)
    }
    
    public func addItem(_ view: UIView) {
        guard let stackItemImpl = view.item as? StackItemImpl else { return }
        stackItemImpl.parent = self
        stackItems.append(stackItemImpl)
        
        super.addSubview(view)
     }
    
    public func insertItem(_ view: UIView, at index: Int) {
        guard let stackItemImpl = view.item as? StackItemImpl else { return }
        stackItemImpl.parent = self
        stackItems.insert(stackItemImpl, at: index)
        
        self.insertSubview(view, at: index)
    }
    
    public func insertItem(_ view: UIView, before refView: UIView) {
        guard let stackItemImpl = view.item as? StackItemImpl else { return }
        guard let itemIndex = stackItems.index(of: stackItemImpl) else { print("The reference view is not part of this StackLayoutView!"); return }
        stackItemImpl.parent = self
        stackItems.insert(stackItemImpl, at: itemIndex)
        
        super.insertSubview(view, aboveSubview: refView)
    }
    
    public func insertItem(_ view: UIView, after refView: UIView) {
        guard let stackItemImpl = view.item as? StackItemImpl else { return }
        guard let itemIndex = stackItems.index(of: stackItemImpl) else { print("The reference view is not part of this StackLayoutView!"); return }
        stackItemImpl.parent = self
        stackItems.insert(stackItemImpl, at: itemIndex + 1)

        super.insertSubview(view, belowSubview: refView)
    }
    
    public func removeItem(_ view: UIView) {
        removStackItem(view)
        view.removeFromSuperview()
    }
    
    public override func willRemoveSubview(_ subview: UIView) {
        super.willRemoveSubview(subview)
        removStackItem(subview)
    }
    
    private func removStackItem(_ view: UIView) {
        guard let stackItemImpl = view.item as? StackItemImpl else { return }
        guard let itemIndex = stackItems.index(of: stackItemImpl) else { print("The view is not part of this StackLayoutView!"); return }
        stackItemImpl.parent = nil
        stackItems.remove(at: itemIndex)
    }
    
    /**
     The `direction` property establishes the main-axis, thus defining the direction flex items are placed in the flex container.
     
     The `direction` property specifies how flex items are laid out in the flex container, by setting the direction of the flex
     container’s main axis. They can be laid out in two main directions,  like columns vertically or like rows horizontally.
     
     Note that row and row-reverse are affected by the layout direction (see `layoutDirection` property) of the flex container.
     If its text direction is LTR (left to right), row represents the horizontal axis oriented from left to right, and row-reverse
     from right to left; if the direction is rtl, it's the opposite.
     
     - Parameter value: Default value is .column
     */
    @discardableResult
    public func direction(_ value: SDirection) -> StackLayoutView {
        direction = value
        setNeedsLayout()
        return self
    }
    
    public func getDirection() -> SDirection {
        return direction
    }
    
    @discardableResult
    public func justifyContent(_ value: SJustifyContent) -> StackLayoutView {
        justifyContent = value
        setNeedsLayout()
        return self
    }
    
    /**
     The `justifyContent` property defines the alignment along the main-axis of the current line of the flex container.
     It helps distribute extra free space leftover when either all the flex items on a line have reached their maximum
     size. For example, if children are flowing vertically, `justifyContent` controls how they align vertically.
     
     - Parameter value: Default value is .start
     */
    public func getJustifyContent() -> SJustifyContent {
        return justifyContent
    }
    
    /**
     The `alignItems` property defines how flex items are laid out along the cross axis on the current line.
     Similar to `justifyContent` but for the cross-axis (perpendicular to the main-axis). For example, if
     children are flowing vertically, `alignItems` controls how they align horizontally.
     
     - Parameter value: Default value is .stretch
     */
    @discardableResult
    public func alignItems(_ value: SAlignItems) -> StackLayoutView {
        alignItems = value
        setNeedsLayout()
        return self
    }
    
    public func getAlignItems() -> SAlignItems {
        return alignItems
    }
    
    //
    // Layout view
    //

    /**
     The method layout the flex container's children
     
     - Parameter mode: specify the layout mod (LayoutMode).
     */
    public func layout(mode: SLayoutMode = .fitContainer) {
        let container = Container(direction: direction)
        
        switch mode {
        case .fitContainer:
            container.width = frame.width
            container.height = frame.height
            layoutItems(container: container)
        case .adjustWidth:
            container.width = frame.width
            container.height = nil
            layoutItems(container: container)
        case .adjustHeight:
            container.width = nil
            container.height = frame.height
            layoutItems(container: container)
        }
    }
    
    //
    // Show/hide items
    //
    public func hideItem(_ view: UIView, animate: Bool) {
        updateItemVisibility(view: view, isVisible: false, animate: animate)
    }
    
    public func showItem(_ view: UIView, animate: Bool) {
        updateItemVisibility(view: view, isVisible: true, animate: animate)
    }
    
    internal func updateItemVisibility(view: UIView, isVisible: Bool, animate: Bool) {
        guard let stackItemImpl = view.item as? StackItemImpl else { return }
        guard let itemIndex = stackItems.index(of: stackItemImpl) else { print("The view is not part of this StackLayoutView!"); return }
        guard view.isHidden == isVisible else { return }
        let duration = 0.3
        
        if animate {
            if isVisible {
                view.frame.size = direction == .column ? CGSize(width: view.frame.width, height: 0) : CGSize(width: 0, height: view.frame.height)
                view.isHidden = false
                
                UIView.animate(withDuration: duration, delay: 0, options: [.beginFromCurrentState], animations: {
                    self.forceLayoutNow()
                })
            } else {
                let itemSnapshot = view.snapshotView(afterScreenUpdates: true)!
                itemSnapshot.frame = view.frame
                insertSubview(itemSnapshot, at: itemIndex)
                view.isHidden = true
                
                UIView.animate(withDuration: duration, delay: 0, options: [.beginFromCurrentState], animations: {
                    itemSnapshot.frame.size = self.direction == .column ? CGSize(width: itemSnapshot.frame.width, height: 0) : CGSize(width: 0, height: itemSnapshot.frame.height)
                    self.forceLayoutNow()
                }, completion: { (completed) in
                    itemSnapshot.removeFromSuperview()
                })
            }
        } else {
            view.isHidden = !isVisible
            forceLayoutNow()
        }
    }
    
    internal func forceLayoutNow() {
        setNeedsLayout()
        layoutIfNeeded()
    }
}
    
#endif
