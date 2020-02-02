import XCTest
@testable import TomCSV

final class TomCSVTests: XCTestCase {
    flet easy1 = """
        1,2,3,4
        a,b,c,d
        q,w,e,r
        """

        let easy2 = """
        1,  3,,  4
        a, b,c ,  d

        q  ,     w,     e   ,      r

        """

        let tricky1 = """
        1,2,"3",4
        a,"b",c,d
        "q","w","e",r


        """


        let tricky2 = """
        1,2,"3,,",4
        a,",b,",c,d
        "q","w","e",r


        """


        let goofball1 = """
        1|2
        |+3+|4>a|b|c|d>q|w

        |e|+r+

        """
        
        

        static var allTests = [
            ("testAll", testAll)
        ]
        
        
        ///Look. Sometimes you just want one big test
        func testAll() {
            //we want this
            let tomReader = Tom() //defaults

            let e1 = tomReader.parse(easy1)

            XCTAssertEqual(e1.count , 3)
            e1.forEach{assert($0.count == 4)}

            let e2 = tomReader.parse(easy2)
            
            XCTAssertEqual(e2.count , 3)
            e2.forEach{XCTAssertEqual($0.count , 4)}


            let t1 = tomReader.parse(tricky1)
            t1.forEach{XCTAssertEqual($0.count , 4)}

            let t2 = tomReader.parse(tricky2)
            t2.forEach{XCTAssertEqual($0.count , 4)}


            let tomGoofy = Tom(delimiter: "|", terminator: ">", quote: "+")
            let g1 = tomGoofy.parse(goofball1)
            g1.forEach{XCTAssertEqual($0.count , 4)}
            
            
            let looserTom = Tom(trimEdges: false, trimLines: false)
            let e22 = looserTom.parse(easy2)
            XCTAssertEqual(e22[0].count , 4)
            XCTAssertEqual(e22[1].count , 4)
            XCTAssertEqual(e22[2].count , 1)
            XCTAssertEqual(e22[3].count , 4)
            XCTAssertEqual(e22[4].count , 1)
            

        }
        
    }
