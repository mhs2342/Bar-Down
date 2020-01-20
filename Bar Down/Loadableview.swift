//
//  Loadableview.swift
//  Bar Down
//
//  Created by Matthew Sanford on 1/20/20.
//  Copyright © 2020 sanch. All rights reserved.
//

import Cocoa

protocol LoadableView: class {
    func load(fromNIBNamed nibName: String) -> Bool
    func add(toView parentView: NSView)
}


extension LoadableView where Self: NSView {
    @discardableResult
    func load(fromNIBNamed nibName: String) -> Bool {
        var nibObjects: NSArray?
        let nibName = NSNib.Name(stringLiteral: nibName)

        if Bundle.main.loadNibNamed(nibName, owner: self, topLevelObjects: &nibObjects) {
            guard let nibObjects = nibObjects else { return false }

            let viewObjects = nibObjects.filter { $0 is NSView }

            if !viewObjects.isEmpty {
                guard let view = viewObjects[0] as? NSView else { return false }
                self.addSubview(view)
                view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                    view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                    view.topAnchor.constraint(equalTo: self.topAnchor),
                    view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
                ])


                return true
            }
        }

        return false
    }


    func add(toView parentView: NSView) {
        parentView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
    }
}
