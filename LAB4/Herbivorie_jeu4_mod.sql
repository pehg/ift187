
DELETE FROM CarnetMeteo;

DROP TABLE CarnetMeteo CASCADE ;

CREATE TABLE CarnetMeteo
(
  journee       TEXT,
  temp_min      TEXT,
  temp_max      TEXT,
  humid_min     TEXT,
  humid_max     TEXT,
  precip        TEXT,
  nature_precip TEXT
);


INSERT INTO CarnetMeteo VALUES
('1000-23','-10','10','5','95','0','O'),	-- date: not a date
('1200-12-01','-10','10','5','95','0','O'),	-- date: invalid year
('16-06-2020','-10','10','5','95','0','O'),	-- date: wrong format
('2020/06/16','-10','10','5','95','0','O'),	-- date: wrong character for format
('123.23','-10','10','5','95','0','O'),	-- date: not a date
('1','-10','10','5','95','0','O'),	-- date: not a date
('text','-10','10','5','95','0','O'),	-- date: not a date
('','-10','10','5','95','0','O'),	-- date: empty
('2020-06-01','text','10','5','95','0','O'),	-- temp_min: not a number repr
('2020-06-01','2020-06-01','10','5','95','0','O'),	-- temp_min: not a number repr
('2020-06-01','-100','10','5','95','0','O'),	-- temp_min: temp out of range
('2020-06-01','100','10','5','95','0','O'),	-- temp_min: temp out of range
('2020-06-01','100.','10','5','95','0','O'),	-- temp_min: temp out of range
('2020-06-01','-100.','10','5','95','0','O'),	-- temp_min: temp out of range
('2020-06-01','+10','10','5','95','0','O'),	-- temp_min: ???
('2020-06-01','- 100','10','5','95','0','O'),	-- temp_min: ???
('2020-06-01','20+1','10','5','95','0','O'),	-- temp_min: not a number repr
('2020-06-01','20.14568','10','5','95','0','O'),	-- temp_min: invalid, only 2 decimals are accepted
('2020-06-01','50.01','10','5','95','0','O'),	-- temp_min: invalid, 50.00 is the maximum
('2020-06-01','','10','5','95','0','O'),	-- temp_min: empty
('2020-06-01','-10','text','5','95','0','O'),	-- temp_max: not a number repr
('2020-06-01','-10','2020-06-01','5','95','0','O'),	-- temp_max: not a number repr
('2020-06-01','-10','-100','5','95','0','O'),	-- temp_max: temp out of range
('2020-06-01','-10','100','5','95','0','O'),	-- temp_max: temp out of range
('2020-06-01','-10','100.','5','95','0','O'),	-- temp_max: temp out of range
('2020-06-01','-10','-100.','5','95','0','O'),	-- temp_max: temp out of range
('2020-06-01','-10','+10','5','95','0','O'),	-- temp_max: ???
('2020-06-01','-10','- 100','5','95','0','O'),	-- temp_max: ???
('2020-06-01','-10','20+1','5','95','0','O'),	-- temp_max: not a number repr
('2020-06-01','-10','20.14568','5','95','0','O'),	-- temp_max: invalid, only 2 decimals are accepted
('2020-06-01','-10','50.01','5','95','0','O'),	-- temp_max: invalid, 50.00 is the maximum
('2020-06-01','-10','','5','95','0','O'),	-- temp_max: empty
('2020-06-01','-10','10','20%','95','0','O'),	-- humid_min: ???
('2020-06-01','-10','10','-1','95','0','O'),	-- humid_min: value out of range
('2020-06-01','-10','10','101','95','0','O'),	-- humid_min: value out of range
('2020-06-01','-10','10','20.5','95','0','O'),	-- humid_min: ???
('2020-06-01','-10','10','text','95','0','O'),	-- humid_min: not a number repr
('2020-06-01','-10','10','20-1','95','0','O'),	-- humid_min: not a number repr
('2020-06-01','-10','10','2020-06-01','95','0','O'),	-- humid_min: not a number repr
('2020-06-01','-10','10','','95','0','O'),	-- humid_min: empty
('2020-06-01','-10','10','5','20%','0','O'),	-- humid_max: ???
('2020-06-01','-10','10','5','-1','0','O'),	-- humid_max: value out of range
('2020-06-01','-10','10','5','101','0','O'),	-- humid_max: value out of range
('2020-06-01','-10','10','5','20.5','0','O'),	-- humid_max: ???
('2020-06-01','-10','10','5','text','0','O'),	-- humid_max: not a number repr
('2020-06-01','-10','10','5','20-1','0','O'),	-- humid_max: not a number repr
('2020-06-01','-10','10','5','2020-06-01','0','O'),	-- humid_max: not a number repr
('2020-06-01','-10','10','5','','0','O'),	-- humid_max: empty
('2020-06-01','-10','10','5','95','1000','O'),	-- precip: value out of range
('2020-06-01','-10','10','5','95','text','O'),	-- precip: not a number repr
('2020-06-01','-10','10','5','95','20-1','O'),	-- precip: not a number repr
('2020-06-01','-10','10','5','95','100.1','O'),	-- precip: ???
('2020-06-01','-10','10','5','95','-1','O'),	-- precip: out of range
('2020-06-01','-10','10','5','95','5mm','O'),	-- precip: ???
('2020-06-01','-10','10','5','95','2020-06-01','O'),	-- precip: not a number repr
('2020-06-01','-10','10','5','95','','O'),	-- precip: empty
('2020-06-01','-10','10','5','95','0','text'),	-- Oture: invalid value
('2020-06-01','-10','10','5','95','0','n'),	-- Oture: ???
('2020-06-01','-10','10','5','95','0','1'),	-- Oture: invalid value
('2020-06-01','-10','10','5','95','0','78'),	-- Oture: Decimal ASCII value for N
('2020-06-01','-10','10','5','95','0','4E'),	-- Oture: Hex ASCII value for N
('2020-06-01','-10','10','5','95','0','2020-06-01'),	-- Oture: not a number repr
('2020-06-01','-10','10','5','95','0',''),	-- Oture: empty
('2020-08-01','-8','13','18','34','3','N'),	-- all valid
('2020-08-02','-3','18','25','30','0','O'),	-- all valid
('2020-08-03','0','15','20','40','5','P'),	-- all valid
('2020-08-04','-5','0','10','38','6','G'),	-- all valid
('2020-08-05','-5.5','0.12','10','38','6','G'),	-- all valid
('2020-08-06','-50.00','50.00','10','38','6','G')	-- all valid
;



