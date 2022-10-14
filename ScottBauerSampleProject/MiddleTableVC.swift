//
//  MiddleTableVC.swift
//  ScottBauerSampleProject
//
//  Created by Scott Bauer on 10/14/22.
//

import AppKit

class MiddleTableVC: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    var initialized = false
    let scrollView = NSScrollView()
    let tableView = NSTableView()
    var node: Node
    let tableHeaderView = NSTableHeaderView()
    let searchBar = NSSearchField()
    
    var splitViewController: NSSplitViewController?
   
    
    init(node: Node) {
        self.node = node
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        // do not use super.loadView here when using programmatic ui
        self.view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayout() {
        if !initialized {
            initialized = true
            setupTableView()
            splitViewController = self.parent as? NSSplitViewController
        }
    }

    
    func setupTableView() {
        self.view.addSubview(scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        //            NSLayoutConstraint.activate([
        //                scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
        //                scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        //                scrollView.widthAnchor.constraint(equalTo: view.widthAnchor)
        //            ])
        
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 23))
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0))
        tableView.frame = scrollView.bounds
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.headerView = nil
        scrollView.backgroundColor = NSColor.clear
        scrollView.drawsBackground = false
        tableView.backgroundColor = NSColor.clear
//        tableView.appearance = NSAppearance(named: NSAppearance.Name.vibrantDark)
        
        let col = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "col"))
        //            col.minWidth = 200
        tableView.addTableColumn(col)
        tableView.style = .inset
        
        scrollView.documentView = tableView
        scrollView.hasHorizontalScroller = false
        scrollView.hasVerticalScroller = true
        
        
        print("item identifier = \(view.window?.toolbar?.items[4].itemIdentifier)")
        view.window?.toolbar?.items[4].isEnabled = true

        
    }
    override func viewWillDisappear() {
        view.window?.toolbar?.items[4].isEnabled = false
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 100
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let text = NSTextField()
        text.stringValue = node.value
        let cell = NSTableCellView()
        cell.addSubview(text)
        text.drawsBackground = false
        text.isBordered = false
        text.translatesAutoresizingMaskIntoConstraints = false
        cell.addConstraint(NSLayoutConstraint(item: text, attribute: .centerY, relatedBy: .equal, toItem: cell, attribute: .centerY, multiplier: 1, constant: 0))
        cell.addConstraint(NSLayoutConstraint(item: text, attribute: .left, relatedBy: .equal, toItem: cell, attribute: .left, multiplier: 1, constant: 13))
        cell.addConstraint(NSLayoutConstraint(item: text, attribute: .right, relatedBy: .equal, toItem: cell, attribute: .right, multiplier: 1, constant: -13))
        return cell
    }
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        let rowView = NSTableRowView()
        rowView.isEmphasized = false
        return rowView
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        DispatchQueue.main.async {
            if let controller = self.splitViewController {
                let colorVC = ColorViewController(backgroundColor: .purple)
                colorVC.view.widthAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
                    let item = NSSplitViewItem(viewController: colorVC)
                // put a TableView in the secondary pane

                controller.removeSplitViewItem(controller.splitViewItems[2])
                controller.insertSplitViewItem(item, at: 2)


                print("should it worked")
            }
        }
    }

}




