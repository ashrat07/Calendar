//
//  Copyright 2013-2018 Microsoft Inc.
//

import UIKit

class Utility {

    static let dateFormatter = DateFormatter()

    static let randomEventNames = [
        "Stand-up with Gaurav (weekly)",
        "United flight to Redmond",
        "Employee Q/A with Satya",
        "Sprint Stand up",
        "PM All Hands",
        "Scrum outlook",
        "Office tech talk",
        "Q3 Outlook review",
        "Buy Grocery",
        "Microsoft Product sync",
        "Microsoft 100 MAD party",
        "Team Lunch",
        "E+D Townhall",
        "Hackathon",
        "Hololens Workshop",
        "C+T All Hands",
        "Dinner with Wife",
    ]

    static let durations = [
        "1 h",
        "30 m",
        "45 m",
        "2 h",
        "1 h 30 m"
    ]

    static func getRandomEventName() -> String {
        return randomEventNames[getRandomInt(max: randomEventNames.count)]
    }

    static func getRandomEventNames(randomizeCount: Bool = true, count: Int = 5) -> [String] {
        var randomEventNames = [String]()
        let randomCount: Int
        if randomizeCount {
            randomCount = getRandomInt(max: count) + 1
        } else {
            randomCount = count
        }
        if randomCount > 0 {
            for _ in 0...randomCount - 1 {
                randomEventNames.append(getRandomEventName()
                    + "\n\(getRandomInt(max: 12))" + ":00 " + (getRandomBool() ? "pm" : "am")
                    + "\n" + durations[getRandomInt(max: durations.count)])
            }
        }
        return randomEventNames
    }

    static func getRandomAgenda(dateIndex: Int, minEventCount: Int, maxEventCount: Int) -> Agenda {
        if maxEventCount < minEventCount || (minEventCount == 0 && getRandomBool()) {
            return Agenda(dateIndex: dateIndex, events: [])
        } else {
            let randomEventNames = getRandomEventNames(randomizeCount: false, count: minEventCount + getRandomInt(max: maxEventCount - minEventCount))
            return Agenda(dateIndex: dateIndex, events: randomEventNames)
        }
    }

    static func getRandomAgendas(daysPrevious: Int = 2, daysNext: Int = 5, minEventCount: Int = 0, maxEventCount: Int = 4) -> [Agenda] {
        var randomAgendas = [Agenda]()
        if daysPrevious > 0 {
            for i in 1...daysPrevious {
                randomAgendas.append(getRandomAgenda(dateIndex: -i, minEventCount: minEventCount, maxEventCount: maxEventCount))
            }
        }
        if daysNext > 0 {
            for i in 0...daysNext {
                randomAgendas.append(getRandomAgenda(dateIndex: i, minEventCount: minEventCount, maxEventCount: maxEventCount))
            }
        }
        return randomAgendas
    }

    static func getRandomBool() -> Bool {
        return arc4random_uniform(2) == 0
    }

    static func getRandomInt(max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)))
    }

    static func format(date: Date, dateFormat: String = "d MMM, yyyy") -> String {
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }

}

extension UIColor {

    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }

    convenience init(argb: Int) {
        self.init(
            red: (argb >> 16) & 0xFF,
            green: (argb >> 8) & 0xFF,
            blue: argb & 0xFF,
            a: (argb >> 24) & 0xFF
        )
    }

}
