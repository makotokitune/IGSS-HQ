#coding:UTF-8
#ATコマンド
def create_at (record)
    return "AT"
end
#ATGコマンド
def create_atg (record)
    return "ATG"
end
#ATBコマンド
def create_atb (record)
    data = record.split(',')
    type = data[0]
    p  record.bytes
    p  record.bytes.size

    case type
    when "jalt" then
        p  record.bytes
        record_byte = record.bytes.map{ "%02X" }
        message = sprintf("%02X%02X%s", 1, record_byte.size, record)
        atcmd = "ATB=" + message
        return atcmd
    when "palt"
        record_byte = record.bytes.map{ "%02X" }
        message = sprintf("%02X%02X%s", 1, record_byte.size, record)
        atcmd = "ATB=" + message
        return atcmd
    else
        return nil
    end
end