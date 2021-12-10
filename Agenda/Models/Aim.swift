//
//  Aim.swift
//  Agenda
//
//  Created by Егор Бадмаев on 07.12.2021.
//

struct Aim {
    var title: String
    var current: Int
    var end: Int
}

extension Aim {
    static func getAims() -> [Aim] {
        return [
            Aim(title: "Дочитать книгу", current: 240, end: 450),
            Aim(title: "Прыжки со скакалкой", current: 90, end: 210),
            Aim(title: "Курс по саморазвитию", current: 4, end: 10),
            Aim(title: "Написать статьи для блога", current: 14, end: 20)
        ]
    }
}
