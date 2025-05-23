//
//  Date+.swift
//  JSKit
//
//  Created by leejaesung on 3/27/25.
//

import Foundation

extension Date {

    public var isMorning: Bool {
        let hour = Calendar.current.component(.hour, from: self)
        return hour < 12
    }

    public var isEvening: Bool {
        return !isMorning
    }

    // MARK: - Year

    public var year: Int {
        return Int(self.yearString_yyyy) ?? 0
    }

    public var yearString_yyyy: String {
        let f = DateFormatter()
        f.dateFormat = "yyyy"
        return f.string(from: self)
    }

    // MARK: - Month

    public var month: Int {
        return Int(self.monthString_M) ?? 0
    }

    public var monthString_M: String {
        let f = DateFormatter()
        f.dateFormat = "M"
        return f.string(from: self)
    }

    public var monthString_MM: String {
        let f = DateFormatter()
        f.dateFormat = "MM"
        return f.string(from: self)
    }

    // MARK: - Day

    public var day: Int {
        return Int(self.dayString_d) ?? 0
    }

    public var dayString_d: String {
        let f = DateFormatter()
        f.dateFormat = "d"
        return f.string(from: self)
    }

    public var dayString_dd: String {
        let f = DateFormatter()
        f.dateFormat = "dd"
        return f.string(from: self)
    }

    // MARK: - Hour

    public var hourString_H: String {
        let f = DateFormatter()
        f.dateFormat = "H"
        return f.string(from: self)
    }

    public var hourString_HH: String {
        let f = DateFormatter()
        f.dateFormat = "HH"
        return f.string(from: self)
    }

    public var rc_hour: Int { // date에 hour가 있지만, 로컬 시간이 아니므로 rc_hour를 추가함
        return Int(self.hourString_H) ?? 0
    }

    // MARK: - Minute

    public var minuteString_mm: String {
        let f = DateFormatter()
        f.dateFormat = "mm"
        return f.string(from: self)
    }

    // MARK: - WeekDay

    public enum RC_Locale: String {
        case en_US
        case ko_KR
    }

    public func weekDayString(with locale: RC_Locale) -> String {
        let f = DateFormatter()
        f.dateFormat = "EEEE"
        f.locale = Locale(identifier: locale.rawValue)
        return f.string(from: self)
    }

    // MARK: - Identifier

    /// yyyyMMdd는 `RC_Event의 식별자로 사용하고 있으므로 절대 건드리지 말 것!!!` ///
    /// e.g. 20240101
    public var yyyyMMdd: String {
        return String(format: "%04d%02d%02d", self.year, self.month, self.day)
    }

    /// e.g. 202401
    public var yyyyMM: String {
        return String(format: "%04d%02d", self.year, self.month)
    }

    /// e.g. 202401
    public var MMdd: String {
        return String(format: "%04d%02d", self.year, self.month)
    }

    // MARK: - STRINGS

    /*
     f.dateStyle = .full    // en: Monday, July 22, 2024 // ko: 2024년 7월 22일 월요일 // ja: 2024年7月22日 月曜日  // cn: 2024年7月22日 星期一
     f.dateStyle = .long    // en: July 22, 2024         // ko: 2024년 7월 22일      // ja: 2024年7月22日       // cn: 2024年7月22日
     f.dateStyle = .medium  // en: Jul 22, 2024          // ko: 2024. 7. 22.       // ja: 2024. 7. 22.       // cn: 2024. 7. 22.
     f.dateStyle = .short   // en: 7/22/24               // ko: 2024. 7. 22.       // ja: 2024. 7. 22.       // cn: 2024. 7. 22.
     f.dateStyle = .none    // nil
     */

    // MARK: - short

    public var short: String {
        let f = DateFormatter()
        f.dateStyle = .short
        return f.string(from: self)
    }

    // MARK: - medium

