-- Identifying null values
Select *
From dbo.googleplaystore
Where App IS NULL
OR Category IS NULL
OR Rating IS NULL
OR Reviews IS NULL
OR Size IS NULL
OR Installs IS NULL
OR Type IS NULL
OR Price IS NULL
OR Content_Rating IS NULL

-- Removing the null values
DELETE From dbo.googleplaystore
Where App IS NULL
OR Category IS NULL
OR Rating IS NULL
OR Reviews IS NULL
OR Size IS NULL
OR Installs IS NULL
OR Type IS NULL
OR Price IS NULL
OR Content_Rating IS NULL

-- Overall view
Select COUNT(DISTINCT APP) total_apps,
COUNT(DISTINCT Category) total_category
From dbo.googleplaystore

-- Explore app categorires
Select Category,
	COUNT(App) Total_app
From dbo.googleplaystore
Group BY Category
ORDER BY Total_app ASC

-- TopRated free apps

Select App,
Category, 
Rating,
Reviews
From dbo.googleplaystore
Where Type = 'Free' AND Rating <> 'NaN'
Order By Rating ASC

-- Most Reviews Apps
Select TOP 25
Category,
App,
Reviews
From dbo.googleplaystore
Order By Reviews DESC

-- Average Rating by Category
Select Category,
AVG(TRY_CAST(Rating as FLOAT)) avg_rating
From dbo.googleplaystore
Group BY Category
Order by avg_rating

-- Top categories by number of install
Select Category,
SUM(CAST(REPLACE(SUBSTRING(Installs, 1, PATINDEX('%[^0-9]%', Installs + ' ') - 1), ',' , ' ') AS INT)) AS total_installs
From dbo.googleplaystore
Group By Category
Order By total_installs

-- Average Sentiment Polarity by APP Category
Select
Category,
AVG(TRY_CAST(Sentiment_Polarity AS FLOAT)) avg_sentiment_polarity
From dbo.googleplaystore
Join dbo.googleplaystore_user_reviews
on dbo.googleplaystore.App = dbo.googleplaystore_user_reviews.App
Group By Category
Order By avg_sentiment_polarity

-- Sentiment Reviews by App Category
Select Category,
Sentiment,
Count(*) total_sentiment
From dbo.googleplaystore
JOIN dbo.googleplaystore_user_reviews
ON dbo.googleplaystore.App = dbo.googleplaystore_user_reviews.APP
Where Sentiment <> 'nan'
Group By Category, Sentiment
Order By total_sentiment Desc

