import Foundation

// Algo Expert - Arrays

// Easy - (Q1-Q2)

// Question 1 - Two Number Sum

// Solution 1 - Brute force
// Time - O(n^2)
// Space - O(n)

func twoNumberSum(_ array: inout [Int], _ targetSum: Int) -> [Int] {
    for i in 0 ..< array.count - 1 {
        let firstNum = array[i]
        
        for j in i + 1 ..< array.count {
            let secondNum = array[j]
            
            if firstNum + secondNum == targetSum {
                return [firstNum, secondNum]
            }
        }
    }
    
    return []
}

// Notes:
// Here I'm using a nested for loop to try every possible combination of integer pairs in the array, checking each pair to see if they match the target sum.
// Note that for the first for loop I go from 0 to the second to last element, not the last element. This is because the first for loop should never reach the last element, as when it reaches the second to last element, the nested for loop will take care of the last element. Since we have the rule stated in the question that you cannot reach the target sum by adding an element to itself, we used the second to last element in this case.


// Solution 2 - Hash Table
// Time - O(n)
// Space - O(n)

func twoNumberSum2(_ array: inout [Int], _ targetSum: Int) -> [Int] {
    var numbersHashMap = [Int: Bool]()
    
    for number in array {
        let potentialMatch = targetSum - number
        
        if numbersHashMap[potentialMatch] == true {
            return [potentialMatch, number]
        } else {
            numbersHashMap[number] = true
        }
    }
    
    return []
}

// Notes:
// The way things work here is, we iterate through the array, and for every value we get to, we solve the equation targetSum - number, and we check if that value (potentialMatch) is in our hash table. If it is, we return potentialMatch and number, if it's not, we add that number to the numbersHashMap.
// Note that since our question specifies that all the integers in the array are unique, it is safe to assume that our hash table will never try to map two elements to the same location, and so checking if a value exists for a given key is an O(1) operation.

// WHY IS CHECKING IF A NUMBER EXISTS IN A HASH TABLE AN O(1) OPERATION? (STACK OVERFLOW)
// Well it's a little bit of a lie -- it can take longer than that, but it usually doesn't.
//
// Basically, a hash table is an array containing all of the keys to search on. The position of each key in the array is determined by the hash function, which can be any function which always maps the same input to the same output. We shall assume that the hash function is O(1).
//
// So when we insert something into the hash table, we use the hash function (let's call it h) to find the location where to put it, and put it there. Now we insert another thing, hashing and storing. And another. Each time we insert data, it takes O(1) time to insert it (since the hash function is O(1).
//
// Looking up data is the same. If we want to find a value, x, we have only to find out h(x), which tells us where x is located in the hash table. So we can look up any hash value in O(1) as well.
//
// Now to the lie: The above is a very nice theory with one problem: what if we insert data and there is already something in that position of the array? There is nothing which guarantees that the hash function won't produce the same output for two different inputs (unless you have a perfect hash function, but those are tricky to produce). Therefore, when we insert we need to take one of two strategies:
//
// Store multiple values at each spot in the array (say, each array slot has a linked list). Now when you do a lookup, it is still O(1) to arrive at the correct place in the array, but potentially a linear search down a (hopefully short) linked list. This is called "separate chaining".
// If you find something is already there, hash again and find another location. Repeat until you find an empty spot, and put it there. The lookup procedure can follow the same rules to find the data. Now it's still O(1) to get to the first location, but there is a potentially (hopefully short) linear search to bounce around the table till you find the data you are after. This is called "open addressing".
// Basically, both approaches are still mostly O(1) but with a hopefully-short linear sequence. We can assume for most purposes that it is O(1). If the hash table is getting too full, those linear searches can become longer and longer, and then it is time to "re-hash" which means to create a new hash table of a much bigger size and insert all the data back into it


// Solution 3 - Sorting (PREFERRED SOLUTION)
// Time - O(nlogn)
// Space - O(1)

func twoNumberSum3(_ array: inout [Int], _ targetSum: Int) -> [Int] {
    array.sort()
    
    var leftIndex = 0
    var rightIndex = array.count - 1
    
    while leftIndex < rightIndex {
        let leftMost = array[leftIndex]
        let rightMost = array[rightIndex]
        
        let currentSum = leftMost + rightMost
        
        if currentSum == targetSum {
            return [leftMost, rightMost]
        } else if currentSum < targetSum {
            leftIndex += 1
        } else if currentSum > targetSum {
            rightIndex -= 1
        }
    }
    
    return []
}

// Notes:
// In this solution, we start with two pointers, a leftIndex and a rightIndex. We start by summing the two pointers, and if the sum is greater than the target sum, we move the right pointer to the left, making the sum smaller, and vice versa.

// Question: When you call array.sort() in swift, what type of sort is swift doing under the hood?



// Question 2 - Validate SubSequence

// Solution 1 - While loop & indexs (PREFERRED SOLUTION)
// Time - O(n)
// Space - O(1)
func isValidSubsequence(_ array: [Int], _ sequence: [Int]) -> Bool {
    var arrayIndex = 0
    var sequenceIndex = 0
    
    while arrayIndex < array.count, sequenceIndex < sequence.count {
        if array[arrayIndex] == sequence[sequenceIndex] {
            sequenceIndex += 1
        }
        arrayIndex += 1
    }
    return sequenceIndex == sequence.count
}

// Notes:
// In this solution, we start with two indexes set at 0, arrayIndex any sequenceIndex. We then use a while loop on the condition that the indexes haven't reached the end of their arrays, checking at each point to see if the numbers at each index match. If they match, we can increment the sequence index.

