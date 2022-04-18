import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Booer_iOSTests.allTests),
    ]
}
#endif
