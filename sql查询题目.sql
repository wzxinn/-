
--1.�롰������ͬ�����������
select sname ���� from student where ssex = '��' and snativeplace =(
select snativeplace from student where sname = '����')

--2.ѡ����������ʦ�����γ̵�ѧ������

 select count(sid) ������ from mark where cid in (
 select cid from course where tid = (
 select tid from teacher where tname = '����'))

--3.��ѯûѧ����������ʦ�ε�ͬѧ��ѧ�š�����

 select sid ѧ��,sname ���� from student where sid not in (
 select sid from mark where cid=(
 select cid from course where tid = (
 select tid from teacher where tname like '��%')))
 
 --4.����ѧ���γ̵���߷ֵ�ѧ���������Ա�
select sname ����,ssex �Ա� from student where sid in(
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='��ѧ')))

--5.ͳ��ÿ�ſγ̵�ƽ���ɼ�,�����ճɼ���������
select round(avg(cmark),1) ƽ���ɼ� from mark group by cid order by avg(cmark) demark

--6.�Ӳ�ѯʵ�֪���ѯ��2�࡯"����"ͬѧ��"Ӣ��"�ɼ� 
select cmark Ӣ��ɼ� from mark where sid = (
select sid from student where sname = '����' and sclass='2��') and cid = (
select cid from course where cname = 'Ӣ��')

--7.��ѯ������������ѧ����ѡ�޵�ȫ���γ�����
select cid �γ̺�,cname �γ����� from course where cid in (
select cid from mark where sid in 
(select sid from student where snativeplace = '����'))

--8.��ѯ���ڰ༶�͸ð���ѧ��������֮��,�Ըð༶��ÿ���˵�������бȶ�
--(Ҫ�����20����˲���ͳ��)
select smajor רҵ��,sclass �༶,sum(sage) ����֮��
from student where sage>20 group by sclass,smajor 

--10.���Ӳ�ѯʵ�ֲ�ѯѡ�ޡ���ѧ���ε�ȫ��ѧ���ĸߵ���ѧ�ܳɼ�
select sum(cmark) �ܳɼ� from mark where cid = (
select cid from course where cname='��ѧ')

--11.���Ӳ�ѯʵ�ֲ�ѯѡ�ޡ���ѧ���ε�ȫ��ѧ�������пγ��ܳɼ�
select sum(cmark) �ܳɼ�,sid ѧ�� from mark where sid = (
select sid from course where cid = (
select cid from course where cname='��ѧ') group by sid) group by sid order by sid

--12.�������ַ���ʵ��:�������гɼ�����68�����ϵ�ѧ������
--(1)
select sname ���� from student 
where sid in(select distinct sid from mark 
group by sid having min(cmark)>=68)

--(2)
select sname ���� from student 
where sid not in (
select distinct sid from mark where cmark <68)

--13.��������2�ųɼ���80�����ϵ�ѧ������
select sname ���� from student 
where sid in(select sid from mark
where cmark>80 group by sid having count(sid)>=2)

--14.��ѯ������һ�ſ�������ͬѧ��ѧ��ͬ��ͬѧ��ѧ�ź�����
select sid ѧ��,sname ���� from student 
where sid in(select sid from mark where cid in (
select cid from mark where sid = (
select sid from student where sname='����')))

--15.û��ѡ�ޡ���ѧ���ε�ѧ��������
select sname ���� from student where 
sid not in (select sid from mark where cid=(
select cid from course where cname='��ѧ'))

--16.��ѯ�����ܳɼ�С��ƽ���ܳɼ���ѧ������
select sname ���� from student
where sid in (select sid from mark group by sid
having sum(cmark)<(select avg(sum(cmark))
from mark group by sid))

--17.���Ӳ�ѯʵ������������Ƴɼ�����߷ֳɼ�����Ӧ�Ŀγ̺źͳɼ� 
select cid �γ̺�,cmark �ɼ� from mark
where sid=(select sid from student
where sname='����') and cmark=(select max(cmark) from mark 
where sid=(select sid from student where sname='����'))

--18.�ҳ���������߷ֺ���ͷ��Լ���Ӧ�Ŀγ���
select cmark ����,cname �γ��� from mark m,course c
where c.cid = m.cid and sid=(
select sid from student where sname='����') and(cmark=(
select max(cmark) from mark where sid=(
select sid from student where sname='����'))
or cmark=(
select min(cmark) from mark where sid=(
select sid from student where sname='����')))

