//
//  Data+Ext.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import Foundation

extension Data {
    init<T>(from value: T) {
        self = withUnsafePointer(to: value) {
            (pointer: UnsafePointer<T>) -> Data in
            
            return Data(buffer: UnsafeBufferPointer(start: pointer, count: 1))
        }
    }
    
    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }
    }
}
