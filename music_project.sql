--Information about table
SELECT * FROM album
SELECT * FROM artist
SELECT * FROM customer
SELECT * FROM employee
SELECT * FROM invoice
---(Q1)senior most employee in table based on job tital?
SELECT first_name from employee
ORDER BY levels desc
limit 2

--(Q2)Which country have the most invoices
SELECT count(*) as c,billing_country
from invoice
group by billing_country
order by c desc

--(Q3)What are top 3 values of total invoice?
SELECT invoice_id,total from invoice
order by total desc
limit 3

--(Q4)which city has the best customer? we would like to throw a promotional
--music festival in the city we made the most money.write a query that return 
--one city that has the highest sum of invoices total.

select sum(total) as invoice_total, billing_city
from invoice
group by billing_city
order by invoice_total desc

--(Q5)who is the best customer? The customer who has spent the most
--money will be declared the best customer. 
--write a query that return the person who has spent the most meoney?

select * from customer
select customer.customer_id,customer.first_name,customer.last_name,sum(invoice.total) as total
from customer
join invoice on customer.customer_id=invoice.customer_id
group by customer.customer_id
order by total desc
limit 1

--(Q6)Write query to return the email,first name,last name & Genre of all Rock music listeners. 
--Return your list orderde alphabetically by email starting with A.

select DISTINCT email,first_name,last_name
from customer
JOIN invoice on customer.customer_id=invoice.customer_id
JOIN invoice_line on invoice.invoice_id=invoice_line.invoice_id
where track_id IN(
select track_id from track
JOIN genre on track.genre_id=genre.genre_id
where genre.name LIKE 'Rock'
)
order by email;

--(Q7)Let's invite the artists who have written the most musisc in our dataset.
--write a query that return the artist name and total count of top 10 rock bands.
select artist.artist_id,artist.name,count(artist.artist_id) as number_of_songs
from track
join album on album.album_id=track.album_id
join artist on artist.artist_id= album.artist_id
join genre on genre.genre_id= track.genre_id
where genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs desc
limit 10