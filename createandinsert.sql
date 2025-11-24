-- ==========================================
-- Create Database
-- ==========================================
CREATE DATABASE IF NOT EXISTS FootballLeague;
USE FootballLeague;

-- ==========================================
-- Create Table: League
-- ==========================================
CREATE TABLE League (
    ID INT PRIMARY KEY,
    LeagueName VARCHAR(255),
    Country VARCHAR(255)
);

-- ==========================================
-- Create Table: Team
-- ==========================================
CREATE TABLE Team (
    ID INT PRIMARY KEY,
    TeamName VARCHAR(255),
    LeagueID INT,
    FoundedYear INT,
    HomeStadium VARCHAR(255),
    FOREIGN KEY (LeagueID) REFERENCES League(ID)
);

-- ==========================================
-- Create Table: Match
-- ==========================================
CREATE TABLE Match (
    ID INT PRIMARY KEY,
    MatchDate DATETIME,
    HomeTeamID INT,
    AwayTeamID INT,
    Stadium VARCHAR(255),
    FOREIGN KEY (HomeTeamID) REFERENCES Team(ID),
    FOREIGN KEY (AwayTeamID) REFERENCES Team(ID)
);

-- ==========================================
-- Create Table: Player
-- ==========================================
CREATE TABLE Player (
    ID INT PRIMARY KEY,
    PlayerName VARCHAR(255),
    TeamID INT,
    Position VARCHAR(50),
    Age INT,
    Nationality VARCHAR(255),
    FOREIGN KEY (TeamID) REFERENCES Team(ID)
);

-- ==========================================
-- Create Table: Arbitration
-- ==========================================
CREATE TABLE Arbitration (
    ID INT PRIMARY KEY,
    MatchID INT,
    RefereeName VARCHAR(255),
    Role VARCHAR(50),
    FOREIGN KEY (MatchID) REFERENCES Match(ID)
);

-- ==========================================
-- Create Table: MatchResult
-- ==========================================
CREATE TABLE MatchResult (
    ID INT PRIMARY KEY,
    MatchID INT,
    HomeTeamScore INT,
    AwayTeamScore INT,
    Result VARCHAR(10),
    FOREIGN KEY (MatchID) REFERENCES Match(ID)
);

-- ==========================================
-- Create Table: Goal
-- ==========================================
CREATE TABLE Goal (
    ID INT PRIMARY KEY,
    MatchID INT,
    PlayerID INT,
    MinuteScored INT,
    FOREIGN KEY (MatchID) REFERENCES Match(ID),
    FOREIGN KEY (PlayerID) REFERENCES Player(ID)
);

-- ==========================================
-- Create Table: Subscribe
-- ==========================================
CREATE TABLE Subscribe (
    ID INT PRIMARY KEY,
    UserName VARCHAR(255),
    LeagueID INT,
    SubscriptionDate DATETIME,
    FOREIGN KEY (LeagueID) REFERENCES League(ID)
);

-- ==========================================
-- Create Table: TeamMatchStats
-- ==========================================
CREATE TABLE TeamMatchStats (
    ID INT PRIMARY KEY,
    MatchID INT,
    TeamID INT,
    BallPossession DOUBLE,
    ShotsOnTarget INT,
    Corners INT,
    Fouls INT,
    FOREIGN KEY (MatchID) REFERENCES Match(ID),
    FOREIGN KEY (TeamID) REFERENCES Team(ID)
);

-- ==========================================
-- INSERT DATA
-- ==========================================

INSERT INTO League
VALUES 
(1, 'Premier League', 'England'),
(2, 'La Liga', 'Spain'),
(3, 'Serie A', 'Italy'),
(4, 'Bundesliga', 'Germany'),
(5, 'Ligue 1', 'France'),
(6, 'Eredivisie', 'Netherlands'),
(7, 'MLS', 'USA'),
(8, 'Pro League', 'Saudi Arabia'),
(9, 'Brasileirão', 'Brazil'),
(10, 'Egyptian Premier League', 'Egypt');

