//
//  Aim.swift
//  Agenda
//
//  Created by Егор Бадмаев on 12.12.2021.
//

struct Goal {
     var title: String
     var current: Int
     var end: Int
 }

 extension Goal {
     static func getGoals() -> [Goal] {
         return [
             Goal(title: "Дочитать книгу", current: 240, end: 450),
             Goal(title: "Прыжки со скакалкой", current: 90, end: 210),
             Goal(title: "Курс по саморазвитию", current: 4, end: 10),
             Goal(title: "Написать статьи для блога", current: 14, end: 20)
         ]
     }
 }
