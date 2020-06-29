//////
//////  JPTextField.swift
//////  Simple List
//////
//////  Created by Chris Filiatrault on 29/6/20.
//////  Copyright © 2020 Chris Filiatrault. All rights reserved.
//////
////
////
////
////import  SwiftUI
////import UIKit
////
////final class UIKitTextFieldCoordinator: NSObject {
////    var control: UIKitTextField
////
////    init(_ control: UIKitTextField) {
////        self.control = control
////        super.init()
////        control.textField.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)
////        control.textField.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEnd)
////        control.textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
////        control.textField.addTarget(self, action: #selector(textFieldEditingDidEndOnExit(_:)), for: .editingDidEndOnExit)
////    }
////
////    @objc private func textFieldEditingDidBegin(_ textField: UITextField) {
////        control.onEditingChanged(true)
////    }
////
////    @objc private func textFieldEditingDidEnd(_ textField: UITextField) {
////        control.onEditingChanged(false)
////    }
////
////    @objc private func textFieldEditingChanged(_ textField: UITextField) {
////        control.text = textField.text ?? ""
////    }
////
////    @objc private func textFieldEditingDidEndOnExit(_ textField: UITextField) {
////      control.onCommit()
////    }
////}
////
////struct UIKitTextField: UIViewRepresentable {
////
////
////   @EnvironmentObject var globalVariables: GlobalVariableClass
////    private let placeholder: String?
////    @Binding var text: String
////
////    let onEditingChanged: (Bool) -> Void
////    let onCommit: () -> Void
////
////    let textField = UITextField()
////
//////    init(title: String?, text: Binding<String>, onEditingChanged: @escaping (Bool) -> Void = { _ in }, onCommit: @escaping () -> Void = {}) {
//////        self.title = title
//////        self._text = text
//////        self.onEditingChanged = onEditingChanged
//////        self.onCommit = onCommit
//////    }
////
////   init(title: String?, text: Binding<String>, onEditingChanged: @escaping (Bool) -> Void = { _ in }, onCommit: @escaping () -> Void = {}) {
////       self.placeholder = title
////       self._text = text
////       self.onEditingChanged = onEditingChanged
////       self.onCommit = onCommit
////   }
////
////    func makeCoordinator() -> UIKitTextFieldCoordinator {
////        UIKitTextFieldCoordinator(self)
////    }
////
////   func textFieldDidBeginEditing(textField: UITextField!) {
//////      self.isEditMode = .inactive
//////      print(globalVariables.isEditMode)
////      print("Textfield Active")
////   }
////
////    func makeUIView(context: Context) -> UITextField {
////         let textField = UITextField(frame: .zero)
////      textField.delegate = context.coordinator as? UITextFieldDelegate
////        textField.placeholder = placeholder
////      return textField
////    }
////
////    func updateUIView(_ uiView: UITextField, context: Context) {
////      uiView.text = text
////      uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
////      uiView.setContentCompressionResistancePriority(.required, for: .vertical)
////    }
////}
//
//
//
//import  SwiftUI
//
//
//final class UIKitTextFieldCoordinator: NSObject {
//    var control: UIKitTextField
//
//    init(_ control: UIKitTextField) {
//        self.control = control
//        super.init()
//        control.textField.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)
//        control.textField.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEnd)
//        control.textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
//        control.textField.addTarget(self, action: #selector(textFieldEditingDidEndOnExit(_:)), for: .editingDidEndOnExit)
//    }
//
//    @objc private func textFieldEditingDidBegin(_ textField: UITextField) {
//        control.onEditingChanged(true)
//    }
//
//    @objc private func textFieldEditingDidEnd(_ textField: UITextField) {
//        control.onEditingChanged(false)
//    }
//
//    @objc private func textFieldEditingChanged(_ textField: UITextField) {
//        control.text = textField.text ?? ""
//    }
//
//    @objc private func textFieldEditingDidEndOnExit(_ textField: UITextField) {
//        control.onCommit()
//    }
//}
//
//struct UIKitTextField: UIViewRepresentable {
//
//    private let title: String?
//    @Binding var text: String
//    let onEditingChanged: (Bool) -> Void
//    let onCommit: () -> Void
//
//    let textField = UITextField(frame: .zero)
//
//    init(title: String?, text: Binding<String>, onEditingChanged: @escaping (Bool) -> Void = { _ in }, onCommit: @escaping () -> Void = {}) {
//        self.title = title
//        self._text = text
//        self.onEditingChanged = onEditingChanged
//        self.onCommit = onCommit
//    }
//
//    func makeCoordinator() -> UIKitTextFieldCoordinator {
//        UIKitTextFieldCoordinator(self)
//    }
//
//    func makeUIView(context: Context) -> UITextField {
//        textField.placeholder = title
//      textField.delegate = context.coordinator as? UITextFieldDelegate
//        return textField
//    }
//
//    func updateUIView(_ uiView: UITextField, context: Context) {
////            uiView.text = text
//            uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
//            uiView.setContentCompressionResistancePriority(.required, for: .vertical)
//    }
//}
