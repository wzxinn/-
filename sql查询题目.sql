
--1.与“张三”同乡的男生姓名
select sname 姓名 from student where ssex = '男' and snativeplace =(
select snativeplace from student where sname = '张三')

--2.选修了马六老师所讲课程的学生人数

 select count(sid) 总人数 from mark where cid in (
 select cid from course where tid = (
 select tid from teacher where tname = '马六'))

--3.查询没学过“马”姓老师课的同学的学号、姓名

 select sid 学号,sname 姓名 from student where sid not in (
 select sid from mark where cid=(
 select cid from course where tid = (
 select tid from teacher where tname like '马%')))
 
 --4.“数学”课程得最高分的学生姓名、性别
select sname 姓名,ssex 性别 from student where sid in(
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='数学')))

--5.统计每门课程的平均成绩,并按照成绩降序排序
select round(avg(cmark),1) 平均成绩 from mark group by cid order by avg(cmark) demark

--6.子查询实现查询‘2班’"张三"同学的"英语"成绩 
select cmark 英语成绩 from mark where sid = (
select sid from student where sname = '张三' and sclass='2班') and cid = (
select cid from course where cname = '英语')

--7.查询“福建”地区学生所选修的全部课程名称
select cid 课程号,cname 课程名称 from course where cid in (
select cid from mark where sid in 
(select sid from student where snativeplace = '福建'))

--8.查询所在班级和该班内学生的年龄之和,对该班级中每个人的年龄进行比对
--(要求大于20岁的人参与统计)
select smajor 专业名,sclass 班级,sum(sage) 年龄之和
from student where sage>20 group by sclass,smajor 

--10.用子查询实现查询选修“数学”课的全部学生的高等数学总成绩
select sum(cmark) 总成绩 from mark where cid = (
select cid from course where cname='数学')

--11.用子查询实现查询选修“数学”课的全部学生的所有课程总成绩
select sum(cmark) 总成绩,sid 学号 from mark where sid = (
select sid from course where cid = (
select cid from course where cname='数学') group by sid) group by sid order by sid

--12.请用两种方法实现:查找所有成绩都在68分以上的学生姓名
--(1)
select sname 姓名 from student 
where sid in(select distinct sid from mark 
group by sid having min(cmark)>=68)

--(2)
select sname 姓名 from student 
where sid not in (
select distinct sid from mark where cmark <68)

--13.查找至少2门成绩在80分以上的学生姓名
select sname 姓名 from student 
where sid in(select sid from mark
where cmark>80 group by sid having count(sid)>=2)

--14.查询至少有一门课与张三同学所学相同的同学的学号和姓名
select sid 学号,sname 姓名 from student 
where sid in(select sid from mark where cid in (
select cid from mark where sid = (
select sid from student where sname='张三')))

--15.没有选修“数学”课的学生的姓名
select sname 姓名 from student where 
sid not in (select sid from mark where cid=(
select cid from course where cname='数学'))

--16.查询个人总成绩小于平均总成绩的学生姓名
select sname 姓名 from student
where sid in (select sid from mark group by sid
having sum(cmark)<(select avg(sum(cmark))
from mark group by sid))

--17.用子查询实现张三在其各科成绩中最高分成绩所对应的课程号和成绩 
select cid 课程号,cmark 成绩 from mark
where sid=(select sid from student
where sname='张三') and cmark=(select max(cmark) from mark 
where sid=(select sid from student where sname='张三'))

--18.找出张三的最高分和最低分以及对应的课程名
select cmark 分数,cname 课程名 from mark m,course c
where c.cid = m.cid and sid=(
select sid from student where sname='张三') and(cmark=(
select max(cmark) from mark where sid=(
select sid from student where sname='张三'))
or cmark=(
select min(cmark) from mark where sid=(
select sid from student where sname='张三')))

--19.哪些学生的各科成绩均高于张三
select sid 学号,sname 姓名 from student where sid in(
select sid from mark m1 where cmark>
(select cmark from mark m2 where sid=(
select sid from student where sname='张三')
and m1.cid=m2.cid) group by sid having count(sid)>=7);

