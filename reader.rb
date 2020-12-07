#coding:UTF-8
require "bundler/setup"
require 'sqlite3'
#SETTING
DB_NAME = "./db/igss_hq.db" #DB

#フラグリセット関数
def reset_flags
    begin
        db = SQLite3::Database.new( DB_NAME )
    rescue =>e
        p e.message
        return
    end
    sql = 'UPDATE hq_jyoukyou SET mark = 0 WHERE mark = 1'
    db.execute(sql)
    db.close
end

#HQフラグチェック関数
def check_flags
    begin
        db = SQLite3::Database.new( DB_NAME )
    rescue =>e
        p e.message
        return
    end
    #未処理のレコードを全て取得
    records = Array.new()
    sql = 'SELECT * FROM hq_jyoukyou WHERE mark = 0 ORDER BY h_jikoku ASC'
    db.execute(sql) do |record|
        #markカラムの要素を削除
        record.delete_at 0
        records.push(record.join(','))
    end

    if records.empty? then return nil end
    #未処理の最も古いレコードのROWIDを取得
    sql = 'SELECT ROWID FROM hq_jyoukyou WHERE mark = 0 LIMIT 1'
    head = db.get_first_value(sql)
    tail = head+records.size-1
    #処理済みとして更新
    sql = 'UPDATE hq_jyoukyou SET mark = 1 WHERE ROWID BETWEEN ? AND ?'
    db.execute(sql, head, tail)
    db.close
    return records
end

#STBフラグチェック関数
def check_flag
    begin
        db = SQLite3::Database.new( DB_NAME )
    rescue =>e
        p e.message
        return
    end
    #未処理のレコードを1つ取得
    sql = 'SELECT * FROM stb_jyoukyou WHERE stb_mark = 0 ORDER BY stb_jikoku ASC LIMIT 1'
    record = db.execute(sql)
    #p record.class 表示されない
    if record == nil then return nil end
    
    #markカラムの要素を削除
    record.delete_at 0
    record.join(',')
    #未処理の最も古いレコードを処理済みとして更新
    sql = 'UPDATE stb_jyoukyou SET stb_mark = 1 WHERE stb_mark = 0 ORDER BY stb_jikoku ASC LIMIT 1'
    db.execute(sql)
    db.close
    return record
end