WITH RECURSIVE CategoryHierarchy AS (
  -- Caso base: Seleccionar las categorías raíz (aquellas sin un padre)
  SELECT CATEGID, CATEGNAME, ACTIVE, PARENTID, 0 AS Level
  FROM CATEGORY_V1
  WHERE PARENTID = -1

  UNION ALL

  -- Caso recursivo: Unir las categorías con sus subcategorías
  SELECT c.CATEGID, ch.CATEGNAME || '/' || c.CATEGNAME, c.ACTIVE, c.PARENTID, ch.Level + 1
  FROM CATEGORY_V1 c
  JOIN CategoryHierarchy ch ON c.PARENTID = ch.CATEGID
)


    SELECT c.TRANSID AS Id, a.ACCOUNTNAME AS Source, a1.ACCOUNTTYPE AS DestinationType, p.PAYEENAME AS Payee, c.TRANSCODE AS Type, c.NOTES AS Notes, COALESCE(
          cat.CATEGNAME,
          (
              SELECT GROUP_CONCAT(sch.CATEGNAME, ' / ')
              FROM SPLITTRANSACTIONS_V1 st
              JOIN CategoryHierarchy sch ON sch.CATEGID = st.CATEGID
              WHERE st.TRANSID = c.TRANSID
          )
      ) AS Category, strftime('%Y-%m-%d', c.TRANSDATE) AS Moment, c.TOTRANSAMOUNT AS Ammount, c.Status AS Status, 1 AS Section
    FROM CHECKINGACCOUNT_V1 c
        LEFT JOIN ACCOUNTLIST_V1 a ON c.ACCOUNTID =a.ACCOUNTID
        LEFT JOIN ACCOUNTLIST_V1 a1 ON c.TOACCOUNTID =a1.ACCOUNTID
        LEFT JOIN PAYEE_V1 p ON p.PAYEEID = c.PAYEEID
        LEFT JOIN CategoryHierarchy cat ON cat.CATEGID = c.CATEGID
    WHERE c.Status != "V"
        AND Moment >= date("now","localtime", "start of month")
        AND Moment <= date("now","localtime", "start of month","+1 month","-1 day")
        AND c.DELETEDTIME == ""
UNION
    SELECT '#' AS Id, a.ACCOUNTNAME AS Source, a1.ACCOUNTTYPE AS DestinationType, p.PAYEENAME AS Payee, c.TRANSCODE AS Type, c.NOTES AS Notes, cat.CATEGNAME AS Category, strftime('%Y-%m-%d', c.TRANSDATE) AS Moment, c.TOTRANSAMOUNT AS Ammount, 'Repeats' AS Status, 2 AS Section
    FROM BILLSDEPOSITS_V1 c
        LEFT JOIN ACCOUNTLIST_V1 a ON c.ACCOUNTID =a.ACCOUNTID
        LEFT JOIN ACCOUNTLIST_V1 a1 ON c.TOACCOUNTID =a1.ACCOUNTID
        LEFT JOIN PAYEE_V1 p ON p.PAYEEID = c.PAYEEID
        LEFT JOIN CategoryHierarchy cat ON cat.CATEGID = c.CATEGID
    WHERE TRANSCODE != "Transfer"
        AND Moment <= date("now","localtime","start of month","+1 month","-1 day")
UNION
    SELECT '#' AS Id, a.ACCOUNTNAME AS Source, a1.ACCOUNTTYPE AS DestinationType, p.PAYEENAME AS Payee, c.TRANSCODE AS Type, c.NOTES AS Notes, cat.CATEGNAME AS Category, 
        date(c.TRANSDATE, "+7 days") AS Moment, c.TOTRANSAMOUNT AS Ammount, 'Repeats' AS Status, 2 AS Section
    FROM BILLSDEPOSITS_V1 c
        LEFT JOIN ACCOUNTLIST_V1 a ON c.ACCOUNTID =a.ACCOUNTID
        LEFT JOIN ACCOUNTLIST_V1 a1 ON c.TOACCOUNTID =a1.ACCOUNTID
        LEFT JOIN PAYEE_V1 p ON p.PAYEEID = c.PAYEEID
        LEFT JOIN CategoryHierarchy cat ON cat.CATEGID = c.CATEGID
    WHERE TRANSCODE != "Transfer"
        AND Moment <= date("now","localtime","start of month","+1 month","-1 day")
        AND Repeats = 1
UNION
    SELECT '#' AS Id, a.ACCOUNTNAME AS Source, a1.ACCOUNTTYPE AS DestinationType, p.PAYEENAME AS Payee, c.TRANSCODE AS Type, c.NOTES AS Notes, cat.CATEGNAME AS Category, 
        date(c.TRANSDATE, "+14 days") AS Moment, c.TOTRANSAMOUNT AS Ammount, 'Repeats' AS Status, 2 AS Section
    FROM BILLSDEPOSITS_V1 c
        LEFT JOIN ACCOUNTLIST_V1 a ON c.ACCOUNTID =a.ACCOUNTID
        LEFT JOIN ACCOUNTLIST_V1 a1 ON c.TOACCOUNTID =a1.ACCOUNTID
        LEFT JOIN PAYEE_V1 p ON p.PAYEEID = c.PAYEEID
        LEFT JOIN CategoryHierarchy cat ON cat.CATEGID = c.CATEGID
    WHERE TRANSCODE != "Transfer"
        AND Moment <= date("now","localtime","start of month","+1 month","-1 day")
        AND Repeats = 1