// Solution 2
// Time - O(n)
// Space - O(1)
func isValidSubsequence2(_ array: [Int], _ sequence: [Int]) -> Bool {
    var seqIdx = 0
    
    for value in array {
        if seqIdx == sequence.count {
            break
        }
        if value == sequence[seqIdx] {
            seqIdx += 1
        }
    }
    return seqIdx == sequence.count
}

// --------------------------------------------------------------------------------------------------------------------------------

// Medium - (Q3-Q8)

// Question 3 - Three Number Sum

// Solution 1 - Brute Force (Not a solution on AlgoExpert)
// Time - O(n^3)
// TODO: Space - O(?)
func threeNumberSum(array: inout [Int], targetSum: Int) -> [[Int]] {
    var output = [[Int]]()
    array.sort()
    
    for i in 0 ..< array.count - 2 {
        for j in i + 1 ..< array.count - 1 {
            for k in j + 1 ..< array.count {
                if array[i] + array[j] + array[k] == targetSum {
                    output.append([array[i], array[j], array[k]])
                }
            }
        }
    }
    
    return output
}

// Notes:
// Since it's a requirement in this question that the triplets we return are sorted, I have put array.sort() at the beginning to solve that problem.

// Solution 2 - For loop & while loop (PREFERRED SOLUTION)
// Time - O(n^2)
// Space - O(n)
func threeNumberSum2(array: inout [Int], targetSum: Int) -> [[Int]] {
    array.sort()
    var output = [[Int]]()
    
    for i in 0 ..< array.count - 2 {
        let base = i
        var left = base + 1
        var right = array.count - 1
        
        while left < right {
            let currentSum = array[base] + array[left] + array[right]
            
            if currentSum == targetSum {
                output.append([array[base], array[left], array[right]])
                left = left + 1
                right = right - 1
            } else if array[base] + array[left] + array[right] < targetSum {
                left += 1
            } else if array[base] + array[left] + array[right] > targetSum {
                right -= 1
            }
        }
    }
    
    return output
}

// Notes:
// In this solution, I'm fixing a base pointera the beginning, then using a similar approach as in two number sum by using a left and a right pointer. Note that when we've found a solution, it's safe to both increment the left pointer and decrement the right pointer as only doing one would not result in a solution since all the values in the array are unique.



// Question 4 - Smallest Difference

// Solution 1 - Brute Force
// Time - O(n^2)
// Space - O(1)
func smallestDifference(arrayOne: inout [Int], arrayTwo: inout [Int]) -> [Int] {
    var smallest = Int.max
    var output = [Int]()
    
    for i in 0 ..< arrayOne.count {
        for j in 0 ..< arrayTwo.count {
            let difference = abs(arrayOne[i] - arrayTwo[j])
            if difference < smallest {
                smallest = difference
                output = []
                output.append(contentsOf: [arrayOne[i], arrayTwo[j]])
            }
        }
    }
    
    return output
}

// Solution 2 - Using pointers (PREFERRED SOLUTION)
// TODO: Time - O(?)
// Space - O(1)
func smallestDifference2(arrayOne: inout [Int], arrayTwo: inout [Int]) -> [Int] {
    arrayOne.sort()
    arrayTwo.sort()
    
    var indexOne = 0
    var indexTwo = 0
    
    var smallestDifference = Int.max
    var output = [Int]()
    
    while indexOne < arrayOne.count, indexTwo < arrayTwo.count {
        let firstNum = arrayOne[indexOne]
        let secondNum = arrayTwo[indexTwo]
        
        let current = firstNum - secondNum
        
        if abs(current) < smallestDifference {
            smallestDifference = abs(current)
            output = []
            output.append(contentsOf: [firstNum, secondNum])
        }
        
        if firstNum > secondNum {
            indexTwo += 1
        } else if firstNum < secondNum {
            indexOne += 1
        } else {
            return [firstNum, secondNum]
        }
    }
    
    return output
}



// Question 5 - Move Element To End

// Solution 1 - Swapping method (PREFERRED METHOD)
// Time - O(n)
// Space - O(1)
func moveElementToEnd(_ array: inout [Int], _ toMove: Int) -> [Int] {
    var leftIndex = 0
    var rightIndex = array.count - 1
    
    while leftIndex < rightIndex {
        while leftIndex < rightIndex, array[rightIndex] == toMove {
            rightIndex -= 1
        }
        
        if array[leftIndex] == toMove {
            (array[leftIndex], array[rightIndex]) = (array[rightIndex], array[leftIndex])
        }
        leftIndex += 1
    }
    
    return array
}

// Notes:
// This question taught me 2 things:
// 1) It can sometimes be necessary to use 2 while loops, where one while loop is a subset of the other (this surprised me).
// 2) The swapping technique with a left and right pointer

// Solution 2 - My original solution (way too over complicated)
// Time - O(n)
// TODO: Space - O(?)
func moveElementToEnd2(_ array: inout [Int], _ toMove: Int) -> [Int] {
    var counter = 0
    var toMoveIdxs = [Int]()
    
    if array.isEmpty {
        return []
    }
    
    for i in 0...array.count - 1 {
        if array[i] == toMove {
            toMoveIdxs.append(i)
        }
    }
    
    for i in 0...array.count - 1 {
        if toMoveIdxs.contains(i) {
            array.remove(at: i - counter)
            counter += 1
        }
    }
    
    if toMoveIdxs.isEmpty {
        return array
    } else {
        for _ in 0...toMoveIdxs.count - 1 {
            array.append(toMove)
        }
    }
    return array
}



