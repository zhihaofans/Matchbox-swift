//
//  jsDelivrService.swift
//  MacBox
//
//  Created by zzh on 2024/6/18.
//

import Foundation

class jsDelivrSerivce {
    func generateFromGithub(githubUrl: String) -> String? {
        if githubUrl.isNotEmpty {
            let inputUrls = githubUrl.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ").map { String($0) }
            var cdnLinks: [String] = []

            for inputUrl in inputUrls {
                let trimmedUrl = inputUrl.trimmingCharacters(in: .whitespacesAndNewlines)
                var cdnLink = ""

                if trimmedUrl.hasPrefix("https://github.com/"), trimmedUrl.contains("/blob/") {
                    cdnLink = trimmedUrl
                        .replacingOccurrences(of: "https://github.com/", with: "https://cdn.jsdelivr.net/gh/")
                        .replacingOccurrences(of: "/blob/", with: "/")
                        .replacingOccurrences(of: "/main/", with: "/")
                } else if trimmedUrl.hasPrefix("https://raw.githubusercontent.com/") {
                    let parts = trimmedUrl.split(separator: "/").map { String($0) }
                    if parts.count > 6 {
                        let userRepo = parts[2] + "/" + parts[3]
                        let filename = parts[6...].joined(separator: "/")
                        cdnLink = "https://cdn.jsdelivr.net/gh/\(userRepo)/\(filename)"
                    } else {
                        print("Invalid URL")
                        return nil
                    }
                } else {
                    print("Invalid URL")
                    return nil
                }

                cdnLinks.append(cdnLink)
            }
            return cdnLinks.first
            //return cdnLinks.joined(separator: " ")
        } else {
            print("githubUrl.isEmpty")
            return nil
        }
    }
}