    /// `2024. 7. 22.`로 표시하던 `yyyy_MM_dd`를 글로벌로 사용하기 위한 대체 용도
    /// 2024. 7. 22. / en: Jul 22, 2024 / ja: 2024. 7. 22. / cn: 2024. 7. 22.
    public var medium: String {
        let f = DateFormatter()
        f.dateStyle = .medium
        return f.string(from: self)
    }

    // MARK: - long

    /// `2024년 7월 22일`로 표시하던 `년월일`를 글로벌로 사용하기 위한 대체 용도
    /// 2024년 7월 22일 / en: July 22, 2024 / ja: 2024年7月22日 / cn: 2024年7月22日
    public var long: String {
        let f = DateFormatter()
        f.dateStyle = .long
        return f.string(from: self)
    }

    // MARK: - Others
    /// 아래부터는 년월, 월일 같이 날짜 전체(`년월일`)를 필요하지 않을 때 사용

    /// e.g. 2024년
    public func yyyy(year y: Int) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let dateComponents = DateComponents(year: y)
        guard let date = calendar.date(from: dateComponents) else { return "" }

        let f = DateFormatter()
        f.setLocalizedDateFormatFromTemplate("yyyy")
        return f.string(from: date)
    }

    /// e.g. 2024년 7월 / en: Jul 2024 / ja: 2024年7月 / cn: 2024年7月 / vi: thg 7 2024
    public var yyyy_MMM: String {
        let f = DateFormatter()
        f.setLocalizedDateFormatFromTemplate("yyyy.MMM")
        return f.string(from: self)
    }

    /// e.g. 2024년 7월 / en: Jul 2024
    /// 특정 년, 월일 표기할 때 (e.g. 달력 월 이동에 따른 내비게이션 바 타이틀 표시)
    public func yyyy_MMM(year y: Int, month m: Int) -> String? {
        let calendar = Calendar(identifier: .gregorian)
        let dateComponents = DateComponents(year: y, month: m)
        let date = calendar.date(from: dateComponents)

        return date?.yyyy_MMM
    }

    /// e.g. 7월
    public func MMM(month m: Int) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let dateComponents = DateComponents(month: m)
        guard let date = calendar.date(from: dateComponents) else { return "" }

        let f = DateFormatter()
        f.setLocalizedDateFormatFromTemplate("MMM")
        return f.string(from: date)
    }

    /// e.g. 7월 02일 / en: 02 Jul / ja: 7月02日 / cn: 7月02日 / vi: 02 thg 7
    public var MMM_dd: String {
        let f = DateFormatter()
        f.setLocalizedDateFormatFromTemplate("MMM.dd")
        return f.string(from: self)
    }

    /// e.g. 7월 2일 / en: 2 Jul / ja: 7月2日 / cn: 7月2日 / vi: 2 thg 7
    public var MMM_d: String {
        let f = DateFormatter()
        f.setLocalizedDateFormatFromTemplate("MMM.d")
        return f.string(from: self)
    }

    /// e.g. 07. 22. / en: 07/22 / ja: 07/22 / cn: 07/22 / vi: 22-07
    public var MM_d: String {
        let f = DateFormatter()
        f.setLocalizedDateFormatFromTemplate("MM.d")
        return f.string(from: self)
    }

    /// e.g. 7. 22. / en: 7/22 / ja: 7/22 / cn: 7/22 / vi: 22-7
    public var M_d: String {
        let f = DateFormatter()
        f.setLocalizedDateFormatFromTemplate("M.d")
        return f.string(from: self)
    }

    /// e.g. 22일 / en: 22 / ja: 22日 / cn: 22日 / vi: 22
    public var dd: String {
        let f = DateFormatter()
        f.setLocalizedDateFormatFromTemplate("dd")
        return f.string(from: self)
    }

    /// e.g. 22일
    public func dd(day d: Int) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let dateComponents = DateComponents(day: d)
        guard let date = calendar.date(from: dateComponents) else { return "" }

        let f = DateFormatter()
        f.setLocalizedDateFormatFromTemplate("dd")
        return f.string(from: date)
    }
}