// Question 6 - Monotonic Array

// Solution 1 - Use a temp array to store direction
// Time - O(n)
// Space - O(1)
func isMonotonic(array: [Int]) -> Bool {
    var temp = [String]()
    
    if array.count < 3 {
        return true
    }
    
    for i in 0 ..< array.count - 1 {
        let difference = array[i+1] - array[i]
        if difference > 0 {
            temp.append("+")
        } else if difference < 0 {
            temp.append("-")
        }
        
        if temp.contains("+") && temp.contains("-") {
            return false
        }
    }
    return true
}


// Solution 2 - Compare first and last to get a direction (PREFERRED SOLUTION)
// Time - O(n)
// Space - O(1)
func isMonotonic2(array: [Int]) -> Bool {
    if array.isEmpty || array.count == 1 {
        return true
    }
    
    let first = array[0]
    let last = array[array.count - 1]
    let direction = last - first
    
    if direction > 0 {
        for i in 0...array.count - 2 {
            if array[i+1] < array[i] {
                return false
            }
        }
    } else if direction < 0 {
        for i in 0...array.count - 2 {
            if array[i+1] > array[i] {
                return false
            }
        }
    } else if direction == 0 {
        for i in 0...array.count - 2 {
            if array[i+1] != array[i] {
                return false
            }
        }
    }
    return true
}



// Question 7 - Spiral Traverse (VERY COMMON INTERVIEW QUESTION)

// Solution 1 - Perimeter, broken  down by helper functions (NOT PASSING TESTS AS CURRENT SOLUTION DOESN'T HANDLE SINGLE ROW OR COLUMN EDGE CASES)
func spiralTraverse(array: [[Int]]) -> [Int] {
    var output = [Int]()
    var startRowIndex = 0
    var endColumnIndex = array[0].count - 1
    var endRowIndex = array.count - 1
    var startColumnIndex = 0
    
    while startRowIndex <= endRowIndex && startColumnIndex <= endColumnIndex {
        let startRow = createRow(array: array, start: startColumnIndex, end: endColumnIndex, row: startRowIndex)
        let endColumn = createColumn(array: array, start: startRowIndex, end: endRowIndex, column: endColumnIndex)
        var endRow = createRow(array: array, start: startColumnIndex, end: endColumnIndex, row: endRowIndex)
        var startColumn = createColumn(array: array, start: startRowIndex, end: endRowIndex, column: startColumnIndex)
        
        
        let perimeter = traversePerimeter(startRow: startRow, endColumn: endColumn, endRow: &endRow, startColumn: &startColumn)
        output.append(contentsOf: perimeter)
        
        startRowIndex += 1
        endColumnIndex -= 1
        endRowIndex -= 1
        startColumnIndex += 1
    }
    
    return output
}

func createRow(array: [[Int]], start: Int, end: Int, row: Int) -> [Int] {
    var startRow = [Int]()
    
    for i in start ... end {
        startRow.append(array[row][i])
    }
    
    return startRow
}

func createColumn(array: [[Int]], start: Int, end: Int, column: Int) -> [Int] {
    var endColumn = [Int]()
    
    for i in start ... end {
        endColumn.append(array[i][column])
    }
    
    return endColumn
}

func traversePerimeter(startRow: [Int], endColumn: [Int], endRow: inout [Int], startColumn: inout [Int]) -> [Int] {
    var output = [Int]()
    
    if startRow.count == 1 {
        return startRow
    } else if startColumn.count == 1 {
        return startColumn
    }
    
    for i in 0 ..< startRow.count {
        output.append(startRow[i])
    }
    
    for i in 1 ..< endColumn.count {
        output.append(endColumn[i])
    }
    
    endRow.reverse()
    for i in 1 ..< endRow.count {
        output.append(endRow[i])
    }
    
    startColumn.reverse()
    for i in 1 ..< startColumn.count - 1 {
        output.append(startColumn[i])
    }
    
    return output
}


// Solution 2 - Perimeter approach, Iterative solution
// Time - O(n)
// Space - O(n)

func spiralTraverse4(array: [[Int]]) -> [Int] {
    // Indexes
    var startRow = 0
    var endRow = array.count - 1
    var startCol = 0
    var endCol = array[0].count - 1
    
    var output = [Int]()
    
    while startRow <= endRow, startCol <= endCol {
        
        // Sweep left to right
        for col in stride(from: startCol, through: endCol, by: 1) {
            output.append(array[startRow][col])
        }
        
        // Sweep top to bottom
        for row in stride(from: startRow + 1, through: endRow, by: 1) {
            output.append(array[row][endCol])
        }
        
        // Sweep right to left
        for col in stride(from: endCol - 1, through: startCol, by: -1) {
            // We need to check if startRow == endRow, because if it does, we have already counted this row in the left to right sweep.
            if startRow == endRow {
                break
            }
            
            output.append(array[endRow][col])
        }
        
        // Sweep bottom to top
        for row in stride(from: endRow - 1, through: startRow + 1, by: -1) {
            // We need to check if startCol == endCol, because if it does, we have already counted this column in the top to bottom sweep.
            if startCol == endCol {
                break
            }
            
            output.append(array[row][startCol])
        }
        
        startRow += 1
        endRow -= 1
        startCol += 1
        endCol -= 1
    }
    
    return output
}

// Note:
// This solution uses a lot less code than solution 1, and the good thing about this solution is that unlike solution 1 which uses a traversePerimeter function that takes in a set of input arrays, this uses indexes to handle the edge cases (if startRow = endRow break)


