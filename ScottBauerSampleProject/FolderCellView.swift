//
//  FolderCellView.swift
//  ScottBauerSampleProject
//
//  Created by Scott Bauer on 10/14/22.
//

import AppKit

class FolderCellView: NSTableCellView {
    var label: NSTextField!
    let item: Node
    
    init(frame frameRect: NSRect, item: Node) {
        self.item = item
        super.init(frame: frameRect)
        self.label = NSTextField(frame: .zero)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.drawsBackground = false
        self.label.isBordered = false
        self.label.layer?.cornerRadius = 10.0
        self.label.font = .labelFont(ofSize: 13)
        self.label.lineBreakMode = .byTruncatingMiddle
        self.label.stringValue = item.value

        self.addSubview(label)
        self.textField = label
        
        self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

