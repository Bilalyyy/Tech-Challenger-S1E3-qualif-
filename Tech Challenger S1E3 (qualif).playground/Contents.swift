import UIKit

func load(file named: String) -> String? {
    guard let fileUrl = Bundle.main.url(forResource: named, withExtension: "txt") else {
        return nil
    }
    guard let content = try? String(contentsOf: fileUrl, encoding: .utf8) else {
        return nil
    }
    return content
}

let nbrExo = 4

let line = load(file: "input\(nbrExo)")!

var sLine = line
let nbrTotalLigne = sLine.split(separator: "\n").first
sLine.removeFirst(nbrTotalLigne!.count + 2)

let allerStr = "Paris-Lyon"
let retourStr = "Lyon-Paris"
let dateFormater = DateFormatter()
dateFormater.dateFormat = "HH:mm:ss"

let horaireDuJour = sLine.split(separator: "\n")

let allerBrut = horaireDuJour.filter{ $0.contains(allerStr)}
let retourBrut = horaireDuJour.filter{ $0.contains(retourStr)}

let retourSorted = retourBrut.sorted(by: {
    let item0 = $0.split(separator: " ")
    let item1 = $1.split(separator: " ")
    
    let firstempreinte = Int(item0.last!)!
    let secondempreinte = Int(item1.last!)!
    
    return firstempreinte < secondempreinte })

let allerSorted = allerBrut.sorted(by: {
    let item0 = $0.split(separator: " ")
    let item1 = $1.split(separator: " ")
    
    let firstTimeStr = item0.last!
    let secondTimeStr = item1.last!
    
    let firstEmpreinte = Int(firstTimeStr)!
    let secondEmpreinte = Int(secondTimeStr)!
    return firstEmpreinte < secondEmpreinte })

var probable = Int.max
allerSorted.forEach { aller in

    let aItem = aller.split(separator: " ")
    let aEmpreinte = Int(aItem.last!)!
    guard aEmpreinte < probable else { return }
    for retour in retourSorted {

        let rItem = retour.split(separator: " ")
        let aDateStr = aItem.first!
        let rDateStr = rItem.first!

        guard dateFormater.date(from: String(aDateStr))! < dateFormater.date(from: String(rDateStr))! else { continue }
        
        let rEmpreinte = Int(rItem.last!)!
        let total = rEmpreinte + aEmpreinte
        guard total < probable else { return }
        
        probable = total
    }
}

let correction = Int(load(file: "output\(nbrExo)")!)
if correction == probable {
    print("Bravo, tu as réussi le test")
} else {
    print("Hélas, tu devais trouver : \(correction!); tu as trouvé : \(probable)")
}
