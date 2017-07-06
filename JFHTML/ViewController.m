//
//  ViewController.m
//  JFHTML
//
//  Created by 付书炯 on 16/4/29.
//  Copyright © 2016年 shujiong. All rights reserved.
//

#import "ViewController.h"
#import "JFHTMLParser.h"
#import "JFHTMLAttributedStringBuilder.h"
#import "DTHTMLParser.h"
#import "NSAttributedString+DDHTML.h"
#import "NSAttributedString+DMHTML.h"

@interface ViewController () <JFHTMLParserDelegate, DTHTMLParserDelegate>{
    JFHTMLParser *_htmlParser;
    NSXMLParser *_xmlParser;
    
    JFHTMLAttributedStringBuilder *_builder;
    
    YYTextView * _contentLabel;
}
@property (weak, nonatomic) IBOutlet UITextView *textView;

//@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _contentLabel = [[YYTextView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_contentLabel];
    
    [self parseHTML];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)parseHTML {
    NSString *htmlString = [self html3];
    
    NSAttributedString *text = [NSAttributedString dm_attributedStringFromHTML:htmlString];
    
    _contentLabel.attributedText = text;
    //    self.textView.attributedText = text;
    
    return;
    
    _htmlParser = [[JFHTMLParser alloc] initWithData:[htmlString dataUsingEncoding:NSUTF8StringEncoding] encoding:NSUTF8StringEncoding];
    _htmlParser.delegate = self;
    
    [_htmlParser parse];
    
    return;
    
    
    NSAttributedString *attributedText;
    
    
    //    attributedText = [NSAttributedString attributedStringFromHTML:htmlString];
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary* options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                              NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)};
    
    
    attributedText = [[NSAttributedString alloc] initWithData:data
                                                      options:options
                                           documentAttributes:nil
                                                        error:NULL];
    
    
    [attributedText enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, attributedText.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        
    }];
    
    //    _builder = [[JFHTMLAttributedStringBuilder alloc] initWithHTML:data];
    //    _builder.baseFontSize = 14;
    //    attributedText = [_builder build];
    
    self.textView.attributedText = attributedText;
    
    
    //    _htmlParser = [[JFHTMLParser alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //    _htmlParser.delegate = self;
    //    [_htmlParser parse];
    
    //    DTHTMLParser *parser = [[DTHTMLParser alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //    parser.delegate = self;
    //    [parser parse];
}

- (void)parserDidStartDocument:(JFHTMLParser *)parser {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)parserDidEndDocument:(JFHTMLParser *)parser {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)parser:(JFHTMLParser *)parser didStartElement:(NSString *)elementName attributes:(NSDictionary *)attributeDict {
    NSLog(@"%@, element name: %@, attributes: %@", NSStringFromSelector(_cmd), elementName, attributeDict);
}

- (void)parser:(JFHTMLParser *)parser didEndElement:(NSString *)elementName {
    NSLog(@"%@, end element: %@", NSStringFromSelector(_cmd), elementName);
}

- (void)parser:(JFHTMLParser *)parser foundCharacters:(NSString *)string {
    NSLog(@"%@, characters: %@", NSStringFromSelector(_cmd), string);
}

#pragma mark -

