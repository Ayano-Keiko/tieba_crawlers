require 'json'
require 'uri'
require 'net/http'


def spider(kw, numPages)
    headers = {
        :connection => 'keep-alive',
        :host => 'tieba.baidu.com',
        :ua =>
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36'
    }
    titleMatch = /<title>(.*?)<\/title>/  # html title re pattern

    # iteration all pages
    for i in 0..numPages do
        # pageIndice = i * 50;
        # puts baseURL, pageIndice;
        # set uri
        uri = URI( URI::Parser.new.escape("https://tieba.baidu.com/f?kw=#{kw}&ie=utf-8&pn=#{i * 50}") );
        
        # send get request
        
        response = Net::HTTP.get_response(uri, headers)

        if response.code != 200
            puts "Security Issue #{response.code}"
            break
        end

        content = response.body
        content = content.force_encoding('UTF-8')
        
        # puts req.class
        title = content[titleMatch, 1]
        
        if title == '百度安全验证'
            # 彈窗驗證碼
            puts "Security Issue"
        else
            puts content
        end
        
        break;
    end
end

if __FILE__ == $0
    
    text = File.read('./kw.json');
    config = JSON.parse(text)
    
    kw = config['name']  # 貼吧名稱
    numPages = config['page']  # 獲取頁數 
    
    # puts "Crawling start at #{kw} and will collect #{numPages} pages"
    spider(kw, numPages)
end