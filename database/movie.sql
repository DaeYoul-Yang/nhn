show databases;
select database();
use DatamotionMovieDatabase;
select database();

#1 영화 '퍼스트 맨'의 제작 연도, 영문 제목, 러닝 타임, 플롯을 출력하세요.
select ReleaseYear, Title, RunningTime, Plot
from movie
where KoreanTitle = '퍼스트 맨';

#2 2003년에 개봉한 영화의 한글 제목과 영문 제목을 출력하세요
select KoreanTitle, Title
from movie
where ReleaseYear = 2003;


#3 영화 '글래디에이터'의 작곡가를 고르세요
select RoleID
from role
where RoleKorName = '작곡';
select movieID
from movie
where KoreanTitle = '글래디에이터';
select PersonID
from appear
where MovieID in (select movieID from movie where KoreanTitle = '글래디에이터')
  and RoleID in (select RoleID from role where RoleKorName = '작곡');

# 결과!!
select *
from person
where PersonID in (select PersonID
                   from appear
                   where MovieID in (select movieID from movie where KoreanTitle = '글래디에이터')
                     and RoleID in (select RoleID from role where RoleKorName = '작곡'));

#4 영화 '매트릭스' 의 감독이 몇명인지 출력하세요
select MovieID
from movie
where KoreanTitle = '매트릭스';
select RoleID
from role
where RoleKorName = '감독';
select count(*)
from appear
where (RoleID in (select RoleID from role where RoleKorName = '감독'))
  and (MovieID in (select MovieID from movie where KoreanTitle = '매트릭스'));

#5 감독이 2명 이상인 영화를 출력하세요
select *
from movie
where MovieId in ((select RoleID from role where RoleKorName = '감독'));
select *
from movie
where MovieId in (select MovieID
                  from appear
                  where RoleId = (select RoleID from role where RoleKorName = '감독')
                  group by MovieID
                  HAVING count(movie.MovieID) >= 2);


#6'한스 짐머'가 참여한 영화 중 아카데미를 수상한 영화를 출력하세요
select PersonID
from person
where KoreanName = '한스 짐머';
select AppearID
from appear
where PersonID in (select PersonID from person where KoreanName = '한스 짐머');
select AwardID
from award
where AwardKoreanTitle = '아카데미 영화제';
select AwardYearID
from awardyear
where AwardID = (select AwardID from award where AwardKoreanTitle = '아카데미 영화제');
select AppearID
from awardinvolve
where AwardYearID in (select AwardYearID
                      from awardyear
                      where AwardID = (select AwardID from award where AwardKoreanTitle = '아카데미 영화제'));
select MovieID
from appear
where AppearID in
      ((select AppearID from appear where PersonID in (select PersonID from person where KoreanName = '한스 짐머'))
       intersect
       (select AppearID
        from awardinvolve
        where WinningID = (select WinningID from winning where WinOrNot = 'winner')
          and AwardYearID in (select AwardYearID
                              from awardyear
                              where AwardID in (select AwardID from award where AwardKoreanTitle = '아카데미 영화제'))));
select *
from movie
where MovieID in (select MovieID
                  from appear
                  where AppearID in ((select AppearID
                                      from appear
                                      where PersonID in (select PersonID from person where KoreanName = '한스 짐머'))
                                     intersect
                                     (select AppearID from awardinvolve)));

#결과
select *
from movie
where MovieID in (select MovieID
                  from appear
                  where AppearID in ((select AppearID
                                      from appear
                                      where PersonID in (select PersonID from person where KoreanName = '한스 짐머'))
                                     intersect
                                     (select AppearID
                                      from awardinvolve
                                      where WinningID = (select WinningID from winning where WinOrNot = 'winner')
                                        and AwardYearID in (select AwardYearID
                                                            from awardyear
                                                            where AwardID in (select AwardID from award where AwardKoreanTitle = '아카데미 영화제')))));

#7감독이 '제임스 카메론'이고 '아놀드 슈워제네거'가 출연한 영화를 출력하세요

