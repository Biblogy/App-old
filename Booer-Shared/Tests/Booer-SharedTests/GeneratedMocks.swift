@testable import Booer_Shared
// MARK: - Mocks generated from file: Booer-Shared/Sources/Booer-Shared/ViewModel/Protocols/BookModelProtocol.swift at 2022-04-18 16:45:33 +0000

//
//  BookModelProtocol.swift
//  EBookTracking (iOS)
//
//  Created by Veit Progl on 29.03.21.
//

import Cuckoo
@testable import Booer

import Foundation


public class MockBookModelProtocol: BookModelProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = BookModelProtocol
    
    public typealias Stubbing = __StubbingProxy_BookModelProtocol
    public typealias Verification = __VerificationProxy_BookModelProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: BookModelProtocol?

    public func enableDefaultImplementation(_ stub: BookModelProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func editItem()  {
        
    return cuckoo_manager.call("editItem()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.editItem())
        
    }
    
    
    
    public func updateItem(read: Float) -> Bool {
        
    return cuckoo_manager.call("updateItem(read: Float) -> Bool",
            parameters: (read),
            escapingParameters: (read),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.updateItem(read: read))
        
    }
    
    
    
    public func getChallenge()  {
        
    return cuckoo_manager.call("getChallenge()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getChallenge())
        
    }
    
    
    
    public func saveBook()  {
        
    return cuckoo_manager.call("saveBook()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveBook())
        
    }
    

	public struct __StubbingProxy_BookModelProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func editItem() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockBookModelProtocol.self, method: "editItem()", parameterMatchers: matchers))
	    }
	    
	    func updateItem<M1: Cuckoo.Matchable>(read: M1) -> Cuckoo.ProtocolStubFunction<(Float), Bool> where M1.MatchedType == Float {
	        let matchers: [Cuckoo.ParameterMatcher<(Float)>] = [wrap(matchable: read) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockBookModelProtocol.self, method: "updateItem(read: Float) -> Bool", parameterMatchers: matchers))
	    }
	    
	    func getChallenge() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockBookModelProtocol.self, method: "getChallenge()", parameterMatchers: matchers))
	    }
	    
	    func saveBook() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockBookModelProtocol.self, method: "saveBook()", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_BookModelProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func editItem() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("editItem()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func updateItem<M1: Cuckoo.Matchable>(read: M1) -> Cuckoo.__DoNotUse<(Float), Bool> where M1.MatchedType == Float {
	        let matchers: [Cuckoo.ParameterMatcher<(Float)>] = [wrap(matchable: read) { $0 }]
	        return cuckoo_manager.verify("updateItem(read: Float) -> Bool", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getChallenge() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getChallenge()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveBook() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("saveBook()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class BookModelProtocolStub: BookModelProtocol {
    

    

    
    public func editItem()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func updateItem(read: Float) -> Bool  {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
    public func getChallenge()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func saveBook()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: Booer-Shared/Sources/Booer-Shared/ViewModel/Protocols/CalcChallengeDaysProtocol.swift at 2022-04-18 16:45:33 +0000

//
//  CalcChallengeDaysProtocol.swift
//  iOS
//
//  Created by Veit Progl on 14.04.21.
//

import Cuckoo
@testable import Booer

import Foundation


public class MockCalcChallengeDaysProtocol: CalcChallengeDaysProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = CalcChallengeDaysProtocol
    
    public typealias Stubbing = __StubbingProxy_CalcChallengeDaysProtocol
    public typealias Verification = __VerificationProxy_CalcChallengeDaysProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: CalcChallengeDaysProtocol?

    public func enableDefaultImplementation(_ stub: CalcChallengeDaysProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func readDays(challenge: Challenges) -> Set<Date> {
        
    return cuckoo_manager.call("readDays(challenge: Challenges) -> Set<Date>",
            parameters: (challenge),
            escapingParameters: (challenge),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.readDays(challenge: challenge))
        
    }
    
    
    
    public func neededDays(challenge: Challenges) -> Set<Date> {
        
    return cuckoo_manager.call("neededDays(challenge: Challenges) -> Set<Date>",
            parameters: (challenge),
            escapingParameters: (challenge),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.neededDays(challenge: challenge))
        
    }
    

	public struct __StubbingProxy_CalcChallengeDaysProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func readDays<M1: Cuckoo.Matchable>(challenge: M1) -> Cuckoo.ProtocolStubFunction<(Challenges), Set<Date>> where M1.MatchedType == Challenges {
	        let matchers: [Cuckoo.ParameterMatcher<(Challenges)>] = [wrap(matchable: challenge) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCalcChallengeDaysProtocol.self, method: "readDays(challenge: Challenges) -> Set<Date>", parameterMatchers: matchers))
	    }
	    
	    func neededDays<M1: Cuckoo.Matchable>(challenge: M1) -> Cuckoo.ProtocolStubFunction<(Challenges), Set<Date>> where M1.MatchedType == Challenges {
	        let matchers: [Cuckoo.ParameterMatcher<(Challenges)>] = [wrap(matchable: challenge) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCalcChallengeDaysProtocol.self, method: "neededDays(challenge: Challenges) -> Set<Date>", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_CalcChallengeDaysProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func readDays<M1: Cuckoo.Matchable>(challenge: M1) -> Cuckoo.__DoNotUse<(Challenges), Set<Date>> where M1.MatchedType == Challenges {
	        let matchers: [Cuckoo.ParameterMatcher<(Challenges)>] = [wrap(matchable: challenge) { $0 }]
	        return cuckoo_manager.verify("readDays(challenge: Challenges) -> Set<Date>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func neededDays<M1: Cuckoo.Matchable>(challenge: M1) -> Cuckoo.__DoNotUse<(Challenges), Set<Date>> where M1.MatchedType == Challenges {
	        let matchers: [Cuckoo.ParameterMatcher<(Challenges)>] = [wrap(matchable: challenge) { $0 }]
	        return cuckoo_manager.verify("neededDays(challenge: Challenges) -> Set<Date>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class CalcChallengeDaysProtocolStub: CalcChallengeDaysProtocol {
    

    

    
    public func readDays(challenge: Challenges) -> Set<Date>  {
        return DefaultValueRegistry.defaultValue(for: (Set<Date>).self)
    }
    
    public func neededDays(challenge: Challenges) -> Set<Date>  {
        return DefaultValueRegistry.defaultValue(for: (Set<Date>).self)
    }
    
}


// MARK: - Mocks generated from file: Booer-Shared/Sources/Booer-Shared/ViewModel/Protocols/ChallengeModelProtocol.swift at 2022-04-18 16:45:33 +0000

//
//  ChallengeModelProtocol.swift
//  EBookTracking (iOS)
//
//  Created by Veit Progl on 29.03.21.
//

import Cuckoo
@testable import Booer

import Foundation


public class MockChallengeModelProtocol: ChallengeModelProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = ChallengeModelProtocol
    
    public typealias Stubbing = __StubbingProxy_ChallengeModelProtocol
    public typealias Verification = __VerificationProxy_ChallengeModelProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ChallengeModelProtocol?

    public func enableDefaultImplementation(_ stub: ChallengeModelProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func calcStreak()  {
        
    return cuckoo_manager.call("calcStreak()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.calcStreak())
        
    }
    
    
    
    public func setDone() -> Bool {
        
    return cuckoo_manager.call("setDone() -> Bool",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setDone())
        
    }
    
    
    
    public func saveItem()  {
        
    return cuckoo_manager.call("saveItem()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveItem())
        
    }
    
    
    
    public func getDays()  {
        
    return cuckoo_manager.call("getDays()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getDays())
        
    }
    

	public struct __StubbingProxy_ChallengeModelProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func calcStreak() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockChallengeModelProtocol.self, method: "calcStreak()", parameterMatchers: matchers))
	    }
	    
	    func setDone() -> Cuckoo.ProtocolStubFunction<(), Bool> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockChallengeModelProtocol.self, method: "setDone() -> Bool", parameterMatchers: matchers))
	    }
	    
	    func saveItem() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockChallengeModelProtocol.self, method: "saveItem()", parameterMatchers: matchers))
	    }
	    
	    func getDays() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockChallengeModelProtocol.self, method: "getDays()", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_ChallengeModelProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func calcStreak() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("calcStreak()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setDone() -> Cuckoo.__DoNotUse<(), Bool> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("setDone() -> Bool", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveItem() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("saveItem()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getDays() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getDays()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class ChallengeModelProtocolStub: ChallengeModelProtocol {
    

    

    
    public func calcStreak()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func setDone() -> Bool  {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
    public func saveItem()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func getDays()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}
