//
//  AppDelegate.swift
//  SourceryRandom
//
//  Created by Петрічук Олег Аркадійовіч on 23.09.2018.
//  Copyright © 2018 Oleg Petrychuk. All rights reserved.
//

// extend you models with AutoRandom marker here (or in any other place if you want)

public protocol AutoRandom: AutoInit {}

extension Dog: AutoRandom {}
extension Toy: AutoRandom {}