select PersonID
from person
where KoreanName = '제임스 카메론';
select PersonID
from person
where KoreanName = '아놀드 슈워제네거';
select MovieID
from appear
where PersonID in ((select PersonID from person where KoreanName = '아놀드 슈워제네거') and
                   (select PersonID from person where KoreanName = '제임스 카메론'));
#결과

select *
from movie
where MovieID in
      (select MovieID
       from appear
       where PersonID = (select PersonID from person where KoreanName = '제임스 카메론')
         and RoleID = (select RoleID from role where RoleKorName = '감독'))
  and MovieID in
      (select MovieID
       from appear
       where PersonID = (select PersonID from person where KoreanName = '아놀드 슈워제네거'));


#8 상영시간이 100분 이상인 영화 중 레오나르도 디카프리오가 출연한 영화를 고르시오
select KoreanTitle
from movie
where RunningTime >= 100;
select PersonID
from person
where KoreanName = '레오나르도 디카프리오';
select MovieID
from appear
where PersonID = (select PersonID from person where KoreanName = '레오나르도 디카프리오');
#결과
select *
from movie
where MovieID in
      (select MovieID from appear where PersonID in (select PersonID from person where KoreanName = '레오나르도 디카프리오') and RoleID in (select RoleID from role where RoleKorName='배우'))

  and KoreanTitle in (select KoreanTitle from movie where RunningTime >= 100);


#9 청소년 관람불가 등급의 영화 중 가장 많은 수익을 얻은 영화를 고르시오
select GradeInKoreaID
from gradeinkorea
where GradeInKoreaName = '청소년 관람불가';
select MAX(Budget)
from movie
where GradeInKoreaID = (select GradeInKoreaID from gradeinkorea where GradeInKoreaName = '청소년 관람불가');
#결과
select *
from movie
where BoxOfficeUSGross + movie.BoxOfficeWWGross = (select MAX(BoxOfficeUSGross + movie.BoxOfficeWWGross)
                                                   from movie
                                                   where GradeInKoreaID = (select GradeInKoreaID
                                                                           from gradeinkorea
                                                                           where GradeInKoreaName = '청소년 관람불가'));

#10 1999년 이전에 제작된 영화의 수익 평균을 고르시오
select avg(BoxOfficeWWGross)
from movie
where ReleaseYear < 1999;

#11 가장 많은 제작비가 투입된 영화를 고르시오.
select *
from movie
where Budget = (select max(Budget) from movie);

#12 제작한 영화의 제작비 총합이 가장 높은 감독은 누구입니까?
select *
from person
where PersonID = (select PersonID
                  from movie,
                       appear
                  where movie.MovieId = appear.MovieId
                    and roleId = (select roleID from role where RoleKorname = '감독')
                  group by PersonID
                  order by sum(Budget) desc
                  Limit 1);

#13 출연한 영화의 모든 수익을 합하여, 총 수입이 가장 많은 배우를 출력하세요.
select *
from person
where PersonID = (select PersonID
                  from movie,
                       appear
                  where movie.MovieID = appear.MovieID
                    and RoleID in (select roleID from role where RoleKorname = '배우')
                  group by PersonID
                  order by sum(BoxOfficeWWGross) desc
                  Limit 1);

#14 제작비가 가장 적게 투입된 영화의 수익을 고르세요. (제작비가 0인 영화는 제외합니다)
select *
from movie
where Budget = (select Min(Budget) from movie where Budget <> 0);

#15 제작비가 5000만 달러 이하인 영화의 미국내 평균 수익을 고르세요
select avg(BoxOfficeUSGross)
from movie
where Budget < 5000;

#16 액션 장르 영화의 평균 수익을 고르세요
select avg(BoxOfficeWWGross + BoxOfficeUSGross)
from movie
where MovieID in (select MovieID
                  from moviegenre
                  where GenreID = (select GenreID
                                   from genre
                                   where GenreKorName = '액션'));


#17 드라마, 전쟁 장르의 영화를 고르세요.

select GenreID
from genre
where GenreKorName = '드라마'
   or GenreKorName = '전쟁';
select MovieID
from moviegenre
where GenreID in (select GenreID from genre where GenreKorName = '드라마' or GenreKorName = '전쟁');
# 결과
select *
from movie
where MovieID in (select MovieID
                  from moviegenre
                  where GenreID in (select GenreID from genre where GenreKorName = '드라마' or GenreKorName = '전쟁'));

