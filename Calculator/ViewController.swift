//
//  ViewController.swift
//  Calculator
//
//  Created by 田逸昕 on 2019/2/28.
//  Copyright © 2019 Ezreal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //显示文本框
    @IBOutlet weak var outputLabel: UILabel!
    //AC按钮
    @IBOutlet weak var ACButton: UIButton!
    //C按钮
    @IBOutlet weak var CButton: UIButton!
    //除号按钮
    @IBOutlet weak var divideButton: UIButton!
    //乘号按钮
    @IBOutlet weak var multipleButton: UIButton!
    //减号按钮
    @IBOutlet weak var subButton: UIButton!
    //加号按钮
    @IBOutlet weak var addButton: UIButton!
    //判断当前输入项是否是小数
    var isDigit = false
    //判断当前是否有第一个输入数
    var hasFirstNumber = false
    var hasSecondNumber = false
    //操作数1
    var num1: Double = 0
    //操作数2
    var num2: Double = 0
    //运算符号
    var ope: Operator = .add
    //加减乘除按钮点击后颜色
    let changeColor = UIColor.init(red: 255/255, green: 147/255, blue: 0/255, alpha: 1)
    enum Operator {
        case add
        case sub
        case multiple
        case divide
    }
    
    override func viewDidLoad() {
        CButton.isHidden = true
        CButton.isEnabled = false
    }
    
    //切换AC和C按钮
    func switchACButton() {
        clearOpeButton()
        CButton.isEnabled = true
        CButton.isHidden = false
        ACButton.isEnabled = false
    }
    
    //加减乘除按钮触碰动态效果
    func changeOpeButtonColor() {
        switch ope {
        case .add:
            let animate = UIViewPropertyAnimator(duration: 0.8, dampingRatio: 0.7) {
                self.addButton.backgroundColor = .white
                self.addButton.setTitleColor(self.changeColor, for: .normal)
                self.subButton.backgroundColor = self.changeColor
                self.subButton.setTitleColor(.white, for: .normal)
                self.multipleButton.backgroundColor = self.changeColor
                self.multipleButton.setTitleColor(.white, for: .normal)
                self.divideButton.backgroundColor = self.changeColor
                self.divideButton.setTitleColor(.white, for: .normal)
            }
            animate.startAnimation()
        case .divide:
            let animate = UIViewPropertyAnimator(duration: 0.8, dampingRatio: 0.7) {
                self.addButton.backgroundColor = self.changeColor
                self.addButton.setTitleColor(.white, for: .normal)
                self.subButton.backgroundColor = self.changeColor
                self.subButton.setTitleColor(.white, for: .normal)
                self.multipleButton.backgroundColor = self.changeColor
                self.multipleButton.setTitleColor(.white, for: .normal)
                self.divideButton.backgroundColor = .white
                self.divideButton.setTitleColor(self.changeColor, for: .normal)
            }
            animate.startAnimation()
        case .multiple:
            let animate = UIViewPropertyAnimator(duration: 0.8, dampingRatio: 0.7) {
                self.addButton.backgroundColor = self.changeColor
                self.addButton.setTitleColor(.white, for: .normal)
                self.subButton.backgroundColor = self.changeColor
                self.subButton.setTitleColor(.white, for: .normal)
                self.multipleButton.backgroundColor = .white
                self.multipleButton.setTitleColor(self.changeColor, for: .normal)
                self.divideButton.backgroundColor = self.changeColor
                self.divideButton.setTitleColor(.white, for: .normal)
            }
            animate.startAnimation()
        case .sub:
            let animate = UIViewPropertyAnimator(duration: 0.8, dampingRatio: 0.7) {
                self.addButton.backgroundColor = self.changeColor
                self.addButton.setTitleColor(.white, for: .normal)
                self.subButton.backgroundColor = .white
                self.subButton.setTitleColor(self.changeColor, for: .normal)
                self.multipleButton.backgroundColor = self.changeColor
                self.multipleButton.setTitleColor(.white, for: .normal)
                self.divideButton.backgroundColor = self.changeColor
                self.divideButton.setTitleColor(.white, for: .normal)
            }
            animate.startAnimation()
        }
    }
    
    //加减乘除按钮清除按键效果
    func clearOpeButton() {
        let animate = UIViewPropertyAnimator(duration: 0.8, dampingRatio: 0.7) {
            self.addButton.backgroundColor = self.changeColor
            self.addButton.setTitleColor(.white, for: .normal)
            self.subButton.backgroundColor = self.changeColor
            self.subButton.setTitleColor(.white, for: .normal)
            self.multipleButton.backgroundColor = self.changeColor
            self.multipleButton.setTitleColor(.white, for: .normal)
            self.divideButton.backgroundColor = self.changeColor
            self.divideButton.setTitleColor(.white, for: .normal)
        }
        animate.startAnimation()
    }
    
    //数字键触碰事件
    func touchNumberButton(number: Int) {
        if hasFirstNumber && !hasSecondNumber {
            hasSecondNumber = true
            num1 = Double(outputLabel.text!)!
            outputLabel.text = "\(number)"
        } else {
            let tempNum = Double(outputLabel.text!)!
            if (outputLabel.text?.hasPrefix("-"))! && tempNum == 0 {
                outputLabel.text = "-\(number)"
            } else if  !(outputLabel.text?.hasPrefix("-"))! && tempNum == 0{
                outputLabel.text = "\(number)"
            } else {
                outputLabel.text = outputLabel.text! + "\(number)"
            }
        }
    }
    
    //AC按钮触发事件
    @IBAction func ACAction(_ sender: Any) {
        clearOpeButton()
        outputLabel.text = "0"
        isDigit = false
        hasFirstNumber = false
        num1 = 0
        num2 = 0
    }
    
    //C按钮触发事件
    @IBAction func CAction(_ sender: Any) {
        outputLabel.text = "0"
        CButton.isEnabled = false
        CButton.isHidden = true
        ACButton.isEnabled = true
    }
    
    //负号
    @IBAction func negateAction(_ sender: Any) {
        if (outputLabel.text?.hasPrefix("-"))! {
            outputLabel.text = outputLabel.text?.cutString(start: 1, end: (outputLabel.text?.count)!)
        } else {
            outputLabel.text = "-" + outputLabel.text!
        }
    }
    
    //百分号
    @IBAction func percentAction(_ sender: Any) {
        let number = Double(outputLabel.text!)!
        outputLabel.text = "\(number/100)"
    }
    
    //除号
    @IBAction func divideAction(_ sender: Any) {
        ope = .divide
        changeOpeButtonColor()
        hasFirstNumber = true
        isDigit = false
    }
    //乘号
    @IBAction func multipleAction(_ sender: Any) {
        ope = .multiple
        changeOpeButtonColor()
        hasFirstNumber = true
        isDigit = false
    }
    //减号
    @IBAction func subAction(_ sender: Any) {
        ope = .sub
        changeOpeButtonColor()
        hasFirstNumber = true
        isDigit = false
    }
    //加号
    @IBAction func addAction(_ sender: Any) {
        ope = .add
        changeOpeButtonColor()
        hasFirstNumber = true
        isDigit = false
    }
    //数字1
    @IBAction func oneButton(_ sender: Any) {
        touchNumberButton(number: 1)
    }
    //数字2
    @IBAction func twoButton(_ sender: Any) {
        touchNumberButton(number: 2)
    }
    //数字3
    @IBAction func threeButton(_ sender: Any) {
        touchNumberButton(number: 3)
    }
    //数字4
    @IBAction func fourButton(_ sender: Any) {
        touchNumberButton(number: 4)
    }
    //数字5
    @IBAction func fiveButton(_ sender: Any) {
        touchNumberButton(number: 5)
    }
    //数字6
    @IBAction func sixButton(_ sender: Any) {
        touchNumberButton(number: 6)
    }
    //数字7
    @IBAction func sevenButton(_ sender: Any) {
        touchNumberButton(number: 7)
    }
    //数字8
    @IBAction func eightButton(_ sender: Any) {
        touchNumberButton(number: 8)
    }
    //数字9
    @IBAction func nineButton(_ sender: Any) {
        touchNumberButton(number: 9)
    }
    //数字0
    @IBAction func zeroButton(_ sender: Any) {
        touchNumberButton(number: 0)
    }
    //小数点
    @IBAction func digitButton(_ sender: Any) {
        if isDigit {
            
        } else {
            isDigit = true
            outputLabel.text = outputLabel.text! + "."
        }
    }
    //等号
    @IBAction func equalAction(_ sender: Any) {
        clearOpeButton()
        hasFirstNumber = true
        hasSecondNumber = false
        var tempNum1 = NSDecimalNumber.init(value: num1)
        let tempNum2 = NSDecimalNumber.init(value: Double(outputLabel.text!)!)
        switch ope {
        case .add:
            tempNum1 =  tempNum1.adding(tempNum2)
        case .sub:
            tempNum1 =  tempNum1.subtracting(tempNum2)
        case .multiple:
            tempNum1 = tempNum1.multiplying(by: tempNum2)
        case .divide:
            tempNum1 = tempNum1.dividing(by: tempNum2)
        }
        var result = "\(tempNum1)"
        if result.hasSuffix(".0") {
            result = result.cutString(start: 0, end: result.count - 2)
        }
        outputLabel.text = result
        num1 = Double(truncating: tempNum1)
    }
    
}

extension String {
    func cutString(start: Int, end: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: start)
        let endIndex = self.index(self.startIndex, offsetBy: end)
        return String(self[startIndex ..< endIndex])
    }
}
