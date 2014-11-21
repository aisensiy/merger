# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
industry_list = ["农业", "林业", "畜牧业", "渔业", "农、林、牧、渔服务业", "煤炭开采和洗选业", "石油和天然气开采业", "黑色金属矿采选业", "有色金属矿采选业", "开采辅助活动", "农副食品加工业", "食品制造业", "酒、饮料和精制茶制造业", "纺织业", "纺织服装、服饰业", "皮革、毛皮、羽毛及其制品 和制鞋业", "木材加工及木、竹、藤、棕、草制品业", "家具制造业", "造纸及纸制品业", "印刷和记录媒介复制业", "文教、工美、体育和娱乐用 品制造业", "石油加工、炼焦及核燃料加 工业", "化学原料及化学制品制造业", "医药制造业", "化学纤维制造业", "橡胶和塑料制品业", "非金属矿物制品业", "黑色金属冶炼及压延加工业", "有色金属冶炼和压延加工业", "金属制品业", "通用设备制造业", "专用设备制造业", "汽车制造业", "铁路、船舶、航空航天和其 它运输设备制造业", "电气机械及器材制造业", "计算机、通信和其他电子设 备制造业", "仪器仪表制造业", "其他制造业", "废弃资源综合利用业", "电力、热力生产和供应业", "燃气生产和供应业", "水的生产和供应业", "房屋建筑业", "土木工程建筑业", "建筑安装业", "建筑装饰和其他建筑业", "批发业", "零售业", "铁路运输业", "道路运输业", "水上运输业", "装卸搬运和运输代理业", "仓储业", "住宿业", "餐饮业", "电信、广播电视和卫星传输 服务", "互联网和相关服务", "软件和信息技术服务业", "货币金融服务", "资本市场服务", "保险业", "其他金融业", "房地产业", "租赁业", "商务服务业", "研究和试验发展", "专业技术服务业", "生态保护和环境治理业", "公共设施管理业", "教育", "卫生", "新闻和出版业", "广播、电视、电影和影视录 音制作业", "文化艺术业", "综合"]

if Industry.all.size == 0
  industry_list.each {|industry| Industry.create(name: industry)}
end

Deal.delete_all
Target.delete_all
Buyer.delete_all

if Deal.all.size == 0
  100.times { FactoryGirl.create :deal }
end

if Target.where(is_sold: false).size == 0
  180.times { FactoryGirl.create :target }
end

180.times { FactoryGirl.create :buyer }
