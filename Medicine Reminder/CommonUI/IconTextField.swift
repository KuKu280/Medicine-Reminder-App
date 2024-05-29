//
//  IconTextField.swift
//  Medicine Reminder
//
//  Created by kukuzan on 28/05/2024.
//

import Foundation
import UIKit

@IBDesignable
class IconTextField: UITextField {
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var padding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        if let image = leftImage {
            leftViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: imageView.frame.width + padding, height: imageView.frame.height))
            imageView.center = paddingView.center
            paddingView.addSubview(imageView)
            
            leftView = paddingView
        } else {
            leftViewMode = .never
            leftView = nil
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding + 20, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
