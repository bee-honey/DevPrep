//
//  RichTextView.swift
//  DevPrep
//
//  Created by Naveen Keerthy on 7/17/24.
//

import SwiftUI
import UIKit

struct RichTextView: UIViewRepresentable {
    @Binding var text: NSAttributedString
    var isEditable: Bool
    
    init(text: Binding<NSAttributedString>, isEditable: Bool = true) {
        self._text = text
        self.isEditable = isEditable
    }
    
    init(text: NSAttributedString) {
        self._text = .constant(text)
        self.isEditable = false
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = isEditable
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.attributedText != text {
            uiView.attributedText = text
        }
        uiView.isEditable = isEditable
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: RichTextView
        
        init(_ parent: RichTextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            if parent.isEditable {
                parent.text = textView.attributedText
            }
        }
    }
}