- (NSString *)html1 {
    return @"<img src=\"https://static.dmcdn.cn/cfs/fun/content/2017/06/29/19/137a5521-7a19-4f6c-87aa-94a67f7a8353.jpg\" width=\"600\" height=\"900\" />Be <strong>Bold!</strong> And a <span style='color:blue'>"
    @"<span style='font-size:18'>little</span> color</span> wouldn’t hurt either.</p><p>start</p><h3 label=\"jtwsm-title\" class=\"jtwsm-title\" id>这是标题</h3><p>的<br/>撒发的撒的撒发大水<br/>asdf<a yun>链接1</a></p><p>图片1<img width=\"100%\" src=\"http://static.damai.cn/wanimg/64e4d7d1-7765-4e20-ab8d-d51d69ce3fd9.jpg\"/><img src=\"https://ss3.bdstatic.com/lPoZeXSm1A5BphGlnYG/skin/66.jpg?2\" /><br></p><p>图片2<img width=\"100%\" src=\"http://static.damai.cn/wanimg/5830b131-36a0-49d6-a09a-0a106fbb9eb3.jpg\"/></p><p><br></p><p>&nbsp;&nbsp;&nbsp;大发大水放大书法的放大书法发啊发反馈大了；解放大路；手机发了扩大加快劳动纠纷离开的肌肤的看法鞠东克拉风景的<br></p><p>回车段落</p><p>大发大发空间的两发大水</p><p>－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－</p><h5 label=\"jtwsm-title\" class=\"jtwsm-title\">今年适逢奥运年</h5><p>各大影像厂商也都推出了旗下的重磅新机，在年初CES2016前夕尼康就新发布了最新款全画幅旗舰数码单反相机D5，比起之前D4到D4S，又或者更早D3到D3S或D3X的小幅提升，这次新发布的D5算得上真正具有革新意义的大升级，可以说是“意料之外的惊喜”。尼康D5不仅使用了EXPEED 5处理器，同时从感光元件到对焦系统都进行全方位的提升，153点AF对焦系统和最高ISO 3280000的感光度，这在单反诞生至今从未出现过，完全可以用变态来形容。那么作为一款顶级的机型尼康D5究竟有多强劲？不妨一起来看看今天的评测吧。</p><p>300W感光度+153点AF对焦系统 尼康D5 机身 售价：48499元&gt;&gt;购买链接&nbsp;(17人感兴趣)</p><p><br></p><p><img width=\"100%\" src=\"http://static.damai.cn/wanimg/f75b9e73-7112-4572-b4b3-fdfd07aca3b6.jpg\"/></p><p>尼康 D5 单反机身<br></p><h3 label=\"jtwsm-title\" class=\"jtwsm-title\">更多商家国美在<p>的撒发大水<br></p><h6 label=\"jtwsm-title\" class=\"jtwsm-title\">￥47198&nbsp;|&nbsp;京东商城：￥47999&nbsp;|&nbsp;亚马逊：￥52888<p>尼康Nikon D5主要升级点和规格：</p><p>· 全新的2080万有效像素全画幅CMOS感光元件<br>· 拥有高达ISO 102400的标准感光度，还可扩展至Hi 5（相当于ISO 3280000）<br>· 全新Multi-CAM 20000自动对焦模块，提供153个对焦点（99点为十字型感应器）</p>";
}

