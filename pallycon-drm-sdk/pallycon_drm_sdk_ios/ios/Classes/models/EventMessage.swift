//
//  EventMessage.swift
//  connectivity_plus
//
//  Created by sungju Yun on 2023/01/04.
//

import Foundation

class EventMessage {
    var url: String
    var eventType: PallyConEventType
    var message: String
    var errorCode: String
    
    init(url: String, eventType: PallyConEventType, message: String, errorCode: String) {
        self.url = url
        self.eventType = eventType
        self.message = message
        self.errorCode = errorCode
    }
    
    public func toMap() -> Dictionary<String, String> {
        var event = [String: String]()
        
        event["eventType"] = eventType.name
        event["url"] = url

        if (!errorCode.isEmpty) {
            event["errorCode"] = errorCode
        }

        if (!message.isEmpty) {
            event["message"] = message
        }
        
        return event
    }
}
