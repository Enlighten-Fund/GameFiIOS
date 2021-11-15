//
//  TrackListModel.swift
//  GameFi
//
//  Created by harden on 2021/11/15.
//
import Foundation
import HandyJSON
class TrackListModel: BaseModel {
    var count : Int?
    var next_page : Int?
    var data : Array<TrackModel>?
    required init() {}
}