- (NSString *)html2 {
    return @"<div style=\"text-align:center;\">\r\n\t<br />\r\n</div>\r\n<strong> \r\n<div style=\"text-align:center;\">\r\n\t“演唱会之王”五月天全新巡回LIFE《人生无限公司》<br />\r\n五月天巡演热潮正式启动碾压模式<br />\r\n<br />\r\n成军20周年“第10代大型巡回演唱会”<br />\r\n五月天打掉重练超展开五月天《人生无限公司》<br />\r\n<br />\r\n“五月天倒数第二张实体CD专辑”《自传》发行5个月<br />\r\n横扫3大销售榜年度总冠军<br />\r\n<br />\r\nLIFE《人生无限公司》制作费升级无限超支<br />\r\n五月天互尬串场电影狂飙彩蛋无极限<br />\r\n</div>\r\n</strong> \r\n<p style=\"text-align:center;\">\r\n\t<img title=\"五月天 LIFE [ 人生无限公司 ] 世界巡回演唱会-沈阳站  2017 MAYDAY LIFE TOUR\" alt=\"五月天 LIFE [ 人生无限公司 ] 世界巡回演唱会-沈阳站  2017 MAYDAY LIFE TOUR\" width=\"550\" height=\"345\" /> \r\n</p>\r\n<p>\r\n\t&nbsp;\r\n &nbsp; “演唱会之王”五月天刚结束接连9场《RE : LIVE -Just Rock It 2016最终章 [自传复刻版] \r\n》限定演唱会。在这9个晚上，任意门穿梭了五月天成军19年来的9场大型巡回演唱会，“长长99”的存在所有曾参与其中的人心中。时间跨入2017年，也是五月天成军20年的重要里程碑，恰逢这个“10全10美”的双十好数字，五月天也将展开他们的<strong>“第10代大型巡回演唱会”LIFE《人生无限公司》</strong>。刚复刻19年跨世代集体记忆的五月天，跨年第一天正式宣告成军第20年的第10代五月天演唱会“打掉重练、从0开始自我挑战”，正式进入“五月天人生2.0”。<strong>众人皆知能打败“演唱会之王”五月天的，只有五月天的演唱会</strong>，压力超大的五月天对于全新世界巡回LIFE《人生无限公司》从一开始就向整个团队立下唯一目标﹕“打掉重练”！打破过去五月天所创下的演唱会传奇，就是要挑战自己的不可能，一心一意要给全世界歌迷一生一次只有五月天能做到的演唱会。\r\n</p>\r\n<p style=\"text-align:center;\">\r\n\t<img title=\"五月天 LIFE [ 人生无限公司 ] 世界巡回演唱会-沈阳站  2017 MAYDAY LIFE TOUR\" alt=\"五月天 LIFE [ 人生无限公司 ] 世界巡回演唱会-沈阳站  2017 MAYDAY LIFE TOUR\" width=\"550\" height=\"345\" /> \r\n</p>\r\n<p>\r\n\t&nbsp; &nbsp; 五月天正式宣布将在五月天成军20年的2017年，<strong>7月22日于陕西省体育场与五迷们一同“五月天”</strong>，展开全新世界巡回演唱会—LIFE《人生无限公司》。主办单位初估，此次五月天全新世界巡回演唱会—LIFE《人生无限公司》，短短时间目前全世界各地主办方邀约已突破100场，势必超越目前五月天“场次最多”的《诺亚方舟》两年半82场的纪录。\r\n</p>\r\n<div style=\"text-align:center;\">\r\n\t<img title=\"五月天 LIFE [ 人生无限公司 ] 世界巡回演唱会-沈阳站  2017 MAYDAY LIFE TOUR\" alt=\"五月天 LIFE [ 人生无限公司 ] 世界巡回演唱会-沈阳站  2017 MAYDAY LIFE TOUR\" width=\"550\" height=\"345\" /> \r\n</div>\r\n&nbsp;\r\n &nbsp; 上次\"Just Rock \r\nIt\"演唱会让广大歌迷哀呼“一票难求”，今年五月天火力全开将在内地更多城市开唱，不断爆表激增的其他城市场次将一一公布，势必会引爆新一轮的演唱会抢票狂潮。而抢先公布的11城市高雄、广州、厦门......大连、香港等共计24场，就已动员50+万人次，五月天“20周年第10代”世界巡回，几乎可以确定将再打破《诺亚方舟》全世界264万人登船的辉煌纪录。\r\n<p style=\"text-align:center;color:#666666;font-family:宋体;font-size:14px;background-color:#FFFFFF;\">\r\n\t<img title=\"五月天 LIFE [ 人生无限公司 ] 世界巡回演唱会-沈阳站  2017 MAYDAY LIFE TOUR\" alt=\"五月天 LIFE [ 人生无限公司 ] 世界巡回演唱会-沈阳站  2017 MAYDAY LIFE TOUR\" width=\"550\" height=\"345\" /> \r\n</p>\r\n&nbsp;\r\n &nbsp; \r\n就在LIFE《人生无限公司》再创新高改写全新纪录前，五月天的第9张录音室专辑《自传》抢先传出捷报，仅发行五个月就夺下五大金榜、博客来销售榜以及诚品音乐馆三大实体CD专辑通路，成为2016年度销售排行总冠军。《自传》作为五月天倒数第二张实体CD专辑，在这个数位音乐成为主流、实体CD专辑逐渐成为濒临绝种保育类记忆的时代，五月天对音乐的顽固坚持挑动歌迷的珍惜感动，一起再一次为华语乐坛写下令人称奇的新一页“自传”。\r\n<p style=\"text-align:center;\">\r\n\t<img title=\"五月天 LIFE [ 人生无限公司 ] 世界巡回演唱会-沈阳站  2017 MAYDAY LIFE TOUR\" alt=\"五月天 LIFE [ 人生无限公司 ] 世界巡回演唱会-沈阳站  2017 MAYDAY LIFE TOUR\" width=\"550\" height=\"345\" /> \r\n</p>\r\n<div style=\"text-align:center;\">\r\n\t<strong>“生命中最好的一天，一生活一场五月天”</strong> \r\n</div>\r\n<div>\r\n\t　　五月天全新世界巡回LIFE《人生无限公司》将于<strong>7月22日西安开唱</strong>！从高雄世运主场馆开跑的全新世界巡回演唱会LIFE《人生无限公司》陆续在各地遍地开花，可以预见五月天成军20周年的2017又将是全球五迷目不暇给的五月天Live年！\r\n</div>";
}

