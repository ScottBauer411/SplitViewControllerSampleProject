//
//  SSplitVC.swift
//  ScottBauerSampleProject
//
//  Created by Scott Bauer on 10/14/22.
//

import AppKit

class SToolbar: NSToolbar {
    
}

class SSplitVC: NSSplitViewController {
    private let splitViewResorationIdentifier = "com.metatechcreations.restorationId:mainSplitViewController"

    lazy var view1 = ColorViewController(backgroundColor: .white)
    lazy var view2 = ColorViewController(backgroundColor: .white)
    
    private lazy var redBox = NSView(frame: NSRect(x: 0, y: 0, width: 400, height: 400))
        
    lazy var folderListVC = FolderListViewController()
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
          super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
          setupUI()
          setupLayout()
        
       }

       required init?(coder: NSCoder) {
          super.init(coder: coder)
       }
    
    override func loadView() {
        super.loadView()
        
        // size of the app
        view.frame = NSRect(x: 0, y: 0, width: 800, height: 600)
    }
}




extension SSplitVC {
    
    private func setupUI() {
          view.wantsLayer = true
        splitView.dividerStyle = .thin
        
          splitView.autosaveName = NSSplitView.AutosaveName( splitViewResorationIdentifier)
          splitView.identifier = NSUserInterfaceItemIdentifier(rawValue: splitViewResorationIdentifier)

          folderListVC.view.widthAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
          view1.view.widthAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
          view2.view.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
       }

    private func setupLayout() {
        minimumThicknessForInlineSidebars = 180

          let sidebarItem = NSSplitViewItem(sidebarWithViewController: folderListVC)
          sidebarItem.canCollapse = true
          sidebarItem.holdingPriority = NSLayoutConstraint.Priority(NSLayoutConstraint.Priority.defaultLow.rawValue + 1)
        
          addSplitViewItem(sidebarItem)
//        sidebarItem.minimumThickness = 200
        
          let xibItem = NSSplitViewItem(viewController: view1)
          addSplitViewItem(xibItem)
//        xibItem.minimumThickness = 80
        
          let codeItem = NSSplitViewItem(viewController: view2)
          addSplitViewItem(codeItem)

//        codeItem.minimumThickness = 80
       }
}



class ColorViewController: NSViewController {

   private let backgroundColor: NSColor

   init(backgroundColor: NSColor) {
      self.backgroundColor = backgroundColor
      super.init(nibName: nil, bundle: nil)
   }

   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }

   override func loadView() {
      view = NSView()
      view.wantsLayer = true
      view.layer?.backgroundColor = backgroundColor.cgColor
   }
}


