# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "date"

fn = House.create(name: 'XXXXX', code: 'xxxxx')
u = User.create(name: "山田 太郎", admin: true, company: fn, email: "admin@admin.com", password: "adminadmin",
            grant_date_of_paid_leave: Date.new(2012, 10, 1))
InfoForEachFiscalYear.create(year: '2015', company: fn, user: u, carry_over_paid_leave_count: '3.5', carry_over_late_ealy: '3.25')


# 出勤日、祝日設定
DayOfWorkAndHoliday.create(company: fn, day_type: DayOfWorkAndHoliday::DAY_TYPES[:work],    title: "出勤日", day: Date.new(2016, 9, 10))
DayOfWorkAndHoliday.create(company: fn, day_type: DayOfWorkAndHoliday::DAY_TYPES[:work],    title: "出勤日", day: Date.new(2017, 1, 14))
DayOfWorkAndHoliday.create(company: fn, day_type: DayOfWorkAndHoliday::DAY_TYPES[:holiday], title: "敬老の日", day: Date.new(2016, 9, 19))
DayOfWorkAndHoliday.create(company: fn, day_type: DayOfWorkAndHoliday::DAY_TYPES[:holiday], title: "春分の日", day: Date.new(2016, 9, 22))
DayOfWorkAndHoliday.create(company: fn, day_type: DayOfWorkAndHoliday::DAY_TYPES[:holiday], title: "体育の日", day: Date.new(2016, 10, 10))
DayOfWorkAndHoliday.create(company: fn, day_type: DayOfWorkAndHoliday::DAY_TYPES[:holiday], title: "文化の日", day: Date.new(2016, 11, 3))
DayOfWorkAndHoliday.create(company: fn, day_type: DayOfWorkAndHoliday::DAY_TYPES[:holiday], title: "勤労感謝の日", day: Date.new(2016, 11, 23))
DayOfWorkAndHoliday.create(company: fn, day_type: DayOfWorkAndHoliday::DAY_TYPES[:holiday], title: "天皇誕生日", day: Date.new(2016, 12, 23))
DayOfWorkAndHoliday.create(company: fn, day_type: DayOfWorkAndHoliday::DAY_TYPES[:holiday], title: "三が日", day: Date.new(2017, 1, 2))
DayOfWorkAndHoliday.create(company: fn, day_type: DayOfWorkAndHoliday::DAY_TYPES[:holiday], title: "三が日", day: Date.new(2017, 1, 3))
DayOfWorkAndHoliday.create(company: fn, day_type: DayOfWorkAndHoliday::DAY_TYPES[:holiday], title: "成人の日", day: Date.new(2017, 1, 9))
DayOfWorkAndHoliday.create(company: fn, day_type: DayOfWorkAndHoliday::DAY_TYPES[:holiday], title: "春分の日", day: Date.new(2017, 3, 20))
DayOfWorkAndHoliday.create(company: fn, day_type: DayOfWorkAndHoliday::DAY_TYPES[:holiday], title: "憲法記念日", day: Date.new(2017, 5, 3))
DayOfWorkAndHoliday.create(company: fn, day_type: DayOfWorkAndHoliday::DAY_TYPES[:holiday], title: "みどりの日", day: Date.new(2017, 5, 4))
DayOfWorkAndHoliday.create(company: fn, day_type: DayOfWorkAndHoliday::DAY_TYPES[:holiday], title: "こどもの日", day: Date.new(2017, 5, 5))
DayOfWorkAndHoliday.create(company: fn, day_type: DayOfWorkAndHoliday::DAY_TYPES[:holiday], title: "海の日", day: Date.new(2017, 7, 17))
DayOfWorkAndHoliday.create(company: fn, day_type: DayOfWorkAndHoliday::DAY_TYPES[:holiday], title: "山の日", day: Date.new(2017, 8, 11))
DayOfWorkAndHoliday.create(company: fn, day_type: DayOfWorkAndHoliday::DAY_TYPES[:holiday], title: "敬老の日", day: Date.new(2017, 9, 18))
DayOfWorkAndHoliday.create(company: fn, day_type: DayOfWorkAndHoliday::DAY_TYPES[:holiday], title: "体育の日", day: Date.new(2017, 10, 9))

# 基本勤務時間
pa = Partner.create(name: '基本勤務時間', code: 'base')
pa.create_time_setting(
  base:          "08:00",
  work_s:        "09:00",
  work_e:        "18:00",
  rest_first_s:  "12:00",
  rest_first_e:  "13:00",
  rest_second_s: "18:00",
  rest_second_e: "18:30",
  rest_therd_s:  "22:00",
  rest_therd_e:  "22:30"
)
