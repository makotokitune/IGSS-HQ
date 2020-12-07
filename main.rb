#coding:UTF-8
require "bundler/setup"
require "selenium-webdriver"
require 'serialport'
require 'logger'
require 'warning'
require './device.rb'
require './reader.rb'
require './atcmd.rb'
require './builder.rb'

#SETTING
SERIAL_BPS = 115200
SERIAL_DATABIT = 8
SERIAL_STOPBIT = 1

HQ_HTML_PATH = "C:\\IGSS\\hq\\view\\hq.html"

TX_INTERVAL = 30

serial_port = nil
loop do
    serial_port = select_device
    if serial_port!=nil then
        puts "#{serial_port.to_i + 1} SELECTED"
        break
    end
end

log = Logger.new('./log/hq.log')
Warning.ignore /rb_secure/
msg = "現在情報はありません"
build_hq_html(msg)

option = Selenium::WebDriver::Chrome::Options.new(options: {"excludeSwitches" => ["enable-automation"]})
option.add_argument('--kiosk')
driver = Selenium::WebDriver.for :chrome, options: option
driver.navigate.to  "file://" + HQ_HTML_PATH

loop do
    begin
        sp = SerialPort.new(serial_port, SERIAL_BPS , SERIAL_DATABIT , SERIAL_STOPBIT)
    rescue => e
        log.error("CANNOT OPEN SERIALPORT")
        p e.message
        log.debug("RETRY OPENING SERIALPORT")
        puts "RETRY OPENING SERIALPORT"
        sp.close
        retry
    end
    #フラグリセット
    reset_flags
    #HQフラグチェック
    records = check_flags
    if records==nil then 
        sp.close
        next
    end
    #未処理レコード数の表示
    puts "Found #{records.size} Unprocessed Record"
    #見つかった未処理レコードそれぞれに対して行う
    records.each do |record|
        rain_info = record.split(',')[5]
        p rain_info
        build_hq_html(rain_info)
        #ATBコマンド生成
        p record
        atcmd = create_atb(record)
        p atcmd
        #ATBコマンド送信
        sp.puts(atcmd.encode(Encoding::UTF_8))
        # sp.puts(atcmd)
        p atcmd
        driver.navigate.to  "file://" + HQ_HTML_PATH
        log.debug("ATCommand:#{atcmd}")
        sleep TX_INTERVAL
    end
    sleep 1
    sp.close
end