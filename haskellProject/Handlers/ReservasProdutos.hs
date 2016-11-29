{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handlers.ReservasProdutos where

import Foundation
import Yesod
import Database.Persist.Postgresql
import Data.Text

-- FUNÇÃO QUE INSERE UM PRODUTO EM UMA RESERVA DO BD
postInsertReservasProdutosR :: Handler ()
postInsertReservasProdutosR = do 
    produto <- requireJsonBody :: Handler ReservasProdutos
    pid <- runDB $ insert produto
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey pid))])

-- FUNÇÃO QUE LISTA TODOS OS PRODUTOS DE UMA RESERVA DO BD
getListReservasProdutosR :: ReservasId -> Handler ()
getListReservasProdutosR rid = do
    produtos <- runDB $ selectList [ReservasProdutosReserva ==. rid] []
    sendResponse (object [pack "resp" .= toJSON produtos])
    