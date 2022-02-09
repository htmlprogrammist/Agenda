//
//  Person.swift
//  Agenda
//
//  Created by Егор Бадмаев on 12.12.2021.
//

// изначально всё будет выставлено "по умолчанию", но пользователь через UITextField всё может изменить под себя
// в идеале сделать бы всё это как в Apple Health блоки
struct Summary {
    // var streak: Int // сомнительная идея, ведь цели на месяц, а не на день
    var minAimsForMonth: Int  // минимальное количество целей, которые надо выполнить (потом будут поощрения)
    var numberOfCompletedGoals: Int // общее количество выполненных целей
    var numberOfGoals: Int // общее количество поставленных целей
    var averageNumberOfCompletedGoals: Double {
        Double(numberOfCompletedGoals) / Double(numberOfGoals)
    } // среднее арифметическое выполненных целей (округлить до десятых)
}
