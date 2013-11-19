module Karamaan.Opaleye.SQL where

import Database.HaskellDB.Optimize (optimize)
import Database.HaskellDB.Sql.Generate (sqlQuery)
import Database.HaskellDB.Sql.Print (ppSql)
import Database.HaskellDB.Sql.Default (defaultSqlGenerator)
import Database.HaskellDB.PrimQuery (PrimQuery)
import Karamaan.Opaleye.QueryArr (Query, runQueryArrPrim)
import Karamaan.Opaleye.Unpackspec (Unpackspec)
import Karamaan.WhaleUtil ((.:))

{-# DEPRECATED showSqlForPostgreSQLSimple'
    "Use 'showSqlForPostgres' instead" #-}
showSqlForPostgreSQLSimple' :: Unpackspec a -> Query a -> String
showSqlForPostgreSQLSimple' = showSqlForPostgres

{-# DEPRECATED showSqlForPostgreSQLSimple
    "Use 'showSqlForPostgres' instead" #-}
showSqlForPostgreSQLSimple :: Unpackspec a -> Query a -> String
showSqlForPostgreSQLSimple = showSqlForPostgres

-- Currently we only support SQL generation for Postgres because,
-- for example, 'cat' is implemented as '||' and the hackery we do
-- in, for example, Values.hs, may be Postgres specific.
--
-- Support for other DBMSes can be added if required.
showSqlForPostgres :: Unpackspec a -> Query a -> String
showSqlForPostgres = optimizeFormatAndShowSQL .: runQueryArrPrim

formatAndShowSQL :: PrimQuery -> String
formatAndShowSQL = show . ppSql . sqlQuery defaultSqlGenerator

optimizeFormatAndShowSQL :: PrimQuery -> String
optimizeFormatAndShowSQL = formatAndShowSQL . optimize