INSERT INTO Team 
VALUES
(1, 'Manchester United', 1, 1878, 'Old Trafford'),
(2, 'Real Madrid', 2, 1902, 'Santiago Bernabéu'),
(3, 'AC Milan', 3, 1899, 'San Siro'),
(4, 'Bayern Munich', 4, 1900, 'Allianz Arena'),
(5, 'PSG', 5, 1970, 'Parc des Princes'),
(6, 'Ajax', 6, 1900, 'Johan Cruyff Arena'),
(7, 'LA Galaxy', 7, 1994, 'Dignity Health Sports Park'),
(8, 'Al Nassr', 8, 1955, 'Al-Awwal Park'),
(9, 'Flamengo', 9, 1895, 'Maracanã'),
(10, 'Al Ahly', 10, 1907, 'Cairo International Stadium');

INSERT INTO Match 
VALUES
(1, '2024-02-15 19:00:00', 1, 2, 'Old Trafford'),
(2, '2024-02-16 20:00:00', 3, 4, 'San Siro'),
(3, '2024-02-17 21:00:00', 5, 6, 'Parc des Princes'),
(4, '2024-02-18 18:00:00', 7, 8, 'Dignity Health Sports Park'),
(5, '2024-02-19 22:00:00', 9, 10, 'Maracanã');

INSERT INTO Player 
VALUES
(1, 'Marcus Rashford', 1, 'Forward', 26, 'England'),
(2, 'Vinícius Júnior', 2, 'Forward', 24, 'Brazil'),
(3, 'Rafael Leão', 3, 'Forward', 25, 'Portugal'),
(4, 'Harry Kane', 4, 'Forward', 30, 'England'),
(5, 'Kylian Mbappé', 5, 'Forward', 25, 'France'),
(6, 'Steven Bergwijn', 6, 'Midfielder', 27, 'Netherlands'),
(7, 'Riqui Puig', 7, 'Midfielder', 24, 'Spain'),
(8, 'Cristiano Ronaldo', 8, 'Forward', 39, 'Portugal'),
(9, 'Gabigol', 9, 'Forward', 27, 'Brazil'),
(10, 'Hussein El Shahat', 10, 'Midfielder', 32, 'Egypt');

INSERT INTO Subscribe 
VALUES
(1, 'user1', 1, '2024-01-10'),
(2, 'user2', 2, '2024-01-11'),
(3, 'user3', 3, '2024-01-12'),
(4, 'user4', 4, '2024-01-13'),
(5, 'user5', 5, '2024-01-14'),
(6, 'user6', 6, '2024-01-15'),
(7, 'user7', 7, '2024-01-16'),
(8, 'user8', 8, '2024-01-17'),
(9, 'user9', 9, '2024-01-18'),
(10, 'user10', 10, '2024-01-19');

INSERT INTO MatchResult 
VALUES
(1, 1, 2, 3, 'Lose'),
(2, 2, 1, 1, 'Draw'),
(3, 3, 4, 2, 'Win'),
(4, 4, 3, 3, 'Draw'),
(5, 5, 2, 1, 'Win');

INSERT INTO Goal
VALUES
(1, 1, 1, 23),
(2, 1, 2, 45),
(3, 2, 3, 12),
(4, 3, 5, 30),
(5, 4, 8, 60),
(6, 5, 9, 78),
(7, 5, 10, 15);

INSERT INTO Arbitration 
VALUES
(1, 1, 'Michael Oliver', 'Main'),
(2, 2, 'Daniele Orsato', 'Main'),
(3, 3, 'Clément Turpin', 'Main'),
(4, 4, 'Victor Rivas', 'Main'),
(5, 5, 'Gehad Grisha', 'Main');

INSERT INTO TeamMatchStats 
VALUES
(1, 1, 1, 52.5, 6, 3, 12),
(2, 1, 2, 47.5, 5, 4, 14),
(3, 2, 3, 55.0, 7, 6, 10),
(4, 2, 4, 45.0, 3, 2, 8),
(5, 3, 5, 62.0, 8, 7, 11),
(6, 3, 6, 38.0, 2, 3, 9),
(7, 4, 7, 50.0, 5, 4, 12),
(8, 4, 8, 50.0, 5, 3, 13),
(9, 5, 9, 57.0, 6, 5, 10),
(10, 5, 10, 43.0, 4, 3, 11);

