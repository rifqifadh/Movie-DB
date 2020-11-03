//
//  Connectivity.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 02/11/20.
//

import Foundation
import Network

class Connectivity {
  let monitor = NWPathMonitor()
  
    func isConnectedToInternet() -> Bool {
      var isConnected: Bool = false
      
      monitor.pathUpdateHandler = { path in
          if path.status == .satisfied {
              isConnected = true
          } else {
              isConnected = false
          }

          print(path.isExpensive)
      }
      let queue = DispatchQueue(label: "Monitor")
      monitor.start(queue: queue)
      
      return isConnected
    }
}