--19.��Щѧ���ĸ��Ƴɼ�����������
select sid ѧ��,sname ���� from student where sid in(
select sid from mark m1 where cmark>
(select cmark from mark m2 where sid=(
select sid from student where sname='����')
and m1.cid=m2.cid) group by sid having count(sid)>=7);

--20.��ƽ���ɼ��Ӹߵ�����ʾ����ѧ���ġ���ѧ������Ӣ��������������ŵĿγ̳ɼ���
--(��������ʽ��ʾ:ѧ��ID,��ѧ,Ӣ��,����,��Ч�γ���,��Чƽ���� )

select mark.sid ѧ��,
(select cmark from MARK left join course on MARK.cid = course.cid where course.cname = '��ѧ' and MARK.sid=mark.sid) ��ѧ,
(select cmark from MARK left join course on MARK.cid = course.cid where course.cname = 'Ӣ��' and MARK.sid=mark.sid) Ӣ��,
(select cmark from MARK left join course on MARK.cid = course.cid where course.cname = '����' and MARK.sid=mark.sid) ����,
count(mark.cid) ��Ч�γ���,round(avg(mark.cmark)) ��Чƽ����
from MARK mark group by sid order by avg(mark.cmark) demark;

--21.��ѯ���Ƴɼ�ǰ�����ļ�¼:(�����ǳɼ��������)
      select b.sid,b.cmark,b.cid from course a join mark b on a.cid=b.cid where 
      b.sid in (select sid from(
      select * from mark where cmark is not null order by cmark desc)
      where cid=a.cid and rownum<=3) order by b.cid,cmark desc

--22.��������2�ųɼ���80�����ϵ�ѧ������
step1: select * from mark where cmark>80
step2: select sid,count(*) from (step1) group by sid having count(*)>=2

select sid,count(*) from (
select * from mark where cmark>80) group by sid having count(*)>=2

--23.��ѯû��ѡ����ѧ�ε��Ϻ�ѧ������
select sid,sname from student 
where sid not in(
select distinct sid from mark where cid=(
select cid from course where cname='��ѧ')) and snativeplace = '�Ϻ�' 

--24.�ҳ���������ѧ�γ���ȫ��ͬ��ѧ������
select sid,sname from student where sid in(
select distinct m1.sid from mark m1,mark m2 where m1.cid=m2.cid and m2.sid =(
select sid from student where sname='����'))

--25.��ѯֻѡ����ѧ��Ӣ��ε�ѧ������
select sname from student where sid not in(
select sid from mark where cid not in (
select cid from course where cname!='��ѧ' and cname!='Ӣ��'))

--26.�ҳ������רҵ�о�����ߵ���������
select sname from student 
where sid =(
select sid from mark group by sid having avg(cmark)=(
select max(avg(cmark)) from mark where sid in(
select sid from student where smajor='�����' and ssex='��') group by sid))

--27.�����������ĵ������ĸ�ѧ���������
select sname from student where sid=(select sid from student where snativeplace=(
select snativeplace from student group by snativeplace having count(*)=(
select max(count(*)) from student group by snativeplace )) 
and ssex='��' and sage=(select max(sage) from student where ssex='��' and snativeplace=
(select snativeplace from student group by snativeplace having count(*)=(
select max(count(*)) from student group by snativeplace )) group by ssex))

--28.��ѧ״Ԫ��ͬ��ͬѧ������������ߵ�ѧ������
select sname from student where sid=(a)
a: select sid from mark where cmark=(b)
b: select max(cmark) from mark where cid = (c)
c: select cid from course where cname='��ѧ'

--��ѧ״Ԫ��ѧ��
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='��ѧ'))
--��ѧ״Ԫ��רҵ
select smajor from student where sid=(
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='��ѧ')))
--��ѧ״Ԫ�İ༶
select sclass from student where sid=(
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='��ѧ')))
--��ѧ״Ԫ��ͬѧ��id
select sid from student where sclass=(
select sclass from student where sid=(
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='��ѧ')))) and smajor=(
select smajor from student where sid=(
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='��ѧ')))) 
--״Ԫ����������ƽ����
select max(avg(cmark)) from mark where sid in (
select sid from student where sclass=(
select sclass from student where sid=(
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='��ѧ')))) and smajor=(
select smajor from student where sid=(
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='��ѧ')))) and ssex='��') group by sid 

--���
select sname from student where sid in(
select sid from mark group by sid having avg(cmark)=
(select max(avg(cmark)) from mark where sid in (
select sid from student where sclass=(
select sclass from student where sid=(
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='��ѧ')))) and smajor=(
select smajor from student where sid=(
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='��ѧ')))) and ssex='��') group by sid)
and smajor=(select smajor from student where sid=(
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='��ѧ'))))
and sclass=(select sclass from student where sid=(
select sid from mark where cmark=(select max(cmark) from mark where cid = (
select cid from course where cname='��ѧ')))))

