//
//  CalcChallengeDaysProtocol.swift
//  iOS
//
//  Created by Veit Progl on 14.04.21.
//

import Foundation

public protocol CalcChallengeDaysProtocol {
    func readDays(challenge: Challenges) -> Set<Date>
    func neededDays(challenge: Challenges) -> Set<Date>
}