#18 톰 행크스가 출연한 영화 중 상영 시간이 가장 긴 영화의 제목, 한글제목, 개봉연도를 출력하세요.
select PersonID
from person
where KoreanName = '톰 행크스';
select MovieID
from appear
where PersonID = (select PersonID from person where KoreanName = '톰 행크스');
select MAX(RunningTime)
from movie
where MovieID in (select MovieID from appear where PersonID = (select PersonID from person where KoreanName = '톰 행크스'));
# 결과
select Title, KoreanTitle, ReleaseYear
from movie
where RunningTime = (select MAX(RunningTime)
                     from movie
                     where MovieID in (select MovieID
                                       from appear
                                       where PersonID = (select PersonID from person where KoreanName = '톰 행크스')))
  and MovieID in (select MovieID from appear where PersonID = (select PersonID from person where KoreanName = '톰 행크스'));

#19 아카데미 남우주연상을 가장 많이 수상한 배우
select SectorID
from sector
where SectorKorName = '남우주연상';
select WinningID
from winning
where WinOrNot = 'Winner';
select AppearID
from awardinvolve
where SectorID in (select SectorID from sector where SectorKorName = '남우주연상')
  and WinningID = (select WinningID from winning where WinOrNot = 'winner');
#결과
select PersonID
from appear
where PersonID in (select AppearID
                   from awardinvolve
                   where SectorID in (select SectorID from sector where SectorKorName = '남우주연상')
                     and WinningID = (select WinningID from winning where WinOrNot = 'winner'))
group by PersonID
order by count(PersonID) desc
LIMIT 1;

#결과
select *
from person
where PersonID = (select PersonID
                  from appear
                  where appear.AppearID in (select AppearID
                                            from awardinvolve
                                            where SectorID in (select SectorID from sector where SectorKorName = '남우주연상')
                                              and WinningID = (select WinningID from winning where WinOrNot = 'winner'))
                  group by PersonID
                  order by count(PersonID) desc
                  LIMIT 1);

#20 아카데미상을 가장 많이 수상한 배우
select AppearID
from awardinvolve
where WinningID = (select WinningID from winning where WinOrNot = 'winner');


# 결과
select person.*
from appear,
     person
where appear.PersonID = person.PersonID
  and AppearID in
      (select AppearID from awardinvolve where WinningID = (select WinningID from winning where WinOrNot = 'winner'))
  and person.KoreanName <> '수상자 없음'
  and RoleID in (select RoleID from role where RoleKorName = '배우' or RoleKorName = '감독')
group by appear.PersonID
order by count(appear.PersonID) desc
LIMIT 1;


#21 아카데미 남우주연상을 2번 이상 수상한 배우

select *
from person
where PersonID in
      (select PersonID
       from appear
       where AppearID in (select AppearID
                          from awardinvolve
                          where SectorID in (select SectorID from sector where SectorKorName = '남우주연상')
                            and WinningID = (select WinningID from winning where WinOrNot = 'winner')
                            and RoleID in (select RoleID from role where RoleKorName = '배우'))
       group by PersonID
       HAVING count(AppearID) >= 2);


#23 아카데미상을 가장 많이 수상한 사람
select person.*
from appear,
     person
where appear.PersonID = person.PersonID
  and AppearID in
      (select AppearID from awardinvolve where WinningID = (select WinningID from winning where WinOrNot = 'winner'))
  and person.KoreanName <> '수상자 없음'
group by appear.PersonID
order by count(appear.PersonID) desc
LIMIT 1;

#24 아카데미상에 가장 많이 노미네이트 된 영화
select MovieID
from appear
where AppearID in
      (select AppearID from awardinvolve where WinningID = (select WinningID from winning where WinOrNot = 'nominated'))
group by MovieID
order by count(MovieID) desc
LIMIT 1;

#결과
select *
from movie
where MovieID = (select MovieID
                 from appear
                 where AppearID in (select AppearID
                                    from awardinvolve
                                    where WinningID = (select WinningID from winning where WinOrNot = 'nominated'))
                 group by MovieID
                 order by count(MovieID) desc
                 LIMIT 1);


