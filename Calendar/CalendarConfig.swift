//
//  Copyright 2013-2018 Microsoft Inc.
//

struct CalendarConfig {

    let cellWidth: Float = 0.3
    let cellHeight: Float = 0.3
    let cellLength: Float = 0.3
    let lineWidth: Float = 0.001
    let chamferRadius: Float = 0.02

    static let standard: CalendarConfig = CalendarConfig(width: 1, height: 10, length: 20)

    let width: Int
    let height: Int
    let length: Int

}
