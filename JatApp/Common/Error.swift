import Foundation
import UIKit

enum ErrorMessege: String {
    case emptyFields = "All fields are empty"
    case name = "Enter your name"
    case setPassword = "Please set password"
    case morePassword = "Password should has more then 5 symbols"
    case moreName = "Name should has more then 3 symbols"
    case confirmPassword = "Please confirm password"
    case notMatch = "Password do not match. Please try again"
    case errorEmail = "Email entered is not correct. Example: name@gmail.com"
    case enterEmail = "Please enter e-mail"
    case error = "Error"
    case enterPassword = "Please enter password"
}
