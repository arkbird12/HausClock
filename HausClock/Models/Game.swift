//
//  Game.swift
//  HausClock
//
//  Created by Tom Brown on 11/28/14.
//  Copyright (c) 2014 not. All rights reserved.
//

import Foundation
import Dollar

enum GameState {
    case Active
    case Paused
    case Finished
}

class Game {
    var state = GameState.Paused
    let clockTickInterval:Double = 0.1 // This currently causes massive re-rendering. Should only update text as necessary
    
    init() {
        NSTimer.scheduledTimerWithTimeInterval(clockTickInterval, target: self, selector: Selector("onClockTick"), userInfo: nil, repeats: true)
        reset()
    }
    
    var players = [
        Player(position: .Top),
        Player(position: .Bottom)
    ]
    
    func reset() {
        for player in players {
            player.secondsRemaining.value = player.initialTimeInSeconds
        }

        setPlayerToActive(.Top)
        state = .Paused
    }
    
    func setPlayerToActive(position: PlayerPosition) {
        var activePlayer = getPlayerByPosition(position)
        var inactivePlayer = getPlayerByPosition(position.opposite())
        
        activePlayer.state.value = .Active
        inactivePlayer.state.value = .Waiting
        state = .Active
    }
    
    func getPlayerByPosition(position: PlayerPosition) -> Player {
        return $.find(players, { $0.position == position } )!
    }
    
    func getActivePlayer() -> Player? {
        return $.find(players, { $0.state.value == PlayerState.Active } )!
    }
    
    @objc func onClockTick() {
        switch state {
        case .Active:
            decrementActivePlayer()
        case .Finished:
            break
        case .Paused:
            break
        }
    }
    
    // Decrements the active player if one is available. If the player has lost, changes the player state
    func decrementActivePlayer() {
        if var activePlayer = getActivePlayer() {
            activePlayer.secondsRemaining.value -= clockTickInterval
            
            if activePlayer.secondsRemaining.value <= 0 {
                
state = .Finished
            }
        }
    }
}