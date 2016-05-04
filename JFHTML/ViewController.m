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

@interface ViewController () <JFHTMLParserDelegate>{

    JFHTMLParser *_htmlParser;
    NSXMLParser *_xmlParser;
    
    JFHTMLAttributedStringBuilder *_builder;
}
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self parseHTML];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)parseHTML {
    NSString *htmlString = @"</p><p>`start`</p><h3 label=\"jtwsm-title\" class=\"jtwsm-title\" id>这是标题</h3><p>的撒发的撒的撒发大水<br/><br/><br/><br/></p><p><img width=\"100%\" src=\"http://static.damai.cn/wanimg/64e4d7d1-7765-4e20-ab8d-d51d69ce3fd9.jpg\"/><br></p><p><img width=\"100%\" src=\"http://static.damai.cn/wanimg/5830b131-36a0-49d6-a09a-0a106fbb9eb3.jpg\"/></p><p><br></p><p>&nbsp;&nbsp;&nbsp;大发大水放大书法的放大书法发啊发反馈大了；解放大路；手机发了扩大加快劳动纠纷离开的肌肤的看法鞠东克拉风景的<br></p><p>回车段落</p><p>大发大发空间的两发大水</p><p>－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－</p><h3 label=\"jtwsm-title\" class=\"jtwsm-title\">今年适逢奥运年<p>各大影像厂商也都推出了旗下的重磅新机，在年初CES2016前夕尼康就新发布了最新款全画幅旗舰数码单反相机D5，比起之前D4到D4S，又或者更早D3到D3S或D3X的小幅提升，这次新发布的D5算得上真正具有革新意义的大升级，可以说是“意料之外的惊喜”。尼康D5不仅使用了EXPEED 5处理器，同时从感光元件到对焦系统都进行全方位的提升，153点AF对焦系统和最高ISO 3280000的感光度，这在单反诞生至今从未出现过，完全可以用变态来形容。那么作为一款顶级的机型尼康D5究竟有多强劲？不妨一起来看看今天的评测吧。</p><p>300W感光度+153点AF对焦系统 尼康D5 机身 售价：48499元&gt;&gt;购买链接&nbsp;(17人感兴趣)</p><p><br></p><p><img width=\"100%\" src=\"http://static.damai.cn/wanimg/f75b9e73-7112-4572-b4b3-fdfd07aca3b6.jpg\"/></p><p>尼康 D5 单反机身<br></p><h3 label=\"jtwsm-title\" class=\"jtwsm-title\">更多商家国美在<p>的撒发大水<br></p><h3 label=\"jtwsm-title\" class=\"jtwsm-title\">￥47198&nbsp;|&nbsp;京东商城：￥47999&nbsp;|&nbsp;亚马逊：￥52888<p>尼康Nikon D5主要升级点和规格：</p><p>· 全新的2080万有效像素全画幅CMOS感光元件<br>· 拥有高达ISO 102400的标准感光度，还可扩展至Hi 5（相当于ISO 3280000）<br>· 全新Multi-CAM 20000自动对焦模块，提供153个对焦点（99点为十字型感应器）</p><p><br></p><p><br></p>";
    
    for (int i = 0; i < 1002; i++) {
        htmlString = [htmlString stringByAppendingString:@"a"];
    }
    htmlString = [htmlString stringByAppendingString:@"#end</p>"];
    
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
   
    _builder = [[JFHTMLAttributedStringBuilder alloc] initWithHTML:data];
    NSAttributedString *attributedText = [_builder build];
    
    self.textView.attributedText = attributedText;
//    [self.textView sizeToFit];
    
//    self.textLabel.attributedText = attributedText;
//    [self.textLabel sizeToFit];
//    [self.view layoutIfNeeded];
//    _htmlParser = [[JFHTMLParser alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    _htmlParser.delegate = self;
//    [_htmlParser parse];
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

@end
