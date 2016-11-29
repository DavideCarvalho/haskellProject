{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handlers.Locais where

import Foundation
import Yesod
import Database.Persist.Postgresql
import Data.Text

-- FUNÇÃO PARA INSERIR UM LOCAL NO BD
postInsertLocaisR :: Handler ()
postInsertLocaisR = do
    local <- requireJsonBody :: Handler Locais
    lid <- runDB $ insert local
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey lid))])
    
-- FUNÇÃO QUE LISTA TODOS OS LOCAIS DO BD
getListLocaisR :: Handler Html
getListLocaisR = do
    locais <- runDB $ selectList [] [Asc LocaisNome]
    sendResponse (object [pack "resp" .= toJSON locais])
    
-- FUNÇÃO QUE EDITA DADOS DE UM LOCAL PROCURANDO POR ID (lid)
putUpdateLocaisR :: LocaisId -> Handler ()
putUpdateLocaisR lid = do
    local <- requireJsonBody :: Handler Locais
    runDB $ update lid [LocaisNome          =. (locaisNome local)
                      , LocaisLocalizacao   =. (locaisLocalizacao local)
                      , LocaisDescricao     =. (locaisDescricao local)]
    sendResponse (object [pack "resp" .= pack "UPDATED"])
    
-- FUNÇÃO QUE LISTA TODOS OS PRODUTOS DE UM LOCAL
getListLocaisProdutosR :: LocaisId -> Handler ()
getListLocaisProdutosR lid = do
    produtos <- runDB $ selectList [ProdutosLocal ==. lid] [Asc ProdutosNome]
    sendResponse (object [pack "resp" .= toJSON produtos])