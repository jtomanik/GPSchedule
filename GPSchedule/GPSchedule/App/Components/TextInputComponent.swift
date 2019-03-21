//
//  TextInputComponent.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 12/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import Foundation
import UIKit
import Bento
import RxCocoa
import RxSwift

class TextInputComponentView: UIView, NibLoadable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!

    var didUpdate: ((String?) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func setupView() {
        textField.delegate = self
        textField.inputAccessoryView = FocusToolbar(view: self)
        textField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    }
}

final class TextInputComponent: GenericActionableComponent<TextInputState, String?, TextInputComponentView>, Focusable {

    var focusEligibility: FocusEligibility {
        return (state.text?.isEmpty ?? true) ? .eligible(.empty) : .eligible(.populated)
    }

    override func render(in view: TextInputComponentView) {
        view.titleLabel.text = state.title
        view.titleLabel.isEnabled = state.isEnabled
        view.textField.text = state.text
        view.textField.placeholder = state.placeholder
        view.textField.isEnabled = state.isEnabled
        view.didUpdate = didUpdate
    }
}

extension TextInputComponentView: FocusableView {

    public func focus() {
        textField.becomeFirstResponder()
    }

    public func neighboringFocusEligibilityDidChange() {
        (textField.inputAccessoryView as? FocusToolbar)?.updateAvailability()
        updateReturnKeyType()
        textField.reloadInputViews()
    }
}

extension TextInputComponentView: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        updateReturnKeyType()
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        withFocusCoordinator { coordinator in
            if !coordinator.move(.backward) {
                // The coordinator has not done anything regarding the first
                // responder status. Proceed to resign the first responder
                // status as expected.
                textField.resignFirstResponder()
            }
        }

        return false
    }

    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        didUpdate?(textField.text)
    }

    private func updateReturnKeyType() {
        withFocusCoordinator { coordinator in
            textField.returnKeyType = coordinator.canMove(.backward)
                ? .next
                : .done
        }
    }
}

final class FocusToolbar: UIToolbar {

    weak var view: (UIView & FocusableView)?
    var backwardButton: UIBarButtonItem!
    var forwardButton: UIBarButtonItem!

    init(view: UIView & FocusableView) {
        self.view = view

        super.init(frame: .zero)

        backwardButton = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(moveBackward))
        forwardButton = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(moveForward))

        translatesAutoresizingMaskIntoConstraints = false

        let items = [
            forwardButton!,
            backwardButton!,
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismiss))
        ]
        setItems(items, animated: false)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func willMove(toSuperview newSuperview: UIView?) {
        guard newSuperview != nil else {
            return
        }
        updateAvailability()
    }

    fileprivate func updateAvailability() {
        view?.withFocusCoordinator { coordinator in
            backwardButton.isEnabled = coordinator.canMove(.backward)
            forwardButton.isEnabled = coordinator.canMove(.forward)
        }
    }

    @objc
    private func moveBackward() {
        view?.withFocusCoordinator { coordinator in
            _ = coordinator.move(.backward)
        }
    }

    @objc
    private func moveForward() {
        view?.withFocusCoordinator { coordinator in
            _ = coordinator.move(.forward)
        }
    }

    @objc
    private func dismiss() {
        view?.endEditing(true)
    }
}

extension UIBarButtonItem {

    func settingEnabled(_ isEnabled: Bool) -> Self {
        self.isEnabled = isEnabled
        return self
    }
}
