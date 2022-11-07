## Solution

`abi.encodePacked(string,string)` is being used in an unsafe way. 

That is to say, 
- `abi.encodePacked("ROOT", "ROOT")` (i)
- `abi.encodePacked("ROOTROOT", "")` (ii)
- `abi.encodePacked("", "ROOTROOT")` (iii)

will all return the same value. Notice, all three options will return the desired "ROOT" identifier. BUT, only `"", "ROOTROOT"` will also bypass the username restriction.  
