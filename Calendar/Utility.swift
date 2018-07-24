//
//  Copyright 2013-2018 Microsoft Inc.
//

import Foundation

class Utility {

    static let dateFormatter = DateFormatter()

    static let randomEventNames = [
        "Operation Fairy",
        "Operation Snow Crystal",
        "Operation Harlequin",
        "Operation Bump",
        "Operation Knockdown",
        "Operation Lipstick",
        "Operation Hocus Pocus",
        "Operation Sea Puma",
        "Operation Ocean Thunder",
        "Operation Brown Thunder",
        "Operation Bull's Eye",
        "Operation Olympia",
        "Operation Blackjack",
        "Operation Blade's Edge",
        "Operation Oscar",
        "Operation Alakazam",
        "Operation Cyclone",
        "Operation Hidden Redemption",
        "Operation Red Nightmare",
        "Operation Orange Champion",
        "Operation Breastplate",
        "Operation Judas Kiss",
        "Operation Surprise Party",
        "Operation Ferocity",
        "Operation Whiz Kid",
        "Operation Man Eater",
        "Operation Voodoo Vibes",
        "Operation Ocean Blade",
        "Operation Blue Obelisk",
        "Operation Blue Blade",
        "Operation Jester",
        "Operation Chronicle",
        "Operation Poltergeist",
        "Operation Saturate",
        "Operation Nightmare",
        "Operation Harlequin",
        "Operation Pyramid",
        "Operation Red Hearts",
        "Operation Swamp Gate",
        "Operation White Comet",
        "Operation Homesick",
        "Operation Bells 'N Whistles",
        "Operation Free Rein",
        "Operation Rock And Roar",
        "Operation Typhoon",
        "Operation Powder Snow",
        "Operation Greenhouse",
        "Operation Jungle Buffalo",
        "Operation Blind Hammer",
        "Operation Jungle Dust",
        "Operation Close Shave",
        "Operation Fruit Fly",
        "Operation Poker Face",
        "Operation Crossfire",
        "Operation Hyperbole",
        "Operation Dust Angel",
        "Operation Bucking Bronco",
        "Operation Green Ghost",
        "Operation Gray Knuckle",
        "Operation Swamp Vanguard",
        "Operation Axe",
        "Operation Alakazam",
        "Operation Bad Juju",
        "Operation Sapphire",
        "Operation Bread And Water",
        "Operation Poltergeist",
        "Operation Bull's Eye",
        "Operation Blue Vengeance",
        "Operation Ocean Rain",
        "Operation Black Paladin"
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
                randomEventNames.append(getRandomEventName())
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