--20.按平均成绩从高到低显示所有学生的“数学”、“英语”、“体育”三门的课程成绩
--(按如下形式显示:学生ID,数学,英语,体育,有效课程数,有效平均分 )

select mark.sid 学号,
(select cmark from MARK left join course on MARK.cid = course.cid where course.cname = '数学' and MARK.sid=mark.sid) 数学,
(select cmark from MARK left join course on MARK.cid = course.cid where course.cname = '英语' and MARK.sid=mark.sid) 英语,
(select cmark from MARK left join course on MARK.cid = course.cid where course.cname = '体育' and MARK.sid=mark.sid) 体育,
count(mark.cid) 有效课程数,round(avg(mark.cmark)) 有效平均分
from MARK mark group by sid order by avg(mark.cmark) demark;

--21.查询各科成绩前三名的记录:(不考虑成绩并列情况)
      select b.sid,b.cmark,b.cid from course a join mark b on a.cid=b.cid where 
      b.sid in (select sid from(
      select * from mark where cmark is not null order by cmark desc)
      where cid=a.cid and rownum<=3) order by b.cid,cmark desc

--22.查找至少2门成绩在80分以上的学生姓名
step1: select * from mark where cmark>80
step2: select sid,count(*) from (step1) group by sid having count(*)>=2

select sid,count(*) from (
select * from mark where cmark>80) group by sid having count(*)>=2

--23.查询没有选修数学课的上海学生姓名
select sid,sname from student 
where sid not in(
select distinct sid from mark where cid=(
select cid from course where cname='数学')) and snativeplace = '上海' 

--24.找出和张三所学课程完全相同的学生姓名
select sid,sname from student where sid in(
select distinct m1.sid from mark m1,mark m2 where m1.cid=m2.cid and m2.sid =(
select sid from student where sname='张三'))

--25.查询只选了数学和英语课的学生姓名
select sname from student where sid not in(
select sid from mark where cid not in (
select cid from course where cname!='数学' and cname!='英语'))

--26.找出计算机专业中均分最高的男生姓名
select sname from student 
where sid =(
select sid from mark group by sid having avg(cmark)=(
select max(avg(cmark)) from mark where sid in(
select sid from student where smajor='计算机' and ssex='男') group by sid))

--27.男生人数最多的地区中哪个学生年龄最大
select sname from student where sid=(select sid from student where snativeplace=(
select snativeplace from student group by snativeplace having count(*)=(
select max(count(*)) from student group by snativeplace )) 
and ssex='男' and sage=(select max(sage) from student where ssex='男' and snativeplace=
(select snativeplace from student group by snativeplace having count(*)=(
select max(count(*)) from student group by snativeplace )) group by ssex))

--28.数学状元的同班同学中男生均分最高的学生姓名
select sname from student where sid=(a)
a: select sid from mark where cmark=(b)
b: select max(cmark) from mark where cid = (c)
c: select cid from course where cname='数学'

--数学状元的学号
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='数学'))
--数学状元的专业
select smajor from student where sid=(
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='数学')))
--数学状元的班级
select sclass from student where sid=(
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='数学')))
--数学状元班同学的id
select sid from student where sclass=(
select sclass from student where sid=(
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='数学')))) and smajor=(
select smajor from student where sid=(
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='数学')))) 
--状元班的男生最高平均分
select max(avg(cmark)) from mark where sid in (
select sid from student where sclass=(
select sclass from student where sid=(
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='数学')))) and smajor=(
select smajor from student where sid=(
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='数学')))) and ssex='男') group by sid 

--结果
select sname from student where sid in(
select sid from mark group by sid having avg(cmark)=
(select max(avg(cmark)) from mark where sid in (
select sid from student where sclass=(
select sclass from student where sid=(
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='数学')))) and smajor=(
select smajor from student where sid=(
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='数学')))) and ssex='男') group by sid)
and smajor=(select smajor from student where sid=(
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='数学'))))
and sclass=(select sclass from student where sid=(
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='数学')))))

