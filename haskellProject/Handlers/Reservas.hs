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
-- tratar o ReservasProdutos aqui também

putUpdateReservasR :: ReservasId -> Handler ()
putUpdateReservasR rid = do
    reserva <- requireJsonBody :: Handler Reservas
    runDB $ update rid [ReservasUsuario     =. (reservasUsuario reserva)
                      , ReservasAtendido    =. (reservasAtendido reserva)]
    sendResponse (object [pack "resp" .= pack "UPDATED"])
