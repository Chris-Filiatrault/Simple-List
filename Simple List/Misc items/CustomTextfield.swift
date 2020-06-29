//
////  CustomTextfield.swift
////  Simple List
////
////  Created by Chris Filiatrault on 29/6/20.
////  Copyright © 2020 Chris Filiatrault. All rights reserved.
////
//
//import SwiftUI
//
//
//struct CustomTextField: UIViewRepresentable {
//
//   @EnvironmentObject var globalVariables: GlobalVariableClass
//    @Binding var text: String
//   @Binding var isEditMode: EditMode
//    var placeholder: String
//
//    func makeUIView(context: Context) -> UITextField {
//         let textField = UITextField(frame: .zero)
//      textField.delegate = context.coordinator
//        textField.placeholder = placeholder
//      return textField
//    }
//
//    func updateUIView(_ uiView: UITextField, context: Context) {
//      uiView.text = text
//      uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
//      uiView.setContentCompressionResistancePriority(.required, for: .vertical)
//    }
//
//    func makeCoordinator() -> CustomTextField.Coordinator {
//        Coordinator(parent: self)
//    }
//   
//
//    class Coordinator: NSObject, UITextFieldDelegate {
//        
//        var parent: CustomTextField
//
//        init(parent: CustomTextField) {
//            self.parent = parent
//        }
//
//        func textFieldDidChangeSelection(_ textField: UITextField) {
//            parent.text = textField.text ?? ""
//        }
//
//      func textFieldDidBeginEditing(_ textField: UITextField) {
//      //      self.isEditMode = .inactive
//      //      print(globalVariables.isEditMode)
//            print("Textfield Active")
//         }
//      
////      func textFieldDidBeginEditing(_ textField: UITextField) {
//////            parent.globalVariables.isEditMode = .inactive
////            parent.globalVariables.textfieldActive.toggle()
//////            print(globalVariables.isEditMode)
//////            resetMOC()
////            print("Textfield Active")
////         }
//
//    }
//}
//
//
//
//
//
//////
//////  CustomTextfield.swift
//////  Simple List
//////
//////  Created by Chris Filiatrault on 29/6/20.
//////  Copyright © 2020 Chris Filiatrault. All rights reserved.
//////
////
////import SwiftUI
////
////
////struct CustomTextField: UIViewRepresentable {
////
////   @EnvironmentObject var globalVariables: GlobalVariableClass
////    @Binding var text: String
////   @Binding var isEditMode: EditMode
////    var placeholder: String
////
////    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
////        let textField = UITextField(frame: .zero)
////        textField.delegate = context.coordinator
////        textField.placeholder = placeholder
////        return textField
////    }
////
////    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
////        uiView.text = text
////        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
////        uiView.setContentCompressionResistancePriority(.required, for: .vertical)
////    }
////
////    func makeCoordinator() -> CustomTextField.Coordinator {
////        Coordinator(parent: self)
////    }
////
////
////    class Coordinator: NSObject, UITextFieldDelegate {
////
////        var parent: CustomTextField
////
////        init(parent: CustomTextField) {
////            self.parent = parent
////        }
////
////        func textFieldDidChangeSelection(_ textField: UITextField) {
////            parent.text = textField.text ?? ""
////        }
////
////      func textFieldDidBeginEditing(_ textField: UITextField) {
//////            parent.globalVariables.isEditMode = .inactive
////            parent.globalVariables.textfieldActive.toggle()
//////            print(globalVariables.isEditMode)
//////            resetMOC()
////            print("Textfield Active")
////         }
////
////    }
////}
////
////
//
//
//
////
////  JPTextField.swift
////  Simple List
////
////  Created by Chris Filiatrault on 29/6/20.
////  Copyright © 2020 Chris Filiatrault. All rights reserved.
////
//
//
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
////        control.onCommit()
////    }
////}
////
////struct UIKitTextField: UIViewRepresentable {
////
////
////   @EnvironmentObject var globalVariables: GlobalVariableClass
////    private let title: String?
////    @Binding var text: String
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
////       self.title = title
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
////      globalVariables.isEditMode = .inactive
////      print(globalVariables.isEditMode)
////      print("Textfield Active")
////   }
////
////    func makeUIView(context: Context) -> UITextField {
////         let textField = UITextField(frame: .zero)
////      textField.delegate = context.coordinator as? UITextFieldDelegate
////        textField.placeholder = title
////      return textField
////    }
////
////    func updateUIView(_ uiView: UITextField, context: Context) {
////      uiView.text = text
////      uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
////      uiView.setContentCompressionResistancePriority(.required, for: .vertical)
////    }
////}
