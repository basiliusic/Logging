//
//  InterpolatingObject.swift
//  Logger
//
//  Created by basilic on 31.10.2021.
//

@usableFromInline
protocol InterpolatingObject {
  var align: LogStringAlignment { get }
  var privacy: LogPrivacy { get }
  var attributes: String { get }
}
