{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handlers.Reservas where

import Foundation
import Yesod
import Database.Persist.Postgresql
import Data.Text

postReservasR :: Handler ()
postReservasR = do
    reserva <- requireJsonBody :: Handler Reservas
    rid <- runDB $ insert reserva
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey rid))])
    
getListReservasR :: Handler Html
getListReservasR = undefined

-- tratar o ReservasProdutos aqui também