#coding:UTF-8
def select_device
    #lsコマンド実行
    ls_dev = `ls -l /dev/ttyAC*`#OSで異なる可能性アリ
    device_list = ls_dev.split("\n")
    if device_list.empty? then
        puts "DEVICE IS NOT FOUND"
        return nil
    end
    #端末一覧表示処理
    num = 1
    device_list.each do |device|
        puts "[#{num}]:#{device}"
        num += 1
    end
    #ユーザ入力受付
    input_num = gets.chomp.to_i
    if input_num.between?(1, device_list.size) then
        device_info = device_list[input_num-1].split(' ')
        device_name = device_info[9]#OSで異なる可能性アリ
        return device_name
    else
        return nil
    end
end