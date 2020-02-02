import Cocoa

///Tom is a lightweight CSV parser for Swift
public struct Tom : CustomStringConvertible{
    public var description: String {
        return "Tom[\(self.quote)\(self.delimiter)\(self.terminator)\(self.trimEdges)\(self.trimLines)]"
        
    }
    
    ///The character used to separate fields.
    let delimiter : Character
    
    ///The character that indicates the end of a line.
    let terminator : Character
    
    ///The character to use to mark the beginning and end of a value.  Delimiters and terminators that appear inside a pair of quotes will be ignored.
    let quote : Character
    
    ///If whitespace should be removed from the front and end of a value.
    let trimEdges : Bool
    
    ///If empty lines from the source should be ignored.
    let trimLines : Bool
    
    public init(delimiter: Character = ",", terminator: Character = "\n", quote: Character = "\"", trimEdges : Bool = true, trimLines : Bool = true) {
        
        self.delimiter = delimiter
        self.terminator = terminator
        self.quote = quote
        self.trimEdges = trimEdges
        self.trimLines = trimLines
    }


    ///Does the actual work of turning the source material into a 2d array of strings.
    public func parse(_ source: String) -> [[String]]{
        var result = [[String]]()

        //state for our parser state machine
        var currentRow = [String]()
        var insideQuotes = false
        var currentElement = ""
        
        ///Ends the current element
        func endElement(){
            if(self.trimEdges){
                currentElement = currentElement.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            currentRow.append(currentElement)
            //print("ELEMENTEND[\(currentElement)]")
            currentElement = ""
        }
        
        
        ///ends the current row; ending the current element if we need to
        func endRow(){
            endElement()
            if self.trimLines{
                //we want to not append things if the current row is only empty strings
                if currentRow.joined().count > 0{
                    result.append(currentRow)
                }
            } else {
            
                result.append(currentRow)
            }
            currentRow = [String]()
            currentElement = ""
            //print("EOL")
        }
        
        //walk down the string
        source.forEach{ c in
            //print("PARSE[\(c)]")
            if insideQuotes{
                //if we're inside a set of quotes, we just add things to the current element unless we hit another quote
                if c != self.quote{
                    currentElement.append(c)
                    //print("APPEND[\(c)]")
                } else {
                    //end element
                    insideQuotes = false
                    //print("QUOTEEND")
                }
            } else {
                switch c {
                case self.quote:
                    //print("QUOTESTART")
                    insideQuotes = true
                    
                case self.delimiter:
                    endElement()
                    
                case self.terminator:
                    //end of line
                    endRow()
 
                default:
                    currentElement.append(c)
                    //print("APPEND[\(c)]")
                }
                
            }
        }
        //end last row
        endRow()
        //print("EOF")
        return result
    }

}

