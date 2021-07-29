//
//  InputfieldNeighborhood.swift
//  
//
//  Created by Ludvig Hemma on 2021-07-21.
//

import Foundation
import UIKit

public class InputFieldNeighborhood: NSObject, UITextFieldDelegate, UITextViewDelegate {

    let containerView: UIView
    let backgroundView: UIView
    let textField: UITextField?
    let textView: UITextView?
    var inputField: UIView { return textField ?? textView! }
    let headerLabel: UILabel?
    let underlineView: UIView?
    let characterCounterLabel: UILabel?
    let errorImageView: UIImageView?
    let xImageView: UIImageView?
    let xBackgroundView: UIView?

    weak var delegate: InputFieldNeighborhoodDelegate!

    private var validationClosure: (() -> (Bool))? = nil

    public init(containerView: UIView,
                backgroundView: UIView,
                inputField: UIView,
                headerLabel: UILabel? = nil,
                underlineView: UIView? = nil,
                characterCounterLabel: UILabel? = nil,
                errorImageView: UIImageView? = nil,
                xImageView: UIImageView? = nil,
                xBackgroundView: UIView? = nil) {
        assert((inputField is UITextField) != (inputField is UITextView), "textField and textView must be mutually exclusive.")
        self.containerView = containerView
        self.backgroundView = backgroundView
        self.textField = inputField as? UITextField
        self.textView = inputField as? UITextView
        self.headerLabel = headerLabel
        self.underlineView = underlineView
        self.characterCounterLabel = characterCounterLabel
        self.errorImageView = errorImageView
        self.xImageView = xImageView
        self.xBackgroundView = xBackgroundView
        super.init()
        textField?.delegate = self
        textView?.delegate = self
    }


    //MARK: - UITextFieldDelegate -
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return delegate.textFieldShouldReturn(textField, neighborhood: self)
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return delegate.textField(textField, shouldChangeCharactersIn: range, replacementString: string, neighborhood: self)
    }

    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        xImageView?.isHidden = false
        xBackgroundView?.isHidden = false
        return true
    }

    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        xImageView?.isHidden = true
        xBackgroundView?.isHidden = true
        return true
    }

    //MARK: - UITextViewDelegate -
    // --





    public func setValidationClosure(_ closure: @escaping (() -> (Bool))) -> InputFieldNeighborhood {
        validationClosure = closure
        return self
    }

    /// Returns true if no validationClosure has been set.
    func validate() -> Bool {
        return validationClosure?() ?? true
    }

}
