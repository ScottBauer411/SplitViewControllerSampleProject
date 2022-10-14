//
//  FolderListViewController.swift
//  ScottBauerSampleProject
//
//  Created by Scott Bauer on 10/14/22.
//

import AppKit

class FolderListViewController: NSViewController {
    
    struct NameConstants {
        static let untitled = NSLocalizedString("untitled string", comment: "")
        static let favorites = NSLocalizedString("favorites string", comment: "")
        static let pictures = NSLocalizedString("pictures string", comment: "")
    }
    
    static let favoritesID = "1001"

    var folderOutlineView: OutlineView!
    var scrollView: NSScrollView!
    var treeController = NSTreeController()

    @objc dynamic var content = [Node]()
    
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    
    override func loadView() {
        configureScrollView()
        configureOutlineView()
        configureTreeBindings()
        addSampleData()
    }
    
    func configureOutlineView() {
        folderOutlineView = OutlineView(frame: NSRect(x: 0, y: 0, width: 100, height: 800))
        folderOutlineView.autoresizingMask = .height
        folderOutlineView.translatesAutoresizingMaskIntoConstraints = true
        view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.purple.cgColor
        folderOutlineView.wantsLayer = true
        folderOutlineView.frame = NSRect(x: 0, y: 0, width: 100, height: 800)
        
        let column = NSTableColumn(identifier: .init(rawValue: "Cell"))
        column.title = "Cell"
        folderOutlineView.addTableColumn(column)
        folderOutlineView.headerView = nil
        
        folderOutlineView.delegate = self
        
        scrollView.documentView = folderOutlineView
        self.scrollView.contentView.automaticallyAdjustsContentInsets = false
        self.scrollView.contentView.contentInsets = .init(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    func configureScrollView() {
        self.scrollView = NSScrollView()
        view = scrollView
    }
    
    func configureTreeBindings() {
        treeController.objectClass = Node.self
        treeController.childrenKeyPath = "children"
        treeController.countKeyPath = "count"
        treeController.leafKeyPath = "isLeaf"

        folderOutlineView.gridStyleMask = .solidHorizontalGridLineMask
        folderOutlineView.autosaveExpandedItems = true

        treeController.bind(NSBindingName(rawValue: "contentArray"),
                            to: self,
                            withKeyPath: "content",
                            options: nil)

        folderOutlineView.bind(NSBindingName(rawValue: "content"),
                  to: treeController,
                  withKeyPath: "arrangedObjects",
                  options: nil)
    }
    
    func addSampleData() {
        content.append(contentsOf: NodeFactory().nodes())
    }
    
    func addNewFolder() {
        let node = Node(value: "New")
        node.children = []
        
        var insertionIndexPath: IndexPath
        insertionIndexPath = IndexPath(index: content.count)

        treeController.insert(node, atArrangedObjectIndexPath: insertionIndexPath)

    }
}


class OutlineView: NSOutlineView {
    // OutlineView specific things here
}


extension FolderListViewController: NSOutlineViewDelegate {
    
    public func outlineView(_ outlineView: NSOutlineView,
                            viewFor tableColumn: NSTableColumn?,
                            item: Any) -> NSView? {
        
        guard let tableColumn = tableColumn else { return nil }
        let frameRect = NSRect(x: 0, y: 0, width: tableColumn.width, height: 40)
        guard let node = (item as! NSTreeNode).representedObject as? Node else { return nil }
        
        return FolderCellView(frame: frameRect, item: node)
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        // if `ColorViewController` was a tableview, how would I be able to pass data between this view and the `ColorViewController`?
        
        DispatchQueue.main.async {
            let selectedNode = self.folderOutlineView.item(atRow: self.folderOutlineView.selectedRow) as! NSTreeNode
            let childItem = selectedNode.representedObject as! Node
            if let splitViewController = self.parent as? NSSplitViewController {
                let colorView = MiddleTableVC(node: childItem)
                let item = NSSplitViewItem(viewController: colorView)

                splitViewController.removeSplitViewItem(splitViewController.splitViewItems[1])
                splitViewController.insertSplitViewItem(item, at: 1)
                splitViewController.splitView.autosaveName = "mySplitViewState"


                print("it worked")
            }

        }
    }
    
}



class ViewCell: NSTableCellView {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        let view = NSView()
        view.layer?.backgroundColor = NSColor.green.cgColor
        addSubview(view)
    }
}
