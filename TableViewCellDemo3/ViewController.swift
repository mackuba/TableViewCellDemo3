//
//  ViewController.swift
//  TableViewCellDemo3
//
//  Created by Kuba Suder on 04/02/2023.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet var tableView: NSTableView!

    let pics = ["IMG_1655", "IMG_1658", "IMG_1636", "IMG_1699", "IMG_1711", "IMG_1721"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.sizeLastColumnToFit()
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        return pics.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let cell = tableView.makeView(withIdentifier: TweetCell.identifier, owner: nil) {
            return cell
        } else {
            return TweetCell()
        }
    }

    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return pics[row]
    }
}

