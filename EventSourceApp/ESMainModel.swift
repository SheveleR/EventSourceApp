//
//  ESMainModel.swift
//  EventSourceApp
//
//  Created by SheveleR on 24/02/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import Foundation

class ESMainModel: ESMainModelProtocol {
    let serverUrl: String = "https://jsdemo.envdev.io/sse"
    var eventSource: EventSource!
    
    func createEventSource() {
        eventSource = EventSource.init(url: serverUrl)
    }
    
    func addListner(_ callback: @escaping (_ measurements: String) -> ()) {
        eventSource.onMessage { (_id, unit, measurements) in
            callback(measurements!)
        }
    }
}