// Solution 3 - Perimeter approach, recursive solution
// Time - O(n)
// Space - O(n)
func spiralTraverse3(array: [[Int]]) -> [Int] {
    var output = [Int]()
    spiralFill(array, 0, array.count - 1, 0, array[0].count - 1, &output)
    return output
}

func spiralFill(_ array: [[Int]], _ startRow: Int, _ endRow: Int, _ startCol: Int, _ endCol: Int, _ output: inout [Int]) {
    if startRow > endRow || startCol > endCol {
        return
    }
    
    for col in stride(from: startCol, through: endCol, by: 1) {
        output.append(array[startRow][col])
    }
    
    for row in stride(from: startRow + 1, through: endRow, by: 1) {
        output.append(array[row][endCol])
    }
    
    for col in stride(from: endCol - 1, through: startCol, by: -1) {
        if startRow == endRow {
            break
        }
        output.append(array[endRow][col])
    }
    
    for row in stride(from: endRow - 1, through: startRow + 1, by: -1) {
        if startCol == endCol {
            break
        }
        output.append(array[row][startCol])
    }
    
    spiralFill(array, startRow + 1, endRow - 1, startCol + 1, endCol - 1, &output)
}



// Question 8 - Longest Peak

// Solution 1 - Find potential peaks by comparing the left and right, then iterate through the potential peaks and count the left & right sides.
// Time - O(n)
// Space - O(n)
func longestPeak(array: [Int]) -> Int {
    var longestPeak = 0
    var potentialPeaks = [Int]()
    
    if array.count < 3 {
        return 0
    }
    
    for i in 1 ..< array.count - 1 {
        if array[i] > array[i-1] && array[i] > array[i+1] {
            potentialPeaks.append(i)
        }
    }

    for i in 0 ..< potentialPeaks.count {
        var leftSide = 0
        var j = potentialPeaks[i]
        while j-1 >= 0, array[j-1] < array[j] {
            leftSide += 1
            j -= 1
        }

        var rightSide = 0
        var k = potentialPeaks[i]
        while k+1 <= array.count - 1, array[k+1] < array[k] {
            rightSide += 1
            k += 1
        }
        
        let sum = leftSide + rightSide + 1
        if sum > longestPeak {
            longestPeak = sum
        }
    }
    
    return longestPeak
}

// Notes: Solution 2 is better than solution 1 here because the memory complexity of solution 1 is worst case O(n). Solution 2 solves this memory problem by not storing potential peaks in an array and iterating through the array and only counting the left and right sides if the point in the array is a potential peak.

// Solution 2 - AlgoExpert Solution
// Time - O(n)
// Space - O(1)
func longestPeak2(array: [Int]) -> Int {
    var longestPeak = 0
    var potentialPeaks = [Int]()
    
    if array.count < 3 {
        return 0
    }
    
    for i in 1 ..< array.count - 1 {
        if array[i] > array[i-1] && array[i] > array[i+1] {
            potentialPeaks.append(i)
        }
    }

    for i in 0 ..< potentialPeaks.count {
        // count the left
        var leftSide = 0
        var j = potentialPeaks[i]
        while j-1 >= 0, array[j-1] < array[j] {
            leftSide += 1
            j -= 1
        }
        
        // count the right
        var rightSide = 0
        var k = potentialPeaks[i]
        while k+1 <= array.count - 1, array[k+1] < array[k] {
            rightSide += 1
            k += 1
        }
        
        // sum
        let sum = leftSide + rightSide + 1
        if sum > longestPeak {
            longestPeak = sum
        }
    }
    
    return longestPeak
}

// --------------------------------------------------------------------------------------------------------------------------------

// Hard - (Q9-Q13)
// Question 9 - Four Number Sum

// Solution 1 - Brute force
// Time - O(n^4)
// Space - O(n)
func fourNumberSum(array: [Int], targetSum: Int) -> [[Int]] {
    var output = [[Int]]()
    let myArray = array.sorted()
    
    for i in 0 ..< myArray.count - 3 {
        for j in i+1 ..< myArray.count - 2 {
            for k in j+1 ..< myArray.count - 1 {
                for l in k+1 ..< myArray.count {
                    if myArray[i] + myArray[j] + myArray[k] + myArray[l] == targetSum {
                        output.append([myArray[i], myArray[j], myArray[k], myArray[l]])
                    }
                }
            }
        }
    }
    
    return output
}

// Solution 2 - Using Pointers
// Time - O(n^3)
// TODO: Space - O(?)
func fourNumberSum2(array: [Int], targetSum: Int) -> [[Int]] {
    var output = [[Int]]()
    let myArray = array.sorted()
    
    for i in 0 ..< myArray.count - 3 {
        for j in i+1 ..< myArray.count - 2 {
            
            let firstBase = myArray[i]
            let secondBase = myArray[j]
            
            var leftPointer = j+1
            var rightPointer = myArray.count - 1
            
            while leftPointer < rightPointer {
                let leftValue = myArray[leftPointer]
                let rightValue = myArray[rightPointer]
                let sum = firstBase + secondBase + leftValue + rightValue
                
                if sum < targetSum {
                    leftPointer += 1
                } else if sum > targetSum {
                    rightPointer -= 1
                } else {
                    output.append([firstBase, secondBase, leftValue, rightValue])
                    leftPointer += 1
                }
            }
        }
    }
    
    return output
}

