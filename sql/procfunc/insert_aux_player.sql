drop temporary table if exists aux_player;
create temporary table aux_player (
    page_order varchar(32),
    name_ja varchar(32),
    zone_name varchar(32),
    obtention_desc varchar(100),
    attri varchar(32),
    positi varchar(32),
    lv varchar(32),
    gp int,
    tp int,
    kick int,
    body int,
    control int,
    guard int,
    speed int,
    stamina int,
    guts int,
    freedom int,
    h1 varchar(32),
    h2 varchar(32),
    h3 varchar(32),
    h4 varchar(32),
    name_romanji varchar(32)
);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/a.csv'
into table aux_player 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(page_order, name_ja, zone_name, obtention_desc, attri, positi, lv, gp, tp,
    kick, body, control, guard, speed, stamina, guts, freedom, h1, h2, h3, 
    h4, name_romanji);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/ka.csv'
into table aux_player 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(page_order, name_ja, zone_name, obtention_desc, attri, positi, lv, gp, tp,
    kick, body, control, guard, speed, stamina, guts, freedom, h1, h2, h3, 
    h4, name_romanji);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/sa.csv'
into table aux_player 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(page_order, name_ja, zone_name, obtention_desc, attri, positi, lv, gp, tp,
    kick, body, control, guard, speed, stamina, guts, freedom, h1, h2, h3, 
    h4, name_romanji);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/ta.csv'
into table aux_player 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(page_order, name_ja, zone_name, obtention_desc, attri, positi, lv, gp, tp,
    kick, body, control, guard, speed, stamina, guts, freedom, h1, h2, h3, 
    h4, name_romanji);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/na.csv'
into table aux_player 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(page_order, name_ja, zone_name, obtention_desc, attri, positi, lv, gp, tp,
    kick, body, control, guard, speed, stamina, guts, freedom, h1, h2, h3, 
    h4, name_romanji);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/ha.csv'
into table aux_player 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(page_order, name_ja, zone_name, obtention_desc, attri, positi, lv, gp, tp,
    kick, body, control, guard, speed, stamina, guts, freedom, h1, h2, h3, 
    h4, name_romanji);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/ma.csv'
into table aux_player 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(page_order, name_ja, zone_name, obtention_desc, attri, positi, lv, gp, tp,
    kick, body, control, guard, speed, stamina, guts, freedom, h1, h2, h3, 
    h4, name_romanji);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/ya.csv'
into table aux_player 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(page_order, name_ja, zone_name, obtention_desc, attri, positi, lv, gp, tp,
    kick, body, control, guard, speed, stamina, guts, freedom, h1, h2, h3, 
    h4, name_romanji);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/ra.csv'
into table aux_player 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(page_order, name_ja, zone_name, obtention_desc, attri, positi, lv, gp, tp,
    kick, body, control, guard, speed, stamina, guts, freedom, h1, h2, h3, 
    h4, name_romanji);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/wa.csv'
into table aux_player 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(page_order, name_ja, zone_name, obtention_desc, attri, positi, lv, gp, tp,
    kick, body, control, guard, speed, stamina, guts, freedom, h1, h2, h3, 
    h4, name_romanji);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/ff.csv'
into table aux_player 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(page_order, name_ja, zone_name, obtention_desc, attri, positi, lv, gp, tp,
    kick, body, control, guard, speed, stamina, guts, freedom, h1, h2, h3, 
    h4, name_romanji);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/national.csv'
into table aux_player 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(page_order, name_ja, zone_name, obtention_desc, attri, positi, lv, gp, tp,
    kick, body, control, guard, speed, stamina, guts, freedom, h1, h2, h3, 
    h4, name_romanji);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/eilia.csv'
into table aux_player 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(page_order, name_ja, zone_name, obtention_desc, attri, positi, lv, gp, tp,
    kick, body, control, guard, speed, stamina, guts, freedom, h1, h2, h3, 
    h4, name_romanji);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/other.csv'
into table aux_player 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(page_order, name_ja, zone_name, obtention_desc, attri, positi, lv, gp, tp,
    kick, body, control, guard, speed, stamina, guts, freedom, h1, h2, h3, 
    h4, name_romanji);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/ffi1.csv'
into table aux_player 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(page_order, name_ja, zone_name, obtention_desc, attri, positi, lv, gp, tp,
    kick, body, control, guard, speed, stamina, guts, freedom, h1, h2, h3, 
    h4, name_romanji);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/ffi2.csv'
into table aux_player 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(page_order, name_ja, zone_name, obtention_desc, attri, positi, lv, gp, tp,
    kick, body, control, guard, speed, stamina, guts, freedom, h1, h2, h3, 
    h4, name_romanji);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/ogre.csv'
into table aux_player 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(page_order, name_ja, zone_name, obtention_desc, attri, positi, lv, gp, tp,
    kick, body, control, guard, speed, stamina, guts, freedom, h1, h2, h3, 
    h4, name_romanji);

/*
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
*/
drop temporary table if exists aux_player_f;
create temporary table aux_player_f (
    name_ja varchar(32)
);
load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/af.csv'
into table aux_player_f
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(name_ja);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/kaf.csv'
into table aux_player_f
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(name_ja);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/saf.csv'
into table aux_player_f
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(name_ja);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/taf.csv'
into table aux_player_f
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(name_ja);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/naf.csv'
into table aux_player_f
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(name_ja);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/haf.csv'
into table aux_player_f
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(name_ja);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/maf.csv'
into table aux_player_f
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(name_ja);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/yaf.csv'
into table aux_player_f
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(name_ja);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/raf.csv'
into table aux_player_f
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(name_ja);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/waf.csv'
into table aux_player_f
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(name_ja);

/*
load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/fff.csv'
into table aux_player_f
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(name_ja);
*/

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/nationalf.csv'
into table aux_player_f
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(name_ja);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/eiliaf.csv'
into table aux_player_f
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(name_ja);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/otherf.csv'
into table aux_player_f
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(name_ja);

/*
load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/ffi1f.csv'
into table aux_player_f
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(name_ja);
*/

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/ffi2f.csv'
into table aux_player_f
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(name_ja);

/*
load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/ogref.csv'
into table aux_player_f
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
(name_ja);
*/

/*
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
*/

/*
select count(name_ja) 'aux_player', name_ja from aux_player group by name_ja 
    having count(name_ja)>1;

select '----------';

select count(*) 'aux_player_f' from aux_player_f;
select count(distinct name_ja) 'aux_player_f distinct' from aux_player_f;
*/

/*
こうこ (first one is not female)

pending:
+----------------+-----------------+
|              2 | あらた          |
|              2 | きりがくれ      |
|              2 | ごういん        |
|              2 | じもん          |
|              2 | つとむ          |
|              2 | なるかみ        |
|              2 | まきや          |
|              2 | ゆうこく        |
|              2 | ザック          |
|              2 | ゾーハン        |
|              2 | デメテル        |
|              2 | ヒート          |
|              2 | ファン          |
|              2 | ヘラ            |
+----------------+-----------------+


reviewed:
みどりかわ
あらや
かも
こうこ
ふぶき 2 
クリプト        
ケイソン        
ケンビル
スオーム
ゼル            
タイタン   
ファドラ
マキュア
メトロン
モール
あいだ
いかり
うきしま
かみむら
すがた
テーラー
なかま
バトラー
ひびき
ビルダー
マスター
ロココ
えんどう
かぜまる
かべやま
つなみ
こぐれ
とびたか
ふどう
ふぶき
ごうえんじ
とらまる
ライデン
きどう
ヒロト
たちむかい
さくま
そめおか
カノン


*/
