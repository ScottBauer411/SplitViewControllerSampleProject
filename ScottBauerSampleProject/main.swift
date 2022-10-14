//
//  main.swift
//  ScottBauerSampleProject
//
//  Created by Scott Bauer on 10/14/22.
//

import AppKit

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
