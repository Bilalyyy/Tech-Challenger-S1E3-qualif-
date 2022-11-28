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

let line = load(file: "input\(nbrExo)")!

struct Voyage {
    let hoursDepart: String
    let empreinte: Int
}

let dateFormater = DateFormatter()
dateFormater.dateFormat = "HH:mm:ss"

var sLine = line
let nbrTotalVoyage = sLine.split(separator: "\n").first
sLine.removeFirst(nbrTotalVoyage!.count + 2)

let horaireDuJour = sLine.split(separator: "\n")


var voyagesAller = [Voyage]()
var voyagesRetour = [Voyage]()

horaireDuJour.forEach { item in
    let voyageArray = item.split(separator: " ")
    
    let hoursDepart = String(voyageArray.first!)
    let cityDepart = String(voyageArray[1])
    let empreinte = String(voyageArray.last!)

    if cityDepart == "Paris-Lyon" { // ALLER
        voyagesAller.append(Voyage(hoursDepart: hoursDepart,
                                   empreinte: Int(empreinte)!))
    } else { // Retour
        voyagesRetour.append(Voyage(hoursDepart: hoursDepart,
                                    empreinte: Int(empreinte)!))
    }
}

let firstDepart = voyagesAller.sorted(by: {dateFormater.date(from: $0.hoursDepart)! < dateFormater.date(from: $1.hoursDepart)!}).first!
let lastRetour = voyagesRetour.sorted(by: { dateFormater.date(from: $0.hoursDepart)! < dateFormater.date(from: $1.hoursDepart)!}).last!

let allerClean = voyagesAller.filter { dateFormater.date(from: $0.hoursDepart)! < dateFormater.date(from: lastRetour.hoursDepart)! }

let retourClean = voyagesRetour.filter { dateFormater.date(from: $0.hoursDepart)! > dateFormater.date(from: firstDepart.hoursDepart)! }

let allerSorted = allerClean.sorted(by: { $0.empreinte < $1.empreinte })

let retourSorted = retourClean.sorted(by: { $0.empreinte < $1.empreinte })


var probable = Int.max
allerSorted.forEach { aller in
    guard aller.empreinte < probable else { return }
    for retour in retourSorted {
        let total = retour.empreinte + aller.empreinte
        guard total < probable else { return }
        let hourAller = dateFormater.date(from: aller.hoursDepart)!
        let hourRetour = dateFormater.date(from: retour.hoursDepart)!
        guard hourAller.compare(hourRetour) == .orderedAscending else { return }
        probable = total
    }
}

print(probable)
print("corigé: \(load(file: "output\(nbrExo)")!)")