- (NSString *)html3 {
    return @"<strong><br />\r\n　　\"当红炸子鸡\"林宥嘉自2015退伍回归歌坛后，马不停蹄推出许多音乐作品，不论是戏剧单曲〈兜圈〉、超强口碑专辑《今日营业中》、翻唱歌曲〈成全〉，以及电影单曲〈全世界谁倾听你〉等，音乐势力不断爆发，获得众多歌迷热烈回响。2016开始进行的《The\r\n Great Yoga》世界巡回演唱会，半年来场场爆满，一路走过高雄、北京、上海、重庆等9个城市。<br />\r\n<p>\r\n\t　　2017年最新消息，让歌迷期待已久的『The Great Yoga 2017』世界巡回演唱会即将全力开跑，这意味着林宥嘉的 live魅力即将再次占领歌迷的世界！<strong>林宥嘉开心表示，『The Great Yoga 2017』巡演不论在舞台视觉和硬件上都会再升级，打造林宥嘉专属的迷幻乐园，也会增加《今日营业中》专辑曲目和其他单曲。</strong> \r\n</p>\r\n<p style=\"text-align:center;\">\r\n\t<strong><img src=\"https://static.dmcdn.cn/cfs/fun/content/2017/07/03/16/5388137d-01f8-4dbf-aab9-03c0887d1efb.jpg\" width=\"426\" height=\"278\" alt=\"\" /><br />\r\n</strong> \r\n</p>\r\n<p style=\"text-align:center;\">\r\n\t<strong><img src=\"https://static.dmcdn.cn/cfs/fun/content/2017/07/03/16/831d6815-6f3e-417c-8aa8-e1c55662af23.jpg\" width=\"387\" height=\"257\" alt=\"\" /><br />\r\n</strong> \r\n</p>\r\n<p>\r\n\t　　有人说，林宥嘉的音乐风格无法定义，时而冷酷迷离，时而温暖亲密，时而感怀忧伤，时而搞怪幽默。听林宥嘉唱歌，等于把自己交给他，在他自成一派的音乐世界里无法自制地放松浮游，犹如在做一场身心灵的瑜伽。林宥嘉在音乐中玩乐的技能越发伸展自如，可塑性也越来越高。尤其服兵役期间的潜心创作，更让人感受到林宥嘉在音乐中是不受拘束，自由自在的。从他的音乐作品中，仿佛可以看到快乐的他在挑战各式动作，举凡折迭、伸展、跳跃、倒立、飘浮...都玩得不亦乐乎，犹如在做瑜伽！因此来看林宥嘉的演唱会，换个有趣的方式来形容，等于来做一场万人集体瑜伽！\r\n</p>\r\n<p style=\"text-align:center;\">\r\n\t<img src=\"https://static.dmcdn.cn/cfs/fun/content/2017/07/03/16/5e26db93-4b7b-4b2b-8bc0-d27cd0c1b099.jpg\" width=\"438\" height=\"289\" alt=\"\" /> \r\n</p>\r\n<p style=\"text-align:center;\">\r\n\t<img src=\"https://static.dmcdn.cn/cfs/fun/content/2017/07/03/16/35f23ee7-3cbc-4a81-8bbd-16cb02448769.jpg\" width=\"600\" height=\"394\" alt=\"\" /> \r\n</p>\r\n　　<strong>林宥嘉『The Great Yoga 2017』世界巡回演唱会特色就是可以让大家自由选择最自在的动作与方式，去感受林宥嘉，这场演唱会不是要给你一个林宥嘉的空间</strong>，而是要邀请你一起创造你与林宥嘉的共同空间。对林宥嘉来说，在即将迈入三十岁的人生阶段开演唱会也是他\"最好\"的状态。比起前三次演唱会的时期，现在的他更知道自己可以扮演什么角色，也更有自信别人可以从他的音乐中获得什么。<br />\r\n<p>\r\n\t　　<strong>这次林宥嘉『The Great Yoga 2017』世界巡回演唱会，你除了可以听到你最熟悉的林宥嘉经典神曲，你也会听到更多你还没听过的全新林宥嘉。</strong>林宥嘉将以他独特的\"神瑜伽\"姿势，带领大家创造一个最了不起的音乐运动空间！\r\n</p>\r\n<p style=\"text-align:center;\">\r\n\t<img src=\"https://static.dmcdn.cn/cfs/fun/content/2017/07/03/16/dd1b46bc-0022-4a8a-a129-37399cd03e67.jpg\" width=\"600\" height=\"394\" alt=\"\" /> \r\n</p>\r\n<p>\r\n\t　　林宥嘉2016《The Great Yoga》世界巡回演唱会叫好叫座，2017年将盛大加码，展现林宥嘉最好、最真诚的音乐魂！\r\n</p>\r\n<p style=\"text-align:center;\">\r\n\t<img src=\"https://static.dmcdn.cn/cfs/fun/content/2017/07/03/16/2899a169-c9ca-4872-8530-30b7387c859c.jpg\" width=\"426\" height=\"278\" alt=\"\" /> \r\n</p>\r\n<strong> \r\n<div>\r\n</div>\r\n</strong><br />\r\n</strong> \r\n<p>\r\n\t<br />\r\n</p>";
}
@end
