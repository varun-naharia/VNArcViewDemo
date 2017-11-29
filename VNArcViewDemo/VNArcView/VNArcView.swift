//
//  VNArcView.swift
//  VNArcViewDemo
//
//  Created by Varun Naharia on 29/11/17.
//  Copyright © 2017 Varun Naharia. All rights reserved.
//

import UIKit

@IBDesignable
class VNArcView: UIView {
    var view: UIView!
    private let radius: CGFloat = 110.0
    private let lineWidth: CGFloat = 20.0
    
    private let startAngle: CGFloat = -210.piValue()
    private let endAngle: CGFloat = 30.piValue()
    
    private let trackLayer = CAShapeLayer()
    
    let progressLayer = CAShapeLayer()
    
    private let gradientLayer = CALayer()
    private let colorLayer = CAGradientLayer()
    
    @IBInspectable var percent: CGFloat = 0.8
    @IBOutlet weak var labelUnit: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
        xibSetup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.setUpView()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.view.isOpaque = false
        view.isOpaque = false
        setUpView()
    }
    
    func updateView() {
        
    }
    
    func setUpView() {
        trackLayer.frame = self.bounds
        self.layer.addSublayer(trackLayer)
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        // use bounds not frame or it'll be offset
        view.frame = bounds
        self.backgroundColor = view.backgroundColor
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
        view.isOpaque = false
        self.isOpaque = false
        self.setUpView()
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "VNArcView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = UIColor.white.cgColor
        trackLayer.opacity = 1.0
        trackLayer.lineCap = kCALineCapSquare
        trackLayer.lineWidth = self.lineWidth
        
        let path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y: (self.frame.size.height/2)+((self.frame.size.height/5)/2)), radius: self.bounds.width/2 - self.lineWidth / 2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        trackLayer.path = path.cgPath
        
        progressLayer.frame = self.bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.blue.cgColor
        progressLayer.lineCap = kCALineCapSquare
        progressLayer.lineWidth = self.lineWidth
        progressLayer.path = path.cgPath
        progressLayer.strokeEnd = self.percent
        
        colorLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        colorLayer.backgroundColor = UIColor.blue.cgColor
        colorLayer.locations = [0.3]
        colorLayer.startPoint = CGPoint(x: 0, y: 1)
        colorLayer.endPoint = CGPoint(x: 0, y: 0)

        self.colorLayer.mask = self.progressLayer
        self.layer.addSublayer(self.colorLayer)
    }
    

    
    func setProgressValue(percent: CGFloat, animated: Bool = true) {
        
        CATransaction.begin()
        CATransaction.setDisableActions(!animated)
        CATransaction.setAnimationDuration(0.1)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear))
        self.progressLayer.strokeEnd = percent
        CATransaction.commit()
        
        self.percent = percent
    }
}

extension Int{
    func piValue()->CGFloat{
        return CGFloat(Double.pi) * CGFloat(self)/180.0
    }
}

