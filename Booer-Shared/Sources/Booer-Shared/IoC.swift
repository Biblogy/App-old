//
//  IoC.swift
//  
//
//  Created by Veit Progl on 23.05.21.
//

import Foundation
import Relay

final public class DefaultDependencyRegistry: DependencyRegistryType {
    public init(){}
    
    public func registerDependencies() throws {
        DependencyContainer.global.register(DateWorkerProtocol.self) { _ in DateWorker()}
    }
}
