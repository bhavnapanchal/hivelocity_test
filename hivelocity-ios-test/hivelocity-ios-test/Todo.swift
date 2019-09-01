//
//  Todo.swift
//  hivelocity-ios-test
//
//  Created by takanobu sugiyama on 2019/08/05.
//

typealias TodoResponse = [Todo]

struct Todo: Decodable {
    let userId: Int?
    let id: Int?
    let title: String?
    let completed: Bool?

    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case id = "id"
        case title = "title"
        case completed = "completed"
    }
}