--结果
--29.请显示张三同学的数学和英语成绩,要求显示姓名，数学成绩，英语成绩
select sname 姓名,m1.cmark 英语,m2.cmark 数学 from student s,mark m1,mark m2
where s.sid=m2.sid and m1.cid=(select cid from course where cname='数学') and m2.cid=(
select cid from course where cname='英语') and m1.sid=(
select sid from student where sname='张三') and m2.sid=(
select sid from student where sname='张三')

--30.找出数学和英语均分最高的男生姓名
select sname from student where sid=(a)
--数学、英语男生的最高均分
select max(avg(cmark)) from mark
where cid = (select cid from course where cname='数学') or cid=(
select cid from course where cname='英语')
group by sid having sid in(select sid from student where ssex='男')
--数学、英语最高均分的男生学号
select sid from mark where cid =(
select cid from course where cname='数学') or cid=(
select cid from course where cname='英语') group by sid having avg(cmark)=(
select max(avg(cmark)) from mark
where cid = (select cid from course where cname='数学') or cid=(
select cid from course where cname='英语')
group by sid having sid in(select sid from student where ssex='男'))
--数学英语最高平均分的男生的姓名及数学、英语分数
select sname 姓名,m1.cmark 英语,m2.cmark 数学 from student s,mark m1,mark m2
where s.sid=(
select sid from mark where cid in(select cid from course where cname in('数学','英语'))
group by sid having avg(cmark)=(
select max(avg(cmark)) from mark
where cid in (select cid from course where cname in('数学','英语')) 
group by sid having sid in(select sid from student where ssex='男')))
and m1.cid=(select cid from course where cname='数学') 
and m2.cid=(select cid from course where cname='英语') 
and m1.sid=s.sid and m2.sid=m1.sid

--31.找出个人均分大于总均分（所有人所有课程的均分）的学生姓名
select sname 姓名 from student
where sid in (select sid from mark group by sid
having avg(cmark)>(select avg(cmark) from mark))

--32.上海地区哪门课的均分比福建差
select cid,avg(cmark) from mark where cid=(a)
--上海地区的各科平均分
(select cid,avg(cmark) from mark where sid in(
select sid from student where snativeplace ='上海') group by cid) 
--福建地区的各科平均分
(select cid,avg(cmark) from mark where sid in(
select sid from student where snativeplace ='福建') group by cid) 

select a.cid from 
(select cid,avg(cmark) amk from mark where sid in(
select sid from student where snativeplace ='上海') group by cid) a,
(select cid,avg(cmark) bmk from mark where sid in(
select sid from student where snativeplace ='福建') group by cid) b
where a.cid=b.cid and amk<bmk

--33.求各门课程去掉一个最高分和最低分后的平均分
select cid,round(avg(cmark)) from mark     
where cmark not in (select cmark from(select cmark from mark order by cmark) where rownum<2)   
and cmark not in (select cmark from(select cmark from mark where cmark is not null order by cmark desc) where rownum<2)  
group by cid order by cid

--34.在向mark表中插入数据的过程中晓明不小心插入了重复的学生选课纪录,因此需要将重复多余的数据删除,
--仅仅保留一条,请首先用查询语句找出除掉一条以外的重复数据以便删除之

DELETE from mark WHERE (cid) IN ( select cid from mark a where (select count(cid) from mark where cid=a.cid and sid=a.sid and cmark=a.cmark)>=2)
AND (sid) IN ( select sid from mark a where (select count(cid) from mark where cid=a.cid and sid=a.sid and cmark=a.cmark)>=2)
AND (cmark) IN ( select cmark from mark a where (select count(cid) from mark where cid=a.cid and sid=a.sid and cmark=a.cmark)>=2)
AND ROWID NOT IN (SELECT MIN(ROWID) from mark a where (select count(cid) from mark where cid=a.cid and sid=a.sid and cmark=a.cmark)>=2
group by cid);

