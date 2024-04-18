alias Management.Repo
alias Management.Employees.Employee

employees =
[
  {"佐藤 明美", "東京都新宿区西新宿1-1-1", "03-1234-5678", "akemi.sato@example.com", ~D[1985-04-12], "マーケティング", "正社員", ~D[2019-04-01]},
  {"鈴木 一郎", "大阪府大阪市北区梅田2-2-2","06-2345-6789", "ichiro.suzuki@example.com", ~D[1990-05-23], "営業", "契約社員", ~D[2020-05-15]},
  {"高橋 恵子", "福岡県福岡市博多区博多駅3-3-3", "092-3456-7890", "keiko.takahashi@example.com", ~D[1982-08-11], "人事", "正社員", ~D[2018-06-20]},
  {"田中 俊介", "北海道札幌市中央区北5条西4-4-4", "011-4567-8901", "shunsuke.tanaka@example.com", ~D[1979-09-30], "財務", "アルバイト", ~D[2021-09-01]},
  {"伊藤 真紀", "愛知県名古屋市中区栄5-5-5", "052-5678-9012", "maki.ito@example.com", ~D[1993-07-15], "IT部門", "正社員", ~D[2022-01-10]},
  {"渡辺 健太", "宮城県仙台市青葉区一番町6-6-6", "022-6789-0123", "kenta.watanabe@example.com", ~D[1988-10-20], "開発", "契約社員", ~D[2023-03-01]},
  {"山本 花子", "広島県広島市中区基町7-7-7", "082-7890-1234", "hanako.yamamoto@example.com", ~D[1991-11-12], "セキュリティ", "アルバイト", ~D[2021-11-10]},
  {"中村 裕子", "京都府京都市下京区四条通8-8-8", "075-8901-2345", "yuko.nakamura@example.com", ~D[1984-12-05], "法務", "正社員", ~D[2015-12-20]},
  {"小林 雄太", "神奈川県横浜市西区みなとみらい9-9-9", "045-9012-3456", "yuta.kobayashi@example.com", ~D[1992-02-28], "通信", "正社員", ~D[2022-02-15]},
  {"吉田 美咲", "東京都渋谷区神南1-10-10", "03-9012-5678", "misaki.yoshida@example.com", ~D[1987-03-25], "運営", "アルバイト", ~D[2023-01-05]},
  {"森 亮太", "北海道旭川市緑町1-1-1", "0166-123-4567", "ryota.mori@example.com", ~D[1983-04-18], "マーケティング", "正社員", ~D[2018-04-01]},
  {"岡本 美和", "静岡県浜松市中区元城3-3-3", "053-456-7890", "miwa.okamoto@example.com", ~D[1995-05-20], "営業", "契約社員", ~D[2020-05-15]},
  {"藤田 真由美", "新潟県新潟市中央区東大通1-2-3", "025-678-9012", "mayumi.fujita@example.com", ~D[1987-08-25], "人事", "アルバイト", ~D[2019-06-20]},
  {"杉山 聡", "宮崎県宮崎市清水2-2-2", "0985-123-4567", "satoshi.sugiyama@example.com", ~D[1980-09-15], "財務", "正社員", ~D[2017-09-01]},
  {"中村 拓也", "栃木県宇都宮市中央1-1-1", "028-345-6789", "takuya.nakamura@example.com", ~D[1993-07-05], "IT部門", "契約社員", ~D[2021-01-10]},
  {"井上 恵", "愛媛県松山市一番町4-5-6", "089-456-7890", "megumi.inoue@example.com", ~D[1988-10-10], "開発", "正社員", ~D[2022-03-01]},
  {"大野 美里", "岡山県岡山市北区幸町7-8-9", "086-123-4567", "misato.ohno@example.com", ~D[1991-11-05], "セキュリティ", "アルバイト", ~D[2021-11-10]},
  {"小川 彩", "福井県福井市春山町1-2-3", "0776-456-7890", "aya.ogawa@example.com", ~D[1984-12-20], "法務", "正社員", ~D[2015-12-20]},
  {"高木 俊", "群馬県前橋市千代田町4-5-6", "027-123-4567", "shun.takagi@example.com", ~D[1992-02-15], "通信", "正社員", ~D[2022-02-15]},
  {"山田 恵理", "神奈川県横浜市港北区新横浜2-3-4", "045-678-9012", "eri.yamada@example.com", ~D[1987-03-30], "運営", "アルバイト", ~D[2023-01-05]}
]

Enum.each(employees, fn {name, address, phone_number, email, date_of_birth, department, employment_type, date_of_joining} ->
  Repo.insert!(
    %Employee{
      name: name,
      address: address,
      phone_number: phone_number,
      email: email,
      date_of_birth: date_of_birth,
      department: department,
      employment_type: employment_type,
      date_of_joining: date_of_joining
    }
  )
end)