// Solution 3 - AlgoExpert Solution, finding pairs + hash table (PREFERRED SOLUTION, HOWEVER NOT SIMPLEST)
// Time - O(n^2)
// Space - O(n^2)
func fourNumberSum3(array: [Int], targetSum: Int) -> [[Int]] {
    var output = [[Int]]()
    var hashTable = [Int: [[Int]]]()
    
    for i in 1 ..< array.count - 1 {
        
        for j in i+1 ..< array.count {
            let current = array[i] + array[j]
            let diff = targetSum - current
            
            if let matchingPairs = hashTable[diff] {
                for pair in matchingPairs {
                    var newEntry = [Int]()
                    newEntry.append(contentsOf: [pair[0], pair[1], array[i], array[j]])
                    output.append(newEntry)
                }
            }
        }
        
        // Adding pairs (before current) to hash table
        var beforeCounter = 0
        while beforeCounter < i {
            let sum = array[beforeCounter] + array[i]
            if hashTable[sum] == nil {
                hashTable[sum] = [[array[beforeCounter], array[i]]]
            } else {
                hashTable[sum]?.append([array[beforeCounter], array[i]])
            }
            beforeCounter += 1
        }
    }
    
    return output
}

// Note:
// The key to this solution is the fact that we only add key-value pairs to the hashtable for pairs to the left of the current index in the array. This is to avoid duplicate solutions. Note also the hash table logic is at the end of the for i in loop, not at the start.



// Question 10 - Subarray Sort

// Solution 1 - Swapping method
// Time - O(n)
// Space - O(n) Note: This can and should be optimized.
func subarraySort(array: [Int]) -> [Int] {
    
    var outOfPlaceIndex = [Int]()
    var largestValue = 0
    var newArray = array
    var minIndex = Int.max
    var maxIndex = Int.max
    
    for i in 0 ..< array.count - 1 {
        
        if array[i] > largestValue {
            largestValue = array[i]
        }
        
        if array[i+1] < largestValue {
            outOfPlaceIndex.append(i+1)
        }
    }
    
    if outOfPlaceIndex.isEmpty {
        return [-1,-1]
    } else {
        maxIndex = outOfPlaceIndex.max()!
    }
    
    for i in outOfPlaceIndex {
        var j = i
        while j-1 >= 0, newArray[j] < newArray[j-1]{
            (newArray[j-1], newArray[j]) = (newArray[j], newArray[j-1])
            if j-1 < minIndex {
                minIndex = j-1
            }
            j -= 1
        }
    }
    
    return [minIndex, maxIndex]
}

subarraySort(array: [1, 2, 4, 7, 10, 11, 7, 12, 6, 7, 16, 18, 19])



// Question 11 - Largest Range

// Solution 1 - Hash table
// Time - O(n)
// Space - O(n)
func largestRange(array: [Int]) -> [Int] {
    var hashtable = [Int: Bool]()
    var longestRange = 0
    var output = [Int]()
    
    // create hashtable
    for i in 0 ..< array.count {
        hashtable[array[i]] = false
    }
    
    for i in 0 ..< array.count {
        // if we've already visited this element, don't repeat
        if hashtable[array[i]] == true {
            break
        }
        
        // check the left range
        var leftArray = [Int]()
        var j = 1
        while hashtable[array[i]-j] != nil {
            leftArray.append(array[i]-j)
            hashtable[array[i]-j] = true
            j += 1
        }
        
        // check the right range
        var rightArray = [Int]()
        var k = 1
        while hashtable[array[i]+k] != nil {
            rightArray.append(array[i]+k)
            hashtable[array[i]+k] = true
            k += 1
        }
        
        // update the longest range
        let completeArray : [Int] = leftArray.reversed() + [array[i]] + rightArray
        let totalRange = completeArray.count
        let lowerBound = completeArray.min()!
        let upperBound = completeArray.max()!
        
        if totalRange > longestRange {
            longestRange = totalRange
            output = [lowerBound, upperBound]
        }
    }
    
    return output
}



// Question 12 - Min Awards

// My First Attempt
// Time - O(n)
// Space - O(n)
func minRewards(_ scores: [Int]) -> Int {
    var rewardsArray = convertArrayToZeros(array: scores)
    let minimumIndexes = findMinimumIndexes(array: scores)
    var outputArray = setMinimumsToOne(zerosArray: &rewardsArray, minimums: minimumIndexes)

    for localMinIndex in minimumIndexes {
        expandFromLocalMinIndex(scoresArray: scores, outputArray: &outputArray, localMinIndex: localMinIndex)
    }
    return sumRewardsArray(rewardsArray: outputArray)
}

func convertArrayToZeros(array: [Int]) -> [Int] {
    var output: [Int] = []
    for _ in 0 ..< array.count {
        output.append(0)
    }
    return output
}

func findMinimumIndexes(array: [Int]) -> [Int] {
    // Handling case for array size 1
    if array.count == 1 {
        return [0]
    }

    var minimumIndexes: [Int] = []

    if array[0] < array[1] {
        minimumIndexes.append(0)
    }

    for i in 1 ..< array.count - 1 {
        if array[i] < array[i-1] && array[i] < array[i+1] {
            minimumIndexes.append(i)
        }
    }

    if array[array.count - 1] < array[array.count - 2] {
        minimumIndexes.append(array.count - 1)
    }

    return minimumIndexes
}

func setMinimumsToOne(zerosArray: inout [Int], minimums: [Int]) -> [Int] {
    for i in 0 ..< minimums.count {
        zerosArray[minimums[i]] = 1
    }

    return zerosArray
}

