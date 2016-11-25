{-# LANGUAGE OverloadedStrings, QuasiQuotes,
             TemplateHaskell #-}
import Application () -- for YesodDispatch instance
import Foundation
import Yesod
import Control.Monad.Logger (runStdoutLoggingT)
import Database.Persist.Postgresql

connStr :: ConnectionString
connStr = "dbname=d83m8f8t2v207g host=ec2-54-243-54-21.compute-1.amazonaws.com user=zjxlogygrxrujv password=tUFzCDYc4OrBL1CwIiY4ZcqN_L port=5432"

main::IO()
main = runStdoutLoggingT $ withPostgresqlPool connStr 10 $ \pool -> liftIO $ do 
       runSqlPersistMPool (runMigration migrateAll) pool 
       warp 8080 (App pool)