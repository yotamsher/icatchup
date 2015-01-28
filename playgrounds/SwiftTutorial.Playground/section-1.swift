// 1
class TipCalculator {
//2
    let total: Double
    let taxPct: Double
    let subTotal: Double
//3 
    init(total: Double, taxPct: Double){
        self.total = total
        self.taxPct = taxPct
        subTotal = total / (taxPct + 1)
    }
    
    //4
    func calcTipWithTipPct(tipPct: Double) -> Double{
        return subTotal * tipPct
    }
    
    
    // 1
    
    func returnPossibleTips() -> [Int: Double] {
        let possibleTipsInferred = [0.15, 0.18, 0.20]
        let possibleTipsExplicit: [Double] = [0.15, 0.18, 0.20]
        
        // 2
        var retval = [Int: Double]()
        
        for possibleTip in possibleTipsInferred{
            let intPct = Int(possibleTip * 100)
        // 3
            retval[intPct] = calcTipWithTipPct(possibleTip)
        }
        return retval
    }
    
    //5
    func printPossibleTips(){
        let possibleTipsInferred = [0.15, 0.18, 0.20]
        let possibleTipsExplicit:[Double] = [0.15, 0.18, 0.20]
        for possibleTip in possibleTipsInferred {
            println("\(possibleTip*100)%: \(calcTipWithTipPct(possibleTip))")
        }
    }
}


let tipCalc = TipCalculator(total: 33.25, taxPct: 0.06)
tipCalc.returnPossibleTips()