UNION
    SELECT '#' AS Id, a.ACCOUNTNAME AS Source, a1.ACCOUNTTYPE AS DestinationType, p.PAYEENAME AS Payee, c.TRANSCODE AS Type, c.NOTES AS Notes, cat.CATEGNAME AS Category, 
        date(c.TRANSDATE, "+21 days") AS Moment, c.TOTRANSAMOUNT AS Ammount, 'Repeats' AS Status, 2 AS Section
    FROM BILLSDEPOSITS_V1 c
        LEFT JOIN ACCOUNTLIST_V1 a ON c.ACCOUNTID =a.ACCOUNTID
        LEFT JOIN ACCOUNTLIST_V1 a1 ON c.TOACCOUNTID =a1.ACCOUNTID
        LEFT JOIN PAYEE_V1 p ON p.PAYEEID = c.PAYEEID
        LEFT JOIN CategoryHierarchy cat ON cat.CATEGID = c.CATEGID
    WHERE TRANSCODE != "Transfer"
        AND Moment <= date("now","localtime","start of month","+1 month","-1 day")
        AND Repeats = 1
UNION
    SELECT '#' AS Id, a.ACCOUNTNAME AS Source, a1.ACCOUNTTYPE AS DestinationType, p.PAYEENAME AS Payee, c.TRANSCODE AS Type, c.NOTES AS Notes, cat.CATEGNAME AS Category, 
        date(c.TRANSDATE, "+28 days") AS Moment, c.TOTRANSAMOUNT AS Ammount, 'Repeats' AS Status, 2 AS Section
    FROM BILLSDEPOSITS_V1 c
        LEFT JOIN ACCOUNTLIST_V1 a ON c.ACCOUNTID =a.ACCOUNTID
        LEFT JOIN ACCOUNTLIST_V1 a1 ON c.TOACCOUNTID =a1.ACCOUNTID
        LEFT JOIN PAYEE_V1 p ON p.PAYEEID = c.PAYEEID
        LEFT JOIN CategoryHierarchy cat ON cat.CATEGID = c.CATEGID
    WHERE TRANSCODE != "Transfer"
        AND Moment <= date("now","localtime","start of month","+1 month","-1 day")
        AND Repeats = 1
UNION
    SELECT '#' AS Id, a.ACCOUNTNAME AS Source, a1.ACCOUNTTYPE AS DestinationType, p.PAYEENAME AS Payee, c.TRANSCODE AS Type, c.NOTES AS Notes, cat.CATEGNAME AS Category, 
        date(c.TRANSDATE, "+14 days") AS Moment, c.TOTRANSAMOUNT AS Ammount, 'Repeats' AS Status, 2 AS Section
    FROM BILLSDEPOSITS_V1 c
        LEFT JOIN ACCOUNTLIST_V1 a ON c.ACCOUNTID =a.ACCOUNTID
        LEFT JOIN ACCOUNTLIST_V1 a1 ON c.TOACCOUNTID =a1.ACCOUNTID
        LEFT JOIN PAYEE_V1 p ON p.PAYEEID = c.PAYEEID
        LEFT JOIN CategoryHierarchy cat ON cat.CATEGID = c.CATEGID
    WHERE TRANSCODE != "Transfer"
        AND Moment <= date("now","localtime","start of month","+1 month","-1 day")
        AND Repeats = 2
UNION
    SELECT '#' AS Id, a.ACCOUNTNAME AS Source, a1.ACCOUNTTYPE AS DestinationType, p.PAYEENAME AS Payee, c.TRANSCODE AS Type, c.NOTES AS Notes, cat.CATEGNAME AS Category, 
        date(c.TRANSDATE, "+28 days") AS Moment, c.TOTRANSAMOUNT AS Ammount, 'Repeats' AS Status, 2 AS Section
    FROM BILLSDEPOSITS_V1 c
        LEFT JOIN ACCOUNTLIST_V1 a ON c.ACCOUNTID =a.ACCOUNTID
        LEFT JOIN ACCOUNTLIST_V1 a1 ON c.TOACCOUNTID =a1.ACCOUNTID
        LEFT JOIN PAYEE_V1 p ON p.PAYEEID = c.PAYEEID
        LEFT JOIN CategoryHierarchy cat ON cat.CATEGID = c.CATEGID
    WHERE TRANSCODE != "Transfer"
        AND Moment <= date("now","localtime","start of month","+1 month","-1 day")
        AND Repeats = 2
ORDER BY Section, Moment