#25
select RoleID
from role
where RoleName = 'Actress';
select PersonID
from appear
where RoleID = (select RoleID from role where RoleName = 'Actress')
group by PersonID
order by count(PersonID) desc
LIMIT 1;
select *
from person
where PersonID = (select PersonID
                  from appear
                  where RoleID = (select RoleID from role where RoleName = 'Actress')
                  group by PersonID
                  order by count(PersonID) desc
                  LIMIT 1);

#26
select *
from movie
order by BoxOfficeWWGross desc
LIMIT 10;

#27
select *
from movie
where BoxOfficeWWGross > 100000
  and Budget < 10000;

#28 전쟁 영화를 가장 많이 감독한 사람을 고르세요.
select moviegenre.MovieID
from genre,
     moviegenre
where genre.GenreID = moviegenre.GenreID
  and genre.GenreKorName = '전쟁';
select RoleID
from role
where RoleKorName = '감독';
select MovieID
from moviegenre
where GenreID = (select GenreID from genre where GenreKorName = '전쟁');
select PersonID
from appear
where RoleID = (select RoleID from role where RoleKorName = '감독')
  and MovieID in (select Distinct moviegenre.MovieID
                  from genre,
                       moviegenre
                  where genre.GenreID = moviegenre.GenreID
                    and genre.GenreKorName = '전쟁')
group by PersonID
order by count(PersonID) desc
LIMIT 1;

#결과
select *
from person
where PersonID = (select PersonID
                  from appear
                  where RoleID = (select RoleID from role where RoleKorName = '감독')
                    and MovieID in (select Distinct moviegenre.MovieID
                                    from genre,
                                         moviegenre
                                    where genre.GenreID = moviegenre.GenreID
                                      and genre.GenreKorName = '전쟁')
                  group by PersonID
                  order by count(PersonID) desc
                  LIMIT 1);

#29 드라마에 가장 많이 출연한 사람을 고르세요.
select MovieID
from moviegenre
where GenreID = (select GenreID from genre where GenreKorName = '드라마');

select PersonID
from appear
where MovieID in (select MovieID from moviegenre where GenreID = (select GenreID from genre where GenreKorName = '드라마'))
group by PersonID
order by count(PersonID) desc
LIMIT 1;


#결과!
select *
from person
where PersonID = (select PersonID
                  from appear
                  where RoleID in (select RoleID from role where RoleKorName = '배우')
                    and MovieID in (select MovieID
                                    from moviegenre
                                    where GenreID = (select GenreID from genre where GenreKorName = '드라마'))
                  group by PersonID
                  order by count(PersonID) desc
                  LIMIT 1);
#30드라마 장르에 출연했지만 호러 영화에 한번도 출연하지 않은 사람을 고르세요.
select MovieID
from moviegenre
where GenreID = (select GenreID from genre where GenreKorName = '드라마');
select MovieID
from moviegenre
where GenreID = (select GenreID from genre where GenreKorName = '공포');

select PersonID
from appear
where MovieID in (select MovieID from moviegenre where GenreID = (select GenreID from genre where GenreKorName = '드라마'))
  and MovieID not in
      (select MovieID from moviegenre where GenreID = (select GenreID from genre where GenreKorName = '공포'))
  and RoleID in (select RoleID from role where RoleKorName = '배우');

#결과
select *
from person
where PersonID in (select PersonID
                   from appear
                   where MovieID in (select MovieID
                                     from moviegenre
                                     where GenreID = (select GenreID from genre where GenreKorName = '드라마'))
                     and MovieID not in (select MovieID
                                         from moviegenre
                                         where GenreID = (select GenreID from genre where GenreKorName = '공포'))
                     and RoleID in (select RoleID from role where RoleKorName = '배우'));

#31 아카데미 영화제가 가장 많이 열린 장소는 어디인가요?
select Location
from awardyear
group by Location
order by count(Location) desc
LIMIT 1;

#33 첫 번째 아카데미 영화제가 열린지 올해 기준으로 몇년이 지났나요?
select 2023 - Year AS difference
from awardyear
order by Year
LIMIT 1;
