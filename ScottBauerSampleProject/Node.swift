//
//  Node.swift
//  ScottBauerSampleProject
//
//  Created by Scott Bauer on 10/14/22.
//

import Cocoa
import UniformTypeIdentifiers

final class NodeFactory {
    func nodes() -> [Node] {
        return [
            .init(value: "💰 Offers", children: [
                .init(value: "🍦 Ice Cream", children: [
                    .init(value: "💵 $0.24 back")
                ]),
                .init(value: "☕️ Coffee", children: [
                    .init(value: "💵 $0.75 back")
                ]),
                .init(value: "🍔 Burger", children: [
                    .init(value: "💵 $1.00 back")
                ])
            ]),
            .init(value: "Retailers", children: [
                .init(value: "King Soopers"),
                .init(value: "Walmart"),
                .init(value: "Target"),
            ]),
            .init(value: "💰 Offers", children: [
                .init(value: "🍦 Ice Cream", children: [
                    .init(value: "💵 $0.24 back")
                ]),
                .init(value: "☕️ Coffee", children: [
                    .init(value: "💵 $0.75 back")
                ]),
                .init(value: "🍔 Burger", children: [
                    .init(value: "💵 $1.00 back")
                ])
            ]),
            .init(value: "💰 Offers", children: [
                .init(value: "🍦 Ice Cream", children: [
                    .init(value: "💵 $0.24 back")
                ]),
                .init(value: "☕️ Coffee", children: [
                    .init(value: "💵 $0.75 back")
                ]),
                .init(value: "🍔 Burger", children: [
                    .init(value: "💵 $1.00 back")
                ])
            ])
        ]
    }
}

@objc public class Node: NSObject {

    @objc let value: String
    @objc var children: [Node]

    @objc var childrenCount: String? {
        let count = children.count
        guard count > 0 else { return nil }
        return "\(count) node\(count > 1 ? "s" : "")"
    }

    @objc var count: Int {
        children.count
    }

    @objc var isLeaf: Bool {
        children.isEmpty
    }

    init(value: String, children: [Node] = []) {
        self.value = value
        self.children = children
    }
    
    class func node(from item: Any) -> Node? {
        if let treeNode = item as? NSTreeNode, let node = treeNode.representedObject as? Node {
            return node
        } else {
            return nil
        }
    }
}




