{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handlers.Reservas where

import Foundation
import Yesod
import Database.Persist.Postgresql
import Data.Text

postInsertReservasR :: Handler ()
postInsertReservasR = do
    reserva <- requireJsonBody :: Handler Reservas
    rid <- runDB $ insert reserva
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey rid))])
    
getListReservasR :: Handler ()
getListReservasR = undefined

putUpdateReservasR :: Handler ()
putUpdateReservasR = do
    reserva <- requireJsonBody :: Handler Reservas
    rid <- runDB $ insert reserva
    sendResponse (object [pack "resp" .= pack ("UPDATED " ++ (show $ fromSqlKey rid))])


{- 
tratar o ReservasProdutos aqui também
getSecretaryR :: Handler Html
getSecretaryR = do
    boss <- runDB $ (rawSql "SELECT ??, ?? \
            \FROM depto INNER JOIN person \
            \ON depto.secretary=person.id" [])::Handler [(Entity Depto, Entity Person)]
    sendResponse (object [pack "resp" .= toJSON boss]) 
-}