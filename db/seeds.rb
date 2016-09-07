# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

h = House.create(name: 'Company', code: 'company')
User.create(name: "rara", admin: true, company_id: h.id, partner_id: h.id, email: "admin@admin.com", password: "adminadmin")

# FutureNet
h.create_time_setting(
  base:          "8:00",
  work_s:        "9:00",
  work_e:        "18:00",
  rest_first_s:  "12:00",
  rest_first_e:  "13:00",
  rest_second_s: "18:00",
  rest_second_e: "18:30",
  rest_therd_s:  "22:00",
  rest_therd_e:  "22:30"
)

pa = Partner.create(name: 'Partner', code: 'partner')

pa.create_time_setting(
  base:          "8:00",
  work_s:        "9:00",
  work_e:        "18:00",
  rest_first_s:  "12:00",
  rest_first_e:  "13:00",
  rest_second_s: "18:00",
  rest_second_e: "18:30",
  rest_therd_s:  "22:00",
  rest_therd_e:  "22:30"
)