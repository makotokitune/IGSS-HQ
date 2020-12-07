require "bundler/setup"
require "nokogiri"

def build_old_hq_html(info)
    html = Nokogiri::HTML::DocumentFragment.parse("")
    Nokogiri::HTML::Builder.with(html) do |t|
        t.html lang:"ja" do
            t.head do
                t.meta charset:"UTF-8"
                t.link rel:"stylesheet", href:"./../css/hq.css"
                t.title "emergency"
            end
            t.div class:"mv-video" do
                t.div class:"mv-video-copy" do
                    t.p info
                end
            end
        end
    end
    File.open("./view/hq.html", mode = "w"){ |f|
        f.write(html.to_html)  # ファイルに書き込む
    }
end


def build_hq_html(info)
    info = sprintf("　緊急情報：%s", info)
    html = Nokogiri::HTML::DocumentFragment.parse("")
    Nokogiri::HTML::Builder.with(html) do |t|
        t.html lang:"ja" do
            t.head do
                t.meta charset:"UTF-8"
                t.link rel:"stylesheet", href:"./base.css"
                t.title "emergency"
            end
            t.body do
                t.div class:"wrapper clearfix" do
                    t.div class:"bunkatsu6" do
                        t.img alt:"", src:"gaibu01.jpg"
                    end
                    t.div class:"bunkatsu6" do
                        t.img alt:"", src:"uryou01.jpg"
                    end
                    t.div class:"bunkatsu6" do
                        t.img alt:"", src:"fuuryoku01.jpg"
                    end
                end
                t.div class:"wrapper clearfix" do
                    t.div class:"bunkatsu6" do
                        t.img alt:"", src:"kiatsu01.jpg"
                    end
                    t.div class:"bunkatsu6" do
                        t.img alt:"", src:"uryou02.jpg"
                    end
                    t.div class:"bunkatsu6" do
                        t.img alt:"", src:"suii01.jpg"
                    end
                end
                t.div id:"footer_box" do
                    # t.img alt:"", height:"140", src:"footer01.jpg", width:"1920"
                    t.h2 info, class:"moji"
                end
            end
        end
    end
    File.open("./view/hq.html", mode = "w"){ |f|
        f.write(html.to_html)  #ファイルに書き込む
    }
end