//final class NodeFactory {
//    func nodes() -> [Node] {
//        return [
//            .init(type: .container, title: "Favorites", identifier: UUID().uuidString, children: [
//                .init(type: .document, title: "Child", identifier: UUID().uuidString)
//            ])
//
//        ]
//    }
//}
//
//enum NodeType: Int, Codable {
//    case container
//    case document
//    case separator
//    case unknown
//}
//
///// - Tag: NodeClass
//class Node: NSObject {
//    var type: NodeType
//    var title: String
//    var identifier: String
//    var url: URL?
//    @objc dynamic var children: [Node]
//
//    init(type: NodeType, title: String, identifier: String, children: [Node] = []) {
//        self.type = type
//        self.title = title
//        self.identifier = identifier
//        self.children = children
//    }
//
//}
//
//extension Node {
//
//    /** The tree controller calls this to determine if this node is a leaf node,
//        use it to determine if the node needs a disclosure triangle.
//     */
//    @objc var isLeaf: Bool {
//        //return type == .document || type == .separator
//        children.isEmpty
//    }
//
//    @objc var childrenCount: String? {
//        let count = children.count
//        guard count > 0 else { return nil }
//        return "\(count) node\(count > 1 ? "s" : "")"
//    }
//
//    @objc var count: Int {
//        children.count
//    }
//
//    var isURLNode: Bool {
//        return url != nil
//    }
//
//    var isSpecialGroup: Bool {
//        // A group node is a special node that represents either Pictures or Places as grouped sections.
//        return (!isURLNode &&
//            (title == FolderListViewController.NameConstants.pictures || title == FolderListViewController.NameConstants.favorites))
//    }
//
//    override class func description() -> String {
//        return "Node"
//    }
//
//    var nodeIcon: NSImage {
//        var icon = NSImage()
//        if let nodeURL = url {
//            // If the node has a URL, use it to obtain its icon.
//            icon = nodeURL.icon
//        } else {
//            // There's no URL for this node, so determine its icon generically.
//            if #available(macOS 11.0, *) {
//                let type = isDirectory ? UTType.folder : UTType.image
//                icon = NSWorkspace.shared.icon(for: type)
//            } else {
//                let osType = isDirectory ? kGenericFolderIcon : kGenericDocumentIcon
//                let iconType = NSFileTypeForHFSTypeCode(OSType(osType))
//                icon = NSWorkspace.shared.icon(forFileType: iconType!)
//            }
//        }
//        return icon
//    }
//
//    var canChange: Bool {
//        // You can only change (rename or add to) non-URL based directory nodes.
//        return isDirectory && url == nil
//    }
//
//    var canAddTo: Bool {
//        return isDirectory && canChange
//    }
//
//    var isSeparator: Bool {
//        return type == .separator
//    }
//
//    var isDirectory: Bool {
//        return type == .container
//    }
//
//}
//
//extension URL {
//
//    // Returns true if this URL is a file system container (packages aren't containers).
//    var isFolder: Bool {
//        var isFolder = false
//        if let resources = try? resourceValues(forKeys: [.isDirectoryKey, .isPackageKey]) {
//            let isURLDirectory = resources.isDirectory ?? false
//            let isPackage = resources.isPackage ?? false
//            isFolder = isURLDirectory && !isPackage
//        }
//        return isFolder
//    }
//
//    // Returns true if this URL points to an image file.
//    var isImage: Bool {
//        var isImage = false
//
//        if let typeIdentifierResource = try? resourceValues(forKeys: [.typeIdentifierKey]) {
//            guard let typeIdentifier = typeIdentifierResource.typeIdentifier else { return isImage }
//
//            if #available(macOS 11.0, *) {
//                if let utType = UTType(typeIdentifier) {
//                    if utType.conforms(to: UTType.image) {
//                        isImage = true // Done deducing it's an image file.
//                    }
//                }
//            } else {
//                if let imageTypes = CGImageSourceCopyTypeIdentifiers() as? [String] {
//                    for imageType in imageTypes {
//                        if UTTypeConformsTo(typeIdentifier as CFString, imageType as CFString) {
//                            isImage = true
//                            break // Done deducing it's an image file.
//                        }
//                    }
//                }
//            }
//        } else {
//            // Can't find the type identifier, so check further by extension.
//            let imageFormats = ["jpg", "jpeg", "png", "gif", "tiff"]
//            let ext = pathExtension
//            isImage = imageFormats.contains(ext)
//        }
//        return isImage
//    }
//
//    // Returns the type or UTI.
//    var fileType: String {
//        var fileType = ""
//        if let typeIdentifierResource = try? resourceValues(forKeys: [.typeIdentifierKey]) {
//            fileType = typeIdentifierResource.typeIdentifier!
//        }
//        return fileType
//    }
//
//    var isHidden: Bool {
//        let resource = try? resourceValues(forKeys: [.isHiddenKey])
//        return (resource?.isHidden)!
//    }
//
//    var icon: NSImage {
//        var icon: NSImage!
//        if let iconValues = try? resourceValues(forKeys: [.customIconKey, .effectiveIconKey]) {
//            if let customIcon = iconValues.customIcon {
//                icon = customIcon
//            } else if let effectiveIcon = iconValues.effectiveIcon as? NSImage {
//                icon = effectiveIcon
//            }
//        } else {
//            // Failed to not find the icon from the URL, so make a generic one.
//            if #available(macOS 11.0, *) {
//                let type = isFolder ? UTType.folder : UTType.image
//                icon = NSWorkspace.shared.icon(for: type)
//            } else {
//                let osType = isFolder ? kGenericFolderIcon : kGenericDocumentIcon
//                let iconType = NSFileTypeForHFSTypeCode(OSType(osType))
//                icon = NSWorkspace.shared.icon(forFileType: iconType!)
//            }
//        }
//        return icon
//    }
//
//    // Returns the human-visible localized name.
//    var localizedName: String {
//        var localizedName = ""
//        if let fileNameResource = try? resourceValues(forKeys: [.localizedNameKey]) {
//            localizedName = fileNameResource.localizedName!
//        } else {
//            // Failed to get the localized name, so use it's last path component as the name.
//            localizedName = lastPathComponent
//        }
//        return localizedName
//    }
//
//    var fileSizeString: String {
//        var fileSizeString = "-"
//        if let allocatedSizeResource = try? resourceValues(forKeys: [.totalFileAllocatedSizeKey]) {
//            if let allocatedSize = allocatedSizeResource.totalFileAllocatedSize {
//                let formattedNumberStr = ByteCountFormatter.string(fromByteCount: Int64(allocatedSize), countStyle: .file)
//                let fileSizeTitle = NSLocalizedString("on disk", comment: "")
//                fileSizeString = String(format: fileSizeTitle, formattedNumberStr)
//            }
//        }
//        return fileSizeString
//    }
//
//    var creationDate: Date? {
//        var creationDate: Date?
//           if let fileCreationDateResource = try? resourceValues(forKeys: [.creationDateKey]) {
//             creationDate = fileCreationDateResource.creationDate
//        }
//        return creationDate
//    }
//
//    var modificationDate: Date? {
//        var modificationDate: Date?
//        if let modDateResource = try? resourceValues(forKeys: [.contentModificationDateKey]) {
//            modificationDate = modDateResource.contentModificationDate
//        }
//        return modificationDate
//    }
//
//    // Returns the localized kind string.
//    var kind: String {
//        var kind = "-"
//        if let kindResource = try? resourceValues(forKeys: [.localizedTypeDescriptionKey]) {
//            kind = kindResource.localizedTypeDescription!
//        }
//        return kind
//    }
//
//}

