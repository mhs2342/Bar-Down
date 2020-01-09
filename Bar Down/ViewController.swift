//
//  ViewController.swift
//  Bar Down
//
//  Created by Matthew Sanford on 12/25/19.
//  Copyright © 2019 sanch. All rights reserved.
//
import Bar_Down_Model
import Bar_Down_War_Room
import Cocoa

class ViewController: NSViewController {

    let connection = NSXPCConnection(serviceName: "com.sanch.Bar-Down-War-Room")


    override func viewDidLoad() {
        super.viewDidLoad()

        connection.remoteObjectInterface = NSXPCInterface(with: BDWarRoomProtocol.self)
        connection.resume()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func getScheduleClicked(_ sender: NSButton) {
        NSKeyedUnarchiver.setClass(BDMScheduledGames.self, forClassName: "Bar_Down.BDMScheduledGames")
        NSKeyedUnarchiver.setClass(BDMScheduledGame.self, forClassName: "Bar_Down.BDMScheduledGame")
        NSKeyedUnarchiver.setClass(BDMScheduledGameDate.self, forClassName: "Bar_Down.BDMScheduledGameDate")
        
        if let warRoom = connection.remoteObjectProxy as? BDWarRoomProtocol {
            warRoom.getSchedule(date: Date()) { (games, error) in
                if let games = games {
                    print("Success")
                }
            }
        }
    }

}

