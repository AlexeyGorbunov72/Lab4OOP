//
//  Command.swift
//  VKClient
//
//  Created by Alexey on 01.12.2020.
//

import Foundation

class Command {
    func execute(){ fatalError("must be override Execute")}
    func undo(){ fatalError("must be override undo")}
}
