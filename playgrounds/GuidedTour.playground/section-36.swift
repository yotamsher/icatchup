func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}
sumOf()
sumOf(42, 597, 12)

func averageOf(numbers: Double...) -> Double {
    var sum: Double = 0
    for number in numbers {
        sum += number
    }
    var average = sum / Double(numbers.count)
    return average
}
averageOf()
averageOf(1)
averageOf(1,2,3.6)
