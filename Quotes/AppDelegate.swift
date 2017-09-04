//
//  AppDelegate.swift
//  Quotes
//
//  Created by Artem Novichkov on 28/12/2016.
//  Copyright © 2016 ArtemNovichkov. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let popover = NSPopover()
    var eventMonitor: EventMonitor?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = #imageLiteral(resourceName: "StatusBarButtonImage")
            button.action = #selector(togglePopover)
        }
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Print Quote", action: #selector(printQuote), keyEquivalent: "P"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit Quotes", action: #selector(terminate), keyEquivalent: "Q"))
        
//        statusItem.menu = menu
        
        popover.contentViewController = QuotesViewController(nibName: NSNib.Name(rawValue: "QuotesViewController"), bundle: nil)
        
        eventMonitor = EventMonitor(mask: NSEvent.EventTypeMask.leftMouseDown, handler: { [unowned self] event in
            if self.popover.isShown {
                self.closePopover()
            }
        })
        eventMonitor?.start()
    }
    
    //MARK: - Menu
    @objc func printQuote() {
        let quoteText = "Never put off until tomorrow what you can do the day after tomorrow."
        let quoteAuthor = "Mark Twain"
        
        print("\(quoteText) — \(quoteAuthor)")
    }
    
    @objc func terminate() {
        NSApplication.shared.terminate(nil)
    }
    
    //MARK: - Popover
    
    @objc func togglePopover() {
        if popover.isShown {
            closePopover()
        }
        else {
            showPopover()
        }
    }

    func showPopover() {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        }
        eventMonitor?.start()
    }
    
    func closePopover() {
        popover.performClose(nil)
        eventMonitor?.stop()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