func expandFromLocalMinIndex(scoresArray: [Int], outputArray: inout [Int], localMinIndex: Int) {

    // Left expansion
    var leftIndex = localMinIndex - 1

    while leftIndex >= 0, scoresArray[leftIndex] > scoresArray[leftIndex + 1] {
        outputArray[leftIndex] = max(outputArray[leftIndex], outputArray[leftIndex + 1] + 1)
        leftIndex -= 1
    }

    // Right expansion
    var rightIndex = localMinIndex + 1

    while rightIndex < scoresArray.count, scoresArray[rightIndex] > scoresArray[rightIndex - 1] {
        outputArray[rightIndex] = max(outputArray[rightIndex], outputArray[rightIndex - 1] + 1)
        rightIndex += 1
    }
}

func sumRewardsArray(rewardsArray: [Int]) -> Int {
    var sum = 0
    for i in 0 ..< rewardsArray.count {
        sum += rewardsArray[i]
    }

    return sum
}


// Solution 1 - Naive solution
// Time - O(n^2)
// Space - O(n)

func minRewards2(_ scores: [Int]) -> Int {
    var rewards = Array(repeating: 1, count: scores.count)

    for i in 1 ..< scores.count {
        var j = i - 1

        if scores[i] > scores[j] {
            rewards[i] = rewards[j] + 1
        } else {
            while j >= 0, scores[j] > scores[j+1] {
                rewards[j] = max(rewards[j], rewards[j + 1] + 1)
                j -= 1
            }
        }
    }
    return rewards.reduce(0) { $0 + $1 }
}

// Solution 2 - Optimal solution
// Time - O(n)
// Space - O(n)

func minRewards3(_ scores: [Int]) -> Int {
    var rewards = Array(repeating: 1, count: scores.count)

    for i in stride(from: 1, to: scores.count, by: 1) {
        if scores[i] > scores[i - 1] {
            rewards[i] = rewards[i - 1] + 1
        }
    }

    for i in stride(from: scores.count - 2, to: 0, by: -1) {
        if scores[i] > scores[i + 1] {
            rewards[i] = max(rewards[i], rewards[i + 1] + 1)
        }
    }

    return rewards.reduce(0) { $0 + $1 }
}


// Explanation:
// Iterating from left to right, then right to left, comparing the value that comes before them (after them when iterating right to left)

// Question 13 - Zigzag Traverse

// Solution 1 - Failed initial attempt. My initial observation was that there were 4 unique direction; down, left, up-right and down-left. My approach was to come up with a set of logic to determine when each arrow should be used. This ended up being over-complicated and resulted in a long answer. I probably could've got this solution to work with some more effort but I ended up giving up on it to pursue a more elegant solution.
enum CurrentDirection: Equatable {
    case right
    case down
    case upRight
    case downLeft
}

func zigZagTraverse(array: [[Int]]) -> [Int] {

    // Helper variables
    var currentRow = 0
    var currentCol = 0
    let endRow = array.count - 1
    let endCol = array[0].count - 1
    var currentPosition = (currentRow, currentCol)
    let endPosition = (array.count, array[0].count)

    // Initialize the current direction to be .down as that's how all arrays start
    var currentDirection: CurrentDirection = .down

    // Initialize zigzagOutput with first element of the array
    var zigzagOutput = [array[0][0]]

    while currentPosition != endPosition {

        // Handling the start of the zig zag
        if currentPosition == (0,0) {
            zigzagOutput.append(goDown(array: array, currentPosition: currentPosition))
            currentRow += 1
            currentPosition = (currentRow, currentCol)
        }

        // Handling the upright
        if (currentCol == 0 || currentRow == endRow) && (currentDirection == .down || currentDirection == .right) {
            while currentRow != 0 || currentCol != endCol {
                zigzagOutput.append(goUpRight(array: array, currentPosition: currentPosition))
                currentDirection = .upRight
                currentRow += 1
                currentCol += 1
                currentPosition = (currentRow, currentCol)
            }
        }

        // Handling the downLeft
        if (currentRow == 0 || currentCol == endCol) && (currentDirection == .down || currentDirection == .right) {
            while currentRow != 0 || currentCol != endCol {
                zigzagOutput.append(goDownLeft(array: array, currentPosition: currentPosition))
                currentDirection = .downLeft
                currentRow += 1
                currentCol -= 1
                currentPosition = (currentRow, currentCol)
            }
        }

        // Handling the down
        if (currentCol == 0 || currentCol == endCol) && (currentDirection == .downLeft || currentDirection == .upRight) {
            zigzagOutput.append(goDown(array: array, currentPosition: currentPosition))
            currentDirection = .down
            currentRow += 1
            currentPosition = (currentRow, currentCol)
        }

        // Handling the right
        if (currentRow == 0 || currentRow == endRow) && (currentDirection == .downLeft || currentDirection == .upRight) {
            zigzagOutput.append(goRight(array: array, currentPosition: currentPosition))
            currentDirection = .right
            currentCol += 1
            currentPosition = (currentRow, currentCol)
        }
    }

    return zigzagOutput
}

// Helper functions
func goDown(array: [[Int]], currentPosition: (Int, Int)) -> Int {
    return array[currentPosition.0 + 1][currentPosition.1]
}

func goRight(array: [[Int]], currentPosition: (Int, Int)) -> Int {
    return array[currentPosition.0][currentPosition.1 + 1]
}

func goUpRight(array: [[Int]], currentPosition: (Int, Int)) -> Int {
    return array[currentPosition.0 - 1][currentPosition.1 + 1]
}

func goDownLeft(array: [[Int]], currentPosition: (Int, Int)) -> Int {
    return array[currentPosition.0 + 1][currentPosition.1 - 1]
}