--���
--29.����ʾ����ͬѧ����ѧ��Ӣ��ɼ�,Ҫ����ʾ��������ѧ�ɼ���Ӣ��ɼ�
select sname ����,m1.cmark Ӣ��,m2.cmark ��ѧ from student s,mark m1,mark m2
where s.sid=m2.sid and m1.cid=(select cid from course where cname='��ѧ') and m2.cid=(
select cid from course where cname='Ӣ��') and m1.sid=(
select sid from student where sname='����') and m2.sid=(
select sid from student where sname='����')

--30.�ҳ���ѧ��Ӣ�������ߵ���������
select sname from student where sid=(a)
--��ѧ��Ӣ����������߾���
select max(avg(cmark)) from mark
where cid = (select cid from course where cname='��ѧ') or cid=(
select cid from course where cname='Ӣ��')
group by sid having sid in(select sid from student where ssex='��')
--��ѧ��Ӣ����߾��ֵ�����ѧ��
select sid from mark where cid =(
select cid from course where cname='��ѧ') or cid=(
select cid from course where cname='Ӣ��') group by sid having avg(cmark)=(
select max(avg(cmark)) from mark
where cid = (select cid from course where cname='��ѧ') or cid=(
select cid from course where cname='Ӣ��')
group by sid having sid in(select sid from student where ssex='��'))
--��ѧӢ�����ƽ���ֵ���������������ѧ��Ӣ�����
select sname ����,m1.cmark Ӣ��,m2.cmark ��ѧ from student s,mark m1,mark m2
where s.sid=(
select sid from mark where cid in(select cid from course where cname in('��ѧ','Ӣ��'))
group by sid having avg(cmark)=(
select max(avg(cmark)) from mark
where cid in (select cid from course where cname in('��ѧ','Ӣ��')) 
group by sid having sid in(select sid from student where ssex='��')))
and m1.cid=(select cid from course where cname='��ѧ') 
and m2.cid=(select cid from course where cname='Ӣ��') 
and m1.sid=s.sid and m2.sid=m1.sid

--31.�ҳ����˾��ִ����ܾ��֣����������пγ̵ľ��֣���ѧ������
select sname ���� from student
where sid in (select sid from mark group by sid
having avg(cmark)>(select avg(cmark) from mark))

--32.�Ϻ��������ſεľ��ֱȸ�����
select cid,avg(cmark) from mark where cid=(a)
--�Ϻ������ĸ���ƽ����
(select cid,avg(cmark) from mark where sid in(
select sid from student where snativeplace ='�Ϻ�') group by cid) 
--���������ĸ���ƽ����
(select cid,avg(cmark) from mark where sid in(
select sid from student where snativeplace ='����') group by cid) 

select a.cid from 
(select cid,avg(cmark) amk from mark where sid in(
select sid from student where snativeplace ='�Ϻ�') group by cid) a,
(select cid,avg(cmark) bmk from mark where sid in(
select sid from student where snativeplace ='����') group by cid) b
where a.cid=b.cid and amk<bmk

--33.����ſγ�ȥ��һ����߷ֺ���ͷֺ��ƽ����
select cid,round(avg(cmark)) from mark     
where cmark not in (select cmark from(select cmark from mark order by cmark) where rownum<2)   
and cmark not in (select cmark from(select cmark from mark where cmark is not null order by cmark desc) where rownum<2)  
group by cid order by cid

--34.����mark���в������ݵĹ�����������С�Ĳ������ظ���ѧ��ѡ�μ�¼,�����Ҫ���ظ����������ɾ��,
--��������һ��,�������ò�ѯ����ҳ�����һ��������ظ������Ա�ɾ��֮

DELETE from mark WHERE (cid) IN ( select cid from mark a where (select count(cid) from mark where cid=a.cid and sid=a.sid and cmark=a.cmark)>=2)
AND (sid) IN ( select sid from mark a where (select count(cid) from mark where cid=a.cid and sid=a.sid and cmark=a.cmark)>=2)
AND (cmark) IN ( select cmark from mark a where (select count(cid) from mark where cid=a.cid and sid=a.sid and cmark=a.cmark)>=2)
AND ROWID NOT IN (SELECT MIN(ROWID) from mark a where (select count(cid) from mark where cid=a.cid and sid=a.sid and cmark=a.cmark)>=2
group by cid);

