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


let nbrExo = 2

var line = load(file: "input\(nbrExo)")!

struct Voyage {
    let HoursDepart: String
    let CityDepart: String
    let empreinte: String
}

var dateFormater = DateFormatter()
dateFormater.dateFormat = "HH:mm:ss"

var sLine = line
let nbrTotalVoyage = sLine.split(separator: "\n").first
sLine.removeFirst(nbrTotalVoyage!.count + 2)

let horaireDuJour = sLine.split(separator: "\n")
var voyages = sortedHoraireDuJour()

func sortedHoraireDuJour() -> [Voyage] {
    var output = [Voyage]()
    horaireDuJour.forEach { item in
        let voyageArray = item.split(separator: " ")
        let voyage = Voyage(HoursDepart: String(voyageArray.first!),
                            CityDepart: String(voyageArray[1]),
                            empreinte: String(voyageArray.last!))
        output.append(voyage)
    }
    return output
}


var voyageAller: [Voyage] {
    var filter = voyages.filter { $0.CityDepart == "Paris-Lyon"}
    return filter.sorted(by: { dateFormater.date(from: $0.HoursDepart)!  < dateFormater.date(from: $1.HoursDepart)! })
}
print("voyageAller.count 1 : \(voyageAller.count)")

var voyageRetour: [Voyage] {
    var filter = voyages.filter { $0.CityDepart == "Lyon-Paris"}
    return filter.sorted(by: { dateFormater.date(from: $0.HoursDepart)!  < dateFormater.date(from: $1.HoursDepart)! })
}
print("voyageRetour.count 1 : \(voyageRetour.count)")


var probable = Int.max
voyageAller.forEach { aller in
    let filterRetourByTime = voyageRetour.filter {
        guard let hoursDepart = dateFormater.date(from: $0.HoursDepart) else { return false }
        guard let hoursRetour = dateFormater.date(from: aller.HoursDepart) else { return false }
        return hoursDepart > hoursRetour
    }
    
    let sortedRetourByEmpreinte = filterRetourByTime.sorted(by: { $0.empreinte < $1.empreinte })
    
    for retour in sortedRetourByEmpreinte {
        let aller = Int(aller.empreinte)!
        let retour = Int(retour.empreinte)!
        let total = aller + retour
        guard total < probable else { return }
            probable = total
    }

}
print(probable)
print("corigé: \(load(file: "output\(nbrExo)")!)")

