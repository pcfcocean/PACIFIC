import Foundation

public extension DateFormatter {
    enum Format: String {
        case yyyyMMddWithDashSeparated = "yyyy-MM-dd"
        case ddMMWithDotSeparated = "dd.MM"
        case yyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss"
        case yyyyMMddTHHmmssZ = "yyyy-MM-dd'T'HH:mm:ssZ"
        case yyyyMMddTHHmmssSZ = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        case yyyyMMddTHHmmssSSS = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        case yyyyMMddTHHmmssSSSxxx = "yyyy-MM-dd'T'HH:mm:ss.SSSxxx"
        case yyyyMMddTHHmmssSSSSS = "yyyy-MM-dd'T'HH:mm:ss.SSSSS"
        case yyyyMMddTHHmmssSSSSSS = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        case yyyyMMddTHHmmssSSSZ = "yyyy-MM-dd'T'HH:mm:ss.S'Z'"
        case yyyyMMddTHHmmssZZZZZ = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        case yyyyMMddTHHmmssNoColon = "yyyyMMdd'T'HHmmss"
        case dMMMMWithSpaceSeparated = "d MMMM"
        case fullMonthText = "LLLL"
        case ddMMyyWithDotSeparated = "dd.MM.yy"
        case ddMMMMyyyySpaceSeparated = "dd MMMM yyyy"
        case dMMMMyyyySpaceSeparated = "d MMMM yyyy"
        case ddMMMyyyySpaceSeparated = "dd MMM yyyy"
        case ddMMyyyyWithDotSeparated = "dd.MM.yyyy"
        case ddMMMMHHmm = "dd MMMM HH:mm"
        /// 9 января, 9:41
        case dMMMMHHmmCommaSeparated = "d MMMM, HH:mm"
        case dMMMMyyyyHHmmSpaceSeparated = "d MMMM yyyy, HH:mm"
        case mmmm = "MMMM"
        case yyyy = "yyyy"
        case yyyyMMddWithDotSeparated = "yyyy.MM.dd"
        case ddMMyyyyWithDashSeparated = "dd-MM-yyyy"
        case ddMMyyyyHHmmss = "dd.MM.yyyy HH:mm:ss"
        case ddMMyyyyHHmmCommaSeparated = "dd.MM.yyyy, HH:mm"
        case ddMMyyHHmmCommaSeparated = "dd.MM.yy, HH:mm"
        case m = "m"
        case d = "d"
        case ddMMyyyyHHmm = "dd.MM.yyyy HH:mm"
        case HHmm = "HH:mm"
        case HHmmZ = "HH:mmZ"
        case HHmmss = "HH:mm:ss"
        case yyyyMMdd = "yyyyMMdd"
        case yyyyMMddTHHmmssS = "yyyy-MM-dd'T'HH:mm:ss.S"
        case EEEEdMMMM = "EEEE, d MMMM"
        case ddMMyyyyTHHmmss = "dd.MM.yyyy'T'HH:mm:ss"
        case dMMMMHHmmBulletSeparated = "d MMMM • HH:mm"
    }

    convenience init(with format: Format) {
        self.init()
        dateFormat = format.rawValue
        calendar = .autoupdatingCurrent
        locale = .ru
    }

    convenience init(with format: Format, timeZone: TimeZone?) {
        self.init(with: format)
        self.timeZone = timeZone
    }
}
