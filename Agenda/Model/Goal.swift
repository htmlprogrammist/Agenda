//
//  Aim.swift
//  Agenda
//
//  Created by Егор Бадмаев on 12.12.2021.
//

struct Goal {
     var title: String
     var current: Int
     var aim: Int
 }

 extension Goal {
     static func getGoals() -> [Goal] {
         return [
             Goal(title: "Дочитать книгу", current: 240, aim: 450),
             Goal(title: "Прыжки со скакалкой", current: 90, aim: 210),
             Goal(title: "Курс по саморазвитию", current: 4, aim: 10),
             Goal(title: "Написать статьи для блога", current: 14, aim: 20)
         ]
     }
 }
