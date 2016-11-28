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
    
getListReservasR :: Handler Html
getListReservasR = undefined

putUpdateReservasR :: Handler ()
putUpdateReservasR = do
    reserva <- requireJsonBody :: Handler Reservas
    rid <- runDB $ insert reserva
    sendResponse (object [pack "resp" .= pack ("UPDATED " ++ (show $ fromSqlKey rid))])

-- tratar o ReservasProdutos aqui também