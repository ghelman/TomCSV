# TomCSV

![Image of Tom](tom.png)

Tom is a lightweight CSV (or other delimited file) parser in Swift.  Tom deals with CSV files so that you don't have to.  

What he does is, he goes upstairs where the customer's CSV file is, and he brings it downstairs to where your code is.  He's got people skills.



## Basic Use

    let customerCSVFile = <some string full of a csv file>
    let tomWithDefaultSettings = Tom()
      for row in tomWithDefaultSettings.parse(customerCSVFile){
        for e in row{
            print(e)
        }
    }


## Options

Tom let's you specify a couple of things:

* The Delimter character.  Defaults to the comma `,`.  (We all know that an awful lot of "CSV" files actually use tabs or pipes or something else awful to break up fields.)
* The Line Terminator.  Defaults to the newline `\n`.
* The quoting character.  Defaults to the regular square quote `"`.
* If individual elements should have leading and traling whitespace trimmed or not.  Defaults to yes.
* If lines with no elements should be left out of the final results.  Defaults to yes.


All these options are set in the single initializer.


## Some limitations and other notes

Delimiters, line terminators, and quoting symbols can only be a single Character.  Apologies to our comrades that have to deal with CRLF-terminiated files.

Tom will handle files with mixed quoted and non-quoted fields.

Quoting characters have to match; Tom can't handle curly quotes or brackets.

Tom hands everything out as strings, so any casting you're going to need to do yourself.

Tom assumes you've loaded your delimited data into a string before he gets there.  He's going to let you deal with security domains and timeout errors for that URI, thank you very much.

Tom does a single pass though the source string, so performance should be O(n).  However, it does do the entire thing in one go, and you're going to end up with the whole 2d array in memory.

Tom is immutable, and can be used to parse as many strings as you'd like.  He's, ahhh, probably thread safe?

## Dialect details

CSVs, of course, don't have a formal spec, but the closest we have is [RFC4180](https://www.rfc-editor.org/rfc/rfc4180.txt).

Specific things from RFC4180 that Tom won't handle correctly are headers and escaped quote marks inside a quoted field.


## Notice

Copyright 2020 Gabriel L. Helman

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