// Solution 2 - My working solution. The crux of my answer revolves around seeing the zigzag as diagonal arrows starting with a down arrow for the first element. Once you calculate how many arrows are required to traverse the whole array, your main logic revolves around figuring out the starting point for the arrow. You know that for down arrows you will either be on the first row or the end column, and for the up arrows you will either be on the first col or end row. The main logic in determining where the starting point should be revolves around determining which row/col the arrow will start on. Once you have that logic, the rest of the solution is pretty straight forward.
// Time - O(n)
// Space - O(n)
func zigZagTraverse2(array: [[Int]]) -> [Int] {
    var output = [Int]()
    let numberOfDiagonalTraversalsNeed = array.count + array[0].count - 1
    let numberOfRows = array.count
    let numberOfColumns = array[0].count
    let endRow = array.count - 1
    let endCol = array[0].count - 1

    for i in 0 ..< numberOfDiagonalTraversalsNeed {
        print(output)

        if i % 2 == 0  {
            // Going down
            var startingPoint = (0,0)
            if i > endCol {
                startingPoint = (i - numberOfColumns + 1, endCol)
            } else {
                startingPoint = (0, i)
            }
            var currentPoint = startingPoint

            while (currentPoint.0 >= 0 && currentPoint.0 < numberOfRows) && (currentPoint.1 >= 0 && currentPoint.1 < numberOfColumns) {
                output.append(array[currentPoint.0][currentPoint.1])
                currentPoint = (currentPoint.0 + 1, currentPoint.1 - 1)
            }

        } else if i % 2 == 1 {
            // Going up
            var startingPoint = (0,0)
            if i > endRow {
                startingPoint = (endRow, i - numberOfRows + 1)
            } else {
                startingPoint = (i, 0)
            }
            var currentPoint = startingPoint

            while (currentPoint.0 >= 0 && currentPoint.0 < numberOfRows) && (currentPoint.1 >= 0 && currentPoint.1 < numberOfColumns) {
                output.append(array[currentPoint.0][currentPoint.1])
                currentPoint = (currentPoint.0 - 1, currentPoint.1 + 1)
            }
        }
    }

    return output
}


// Solution 3 (AlgoExpert solution with my added optimizations) I prefer my solution because it effectively only has 2 directions, the up-right diagonal and the down-left diagonal, making it much easier to visualize.
// Time - O(n)
// Space - O(n)
func zigZagTraverse3(array: [[Int]]) -> [Int] {
    var output = [Int]()

    var goingDown = true
    var currentRow = 0
    var currentCol = 0

    let startRow = 0
    let startCol = 0

    let endRow = array.count - 1
    let endCol = array[0].count - 1

    while currentRow <= endRow && currentCol <= endCol {
        output.append(array[currentRow][currentCol])

        if goingDown == true {
            if currentCol == startCol || currentRow == endRow {
                if currentRow == endRow {
                    // Go Right
                    currentCol += 1
                } else {
                    // Go Down
                    currentRow += 1
                }
                goingDown = false
            } else {
                // Go down-left
                currentRow += 1
                currentCol -= 1
            }
        } else {
            if currentRow == startRow || currentCol == endCol {
                if currentCol == endCol {
                    // Go Down
                    currentRow += 1
                } else {
                    // Go Right
                    currentCol += 1
                }
                goingDown = true
            } else {
                // Go up-right
                currentRow -= 1
                currentCol += 1
            }
        }
    }

    return output
}

// --------------------------------------------------------------------------------------------------------------------------------

// Very Hard - (Q14-Q15)
// Question 14 - Apartment Hunting

// Solution 1 - AlgoExpert solution
// Time - O(B^2 * R)
// Space - O(B)
// Where B - Blocks, R - Requirements

func apartmentHunting(_ blocks: [[String: Bool]], _ requirements: [String]) -> Int {
    var maxDistancesAtBlocks = Array(repeating: -Int.max, count: blocks.count)

    for i in 0 ..< blocks.count {
        for requirement in requirements {
            var closestReqDistance = Int.max

            for j in 0 ..< blocks.count {
                if let requirementAvailable = blocks[j][requirement], requirementAvailable {
                    closestReqDistance = min(closestReqDistance, distanceBetween(i, j))
                }
            }

            maxDistancesAtBlocks[i] = max(maxDistancesAtBlocks[i], closestReqDistance)
        }
    }

    return getIndexAtMinValue(maxDistancesAtBlocks)
}

func getIndexAtMinValue(_ array: [Int]) -> Int {
    var indexAtMinValue = 0
    var minValue = Int.max

    for i in 0 ..< array.count {
        let currentValue = array[i]

        if currentValue < minValue {
            minValue = currentValue
            indexAtMinValue = i
        }
    }

    return indexAtMinValue
}

func distanceBetween(_ a: Int, _ b: Int) -> Int {
    return abs(a - b)
}


// Solution 2 - AlgoExpert Solution
// Time - O(BR)
// Space - O(BR)
// Notes: I would hesitate to say which out of the 2 solutions for this question is better since there is a trade off in terms of time and space complexity.

func apartmentHunting2(_ blocks: [[String: Bool]], _ requirements: [String]) -> Int {
    let minDistancesFromBlocks = requirements.map { getMinDistances(blocks, $0) }
    let maxDistancesAtBlocks = getMaxDistancesAtBlocks(blocks, minDistancesFromBlocks)

    return getIndexAtMinValue2(maxDistancesAtBlocks)
}

