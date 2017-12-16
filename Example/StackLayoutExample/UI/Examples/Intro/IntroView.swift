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

import UIKit
import PinLayout
import StackLayoutView

class IntroView: BaseView {

    fileprivate let logo = UIImageView(image: UIImage(named: "PinLayout-logo"))
    fileprivate let textLabel = UILabel()
    fileprivate let separatorView = UIView()
    
    fileprivate let buttonsStackView = StackLayoutView()
    fileprivate let toggleDirectionButton = UIButton(type: .custom)
    fileprivate let toggleJustifyButton = UIButton(type: .custom)
    fileprivate let toggleVisibilityButton = UIButton(type: .custom)
    fileprivate let removeButton = UIButton(type: .custom)
    fileprivate let insertButton = UIButton(type: .custom)
    
    var stackLayoutView: StackLayoutView!
    //        let logo = UIImageView(image: UIImage(named: "PinLayout-logo"))
    //        let textLabel = UILabel()
    //        let separatorView = UIView()
    
    var label1: UILabel!
    var label2: UILabel!
    var label3: UILabel!
    let view1 = BasicView(text: "View 1", color: UIColor.red)
    
    override init() {
        super.init()
    
        stackLayoutView = StackLayoutView()
        stackLayoutView.layer.borderColor = UIColor.black.cgColor
        stackLayoutView.layer.borderWidth = 1
        addSubview(stackLayoutView)
        
        toggleDirectionButton.backgroundColor = .gray
        toggleDirectionButton.setTitle("Dir", for: .normal)
        toggleDirectionButton.addTarget(self, action: #selector(didTapToggleDirection), for: .touchUpInside)
        buttonsStackView.addItem(toggleDirectionButton)
        
        toggleJustifyButton.backgroundColor = .gray
        toggleJustifyButton.setTitle("Just", for: .normal)
        toggleJustifyButton.addTarget(self, action: #selector(didTapToggleJustify), for: .touchUpInside)
        buttonsStackView.addItem(toggleJustifyButton)
        
        toggleVisibilityButton.backgroundColor = .gray
        toggleVisibilityButton.setTitle("Visible", for: .normal)
        toggleVisibilityButton.addTarget(self, action: #selector(didTapToggleVisibility), for: .touchUpInside)
        buttonsStackView.addItem(toggleVisibilityButton)
        
        removeButton.backgroundColor = .gray
        removeButton.setTitle("Remove", for: .normal)
        removeButton.addTarget(self, action: #selector(didTapRemove), for: .touchUpInside)
        buttonsStackView.addItem(removeButton)
        
        insertButton.backgroundColor = .gray
        insertButton.setTitle("Insert", for: .normal)
        insertButton.addTarget(self, action: #selector(didTapInsert), for: .touchUpInside)
        buttonsStackView.addItem(insertButton)
        
        buttonsStackView.direction(.row)
        buttonsStackView.justifyContent(.spaceBetween)
//        addSubview(buttonsStackView)
        
        view1.sizeThatFitsExpectedArea = 400 * 20
        
//        testAlignItems()
//        testRowDirection()
        testMargins()

//        logo.contentMode = .scaleAspectFit
//
//        textLabel.text = "Swift manual views layouting without auto layout, no magic, pure code, full control. Concise syntax, readable & chainable.\n\nSwift manual views layouting without auto layout, no magic, pure code, full control. Concise syntax, readable & chainable."
//        textLabel.font = .systemFont(ofSize: 14)
//        textLabel.numberOfLines = 0
//        textLabel.lineBreakMode = .byWordWrapping
//
//        separatorView.backgroundColor = .stackLayoutColor
//
//        label1.backgroundColor = .red
//        label1.text = "Label 1"
//
//        label2.backgroundColor = .green
//        label2.text = "Label 2"
//
//        label3.backgroundColor = .blue
//        label3.text = "Label 3"
        
        // configure the StackView
//        logo.item.size(60)
//        stackLayoutView.addItem(logo)
//        
//        textLabel.item.maxWidth(50%)
//        stackLayoutView.addItem(textLabel)
//        
//        separatorView.item.height(4)
//        stackLayoutView.addItem(separatorView)
//        
//        label1.item.marginTop(10).marginBottom(10)
//        stackLayoutView.addItem(label1)
//        
//        stackLayoutView.addItem(label2)
//        stackLayoutView.addItem(label3)
//
//        stackLayoutView.direction(.column)  // Default
//        stackLayoutView.justifyContent(.start)
//        stackLayoutView.alignItems(.stretch)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func testAlignItems() {
        logo.contentMode = .scaleAspectFit
        
        label1 = UILabel()
        label1.backgroundColor = .red
        label1.font = UIFont.systemFont(ofSize: 17)
        label1.text = "Label 1"
        
        label2 = UILabel()
        label2.font = UIFont.systemFont(ofSize: 17)
        label2.backgroundColor = .green
        label2.text = "Label a little longuer"
        
        label3 = UILabel()
        label3.font = UIFont.systemFont(ofSize: 17)
        label3.backgroundColor = .blue
        label3.text = "Label very very very much longuer"
        
        stackLayoutView.addItem(label1)
        stackLayoutView.addItem(label2)
        stackLayoutView.addItem(label3)
        
        stackLayoutView.direction(.column)
        stackLayoutView.justifyContent(.spaceAround)
//        stackLayoutView.alignItems(.center)
        
//        label2.item.alignSelf(.end)
    }
    
    func testRowDirection() {
        logo.contentMode = .scaleAspectFit
        
        label1 = UILabel()
        label1.backgroundColor = .red
        label1.font = UIFont.systemFont(ofSize: 17)
        label1.text = "Label 1"
        label1.numberOfLines = 0
        
        label2 = UILabel()
        label2.font = UIFont.systemFont(ofSize: 17)
        label2.backgroundColor = .green
        label2.text = "Label longuer"
        label2.numberOfLines = 0

        label3 = UILabel()
        label3.font = UIFont.systemFont(ofSize: 17)
        label3.backgroundColor = .blue
        label3.text = "Label much longuer"
        label3.numberOfLines = 0

        stackLayoutView.addItem(label1)
        stackLayoutView.addItem(label2)
        stackLayoutView.addItem(label3)
        
        stackLayoutView.direction(.row)
        stackLayoutView.justifyContent(.start)
        stackLayoutView.alignItems(.start)
        
        label2.item.alignSelf(.auto)
    }
    
    func testMargins() {
        label1 = UILabel()
        label1.backgroundColor = .red
        label1.font = UIFont.systemFont(ofSize: 17)
        label1.text = "Label 1"
//        label1.text = "Label 1 Label 1 Label 1 Label 1 Label 1 Label 1 Label 1 Label 1 Label 1 Label 1 Label 1 Label 1 Label 1"
        
        label2 = UILabel()
        label2.font = UIFont.systemFont(ofSize: 17)
        label2.backgroundColor = .green
        label2.text = "Label longuer"
        
        label3 = UILabel()
        label3.font = UIFont.systemFont(ofSize: 17)
        label3.backgroundColor = .blue
        label3.text = "Label much longuer"
        
        view1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))
        
//        stackLayoutView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
//            label1.item.grow(1).maxHeight(100)
//            label2.item.grow(10).maxHeight(120)
//            view1.item.grow(1).maxHeight(140)
//
//            stack.addItem(label1)
//            stack.addItem(label2)
//            stack.addItem(view1)
//        }
        
        stackLayoutView.direction(.column).justifyContent(.start).alignItems(.stretch).define { (stack) in
            label1.item.grow(1)
            label2.item.grow(10)
            view1.item.grow(1)
            
            stack.addItem(label1)
            stack.addItem(label2)
            stack.addItem(view1)
        }
        
        
        layout()
        
        printViewFrame(stackLayoutView, name: "stackLayoutView")
        printViewFrame(label1, name: "label1")
        printViewFrame(label2, name: "label2")
        //        printViewFrame(label3, name: "label3")
        printViewFrame(view1, name: "view1")
        
//        UIView.animate(withDuration: 1, delay: 6, options: [], animations: {
//
//        }) { (_) in
//
//        }
    }
    
    func didTapView() {
        if label1.isHidden {
            stackLayoutView.showItem(label1, animate: true)
        } else {
            stackLayoutView.hideItem(label1, animate: true)
        }
        print("asdfa")
    }
    
    private func layout() {
//        stackLayoutView.pin.top(64).left().width(400).height(600)
        
        stackLayoutView.pin.top(64).left().width(400).sizeToFit(.width)
        
//        stackLayoutView.pin.top(80).left().height(400).sizeToFit(.height)
//        stackLayoutView.pin.top(80).left().width(400).sizeToFit(.width)
//        stackLayoutView.layout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
        
        // Layout the stackLayoutView using the view's safeArea with at least of 10 pixels all around.
//        stackLayoutView.pin.top(80).left().width(400).height(600)
//        stackLayoutView.layout()
        
//        stackLayoutView.pin.top(80).left().width(400).sizeToFit(.width)
//        stackLayoutView.pin.top(80).left().height(400).sizeToFit(.height)
//        stackLayoutView.layout()
        
//        buttonsStackView.pin.below(of: stackLayoutView).left().right().margin(8).sizeToFit(.width)

//        printViewFrame(stackLayoutView, name: "stackLayoutView")
//        printViewFrame(label1, name: "label1")
//        printViewFrame(label2, name: "label2")
////        printViewFrame(label3, name: "label3")
//        printViewFrame(view1, name: "view1")
    }
    
    fileprivate func printViewFrame(_ view: UIView, name: String) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.decimalSeparator = "."
        
        let x = numberFormatter.string(from: NSNumber(value: Float(view.frame.origin.x)))!
        let y = numberFormatter.string(from: NSNumber(value: Float(view.frame.origin.y)))!
        let width = numberFormatter.string(from: NSNumber(value: Float(view.frame.size.width)))!
        let height = numberFormatter.string(from: NSNumber(value: Float(view.frame.size.height)))!

        print("expect(\(name).frame).to(beCloseTo(CGRect(x: \(x), y: \(y), width: \(width), height: \(height)), within: 0.5))")
    }
    
    internal func didTapToggleDirection() {
        if stackLayoutView.getDirection() == .column {
            stackLayoutView.direction(.row)
        } else {
            stackLayoutView.direction(.column)
        }
        
        setNeedsLayout()
    }
    
    internal func didTapToggleJustify() {
        switch stackLayoutView.getJustifyContent() {
        case .start:        stackLayoutView.justifyContent(.center)
        case .center:       stackLayoutView.justifyContent(.end)
        case .end:          stackLayoutView.justifyContent(.spaceBetween)
        case .spaceBetween: stackLayoutView.justifyContent(.spaceAround)
        case .spaceAround:  stackLayoutView.justifyContent(.spaceEvenly)
        case .spaceEvenly:  stackLayoutView.justifyContent(.start)
        }
        
        setNeedsLayout()
    }
    
    internal func didTapToggleVisibility() {
        if label2.isHidden {
            stackLayoutView.showItem(label2, animate: true)
        } else {
            stackLayoutView.hideItem(label2, animate: true)
        }

        setNeedsLayout()
    }
    
    internal func didTapRemove() {
        label2.removeFromSuperview()
    }
    
    internal func didTapInsert() {
        stackLayoutView.insertItem(label2, at: 1)
    }
}