func getMinDistances(_ blocks: [[String: Bool]], _ requirement: String) -> [Int] {
    var minDistances = Array(repeating: -1, count: blocks.count)
    var closestRequirementIndex = Int.max

    for i in 0 ..< blocks.count {
        if let requirementAvailable = blocks[i][requirement], requirementAvailable {
            closestRequirementIndex = i
        }

        minDistances[i] = distanceBetween(i, closestRequirementIndex)
    }

    for i in (0 ..< blocks.count).reversed() {
        if let requirementAvailable = blocks[i][requirement], requirementAvailable {
            closestRequirementIndex = i
        }

        minDistances[i] = min(minDistances[i], distanceBetween2(i, closestRequirementIndex))
    }

    return minDistances
}

func getMaxDistancesAtBlocks(_ blocks: [[String: Bool]], _ minDistancesFromBlocks: [[Int]]) -> [Int] {
    var maxDistancesAtBlocks = Array(repeating: -1, count: blocks.count)

    for i in 0 ..< blocks.count {
        let minDistancesAtBlock = minDistancesFromBlocks.map { $0[i] }

        if let max = minDistancesAtBlock.max() {
            maxDistancesAtBlocks[i] = max
        }
    }

    return maxDistancesAtBlocks
}

func getIndexAtMinValue2(_ array: [Int]) -> Int {
    var indexAtMinValue = 0
    var minValue = Int.max

    for i in 0 ..< array.count {
        let currentValue = array[i]

        if currentValue < minValue {
            minValue = currentValue
            indexAtMinValue = i
        }
    }

    return indexAtMinValue
}

func distanceBetween2(_ a: Int, _ b: Int) -> Int {
    return abs(a - b)
}


// Question 15 - Calendar Matching

// Solution 1 - AlgoExpert Solution
// Time - O(c1 + c2)
// Space - O(c1 + c2)

func calendarMatching(_ calendar1: [[String]], _ dailyBounds1: [String], _ calendar2: [[String]], _ dailyBounds2: [String], _ meetingDuration: Int) -> [[String]] {

    let updatedCalendar1 = updateCalendar(calendar1, dailyBounds1)
    let updatedCalendar2 = updateCalendar(calendar2, dailyBounds2)

    let mergedCalendar = mergeCalendars(updatedCalendar1, updatedCalendar2)
    let flattenedCalendar = flattenCalendar(mergedCalendar)

    return getMatchingAvailabilities(flattenedCalendar, meetingDuration)
}

func updateCalendar(_ calendar: [[String]], _ dailyBounds: [String]) -> [[Int]] {
    let lowerBound = ["0:00", dailyBounds[0]]
    let upperBound = [dailyBounds[1], "23:59"]
    var updatedCalendar = [[String]]()

    updatedCalendar.append(lowerBound)
    updatedCalendar.append(contentsOf: calendar)
    updatedCalendar.append(upperBound)

    return updatedCalendar.map { $0.map { timeToMinutes($0) } }
}

func timeToMinutes(_ string: String) -> Int {
    let separatedComponents = string.split(separator: ":").map { Int($0) }

    if let hours = separatedComponents[0], let minutes = separatedComponents[1] {
        return (hours * 60) + minutes
    }

    return 0
}

func mergeCalendars(_ calendar1: [[Int]], _ calendar2: [[Int]]) -> [[Int]] {
    var i = 0
    var j = 0

    var merged = [[Int]]()

    while i < calendar1.count, j < calendar2.count {
        let meeting1 = calendar1[i]
        let meeting2 = calendar2[j]

        if meeting1[0] < meeting2[0] {
            merged.append(meeting1)
            i += 1
        } else {
            merged.append(meeting2)
            j += 1
        }
    }

    while i < calendar1.count {
        merged.append(calendar1[i])
        i += 1
    }

    while j < calendar2.count {
        merged.append(calendar2[j])
        j += 1
    }

    return merged
}

func flattenCalendar(_ calendar: [[Int]]) -> [[Int]] {
    let firstEntry = calendar[0]
    var flattened = [[Int]]()
    flattened.append(firstEntry)

    for currentMeeting in calendar {
        if let previousMeeting = flattened.last, let currentStart = currentMeeting.first, let currentEnd = currentMeeting.last, let previousStart = previousMeeting.first, let previousEnd = previousMeeting.last {
            if previousEnd >= currentStart {
                let newPreviousMeeting = [previousStart, max(previousEnd, currentEnd)]
                flattened[flattened.count - 1] = newPreviousMeeting
            } else {
                flattened.append(currentMeeting)
            }
        }
    }

    return flattened
}

func getMatchingAvailabilities(_ calendar: [[Int]], _ meetingDuration: Int) -> [[String]] {
    var matchingAvailabilities = [[Int]]()

    for i in 1 ..< calendar.count {
        let start = calendar[i - 1][1]
        let end = calendar[i][0]

        let availabilityDuration = end - start
        if availabilityDuration >= meetingDuration {
            matchingAvailabilities.append([start, end])
        }
    }

    return matchingAvailabilities.map { $0.map { minutesToTime($0) } }
}

func minutesToTime(_ minutes: Int) -> String {
    var hours = (Double(minutes) / 60)
    hours = hours.rounded(.down)

    let mins = minutes % 60

    let hoursString = "\(Int(hours))"
    let minsString = mins < 10 ? "0" + "\(mins)" : "\(mins)"

    return hoursString + ":" + minsString
}

// --------------------------------------------------------------------------------------------------------------------------------

// New - (Q16-17)
// Medium
// Question 16 - Array of Products

// Very Hard
// Question 17 - Waterfall Streams

