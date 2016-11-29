{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handlers.Produtos where

import Foundation
import Yesod
import Database.Persist.Postgresql
import Data.Text

-- FUNÇÃO PARA INSERIR UM PRODUTO NO BD
postInsertProdutosR :: Handler ()
postInsertProdutosR = do
    produto <- requireJsonBody :: Handler Produtos
    pid <- runDB $ insert produto
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey pid))])

-- FUNÇÃO QUE LISTA TODOS OS PRODUTOS DO BD
getListProdutosR :: Handler Html
getListProdutosR = do
    addHeader "Access-Control-Allow-Origin" "*"
    addHeader "Access-Control-Allow-Methods" "GET, OPTIONS"
    produtos <- runDB $ selectList [] [Asc ProdutosNome]
    sendResponse (object [pack "resp" .= toJSON produtos])

-- FUNÇÃO QUE EDITA DADOS DE UM PRODUTOS PROCURANDO POR ID (pid)
putUpdateProdutosR :: ProdutosId -> Handler ()
putUpdateProdutosR pid = do
    produto <- requireJsonBody :: Handler Produtos
    runDB $ update pid [ProdutosNome        =. (produtosNome produto)
                      , ProdutosDescricao   =. (produtosDescricao produto)
                      , ProdutosPreco       =. (produtosPreco produto)
                      , ProdutosLocal       =. (produtosLocal produto)]
    sendResponse (object [pack "resp" .= pack "UPDATED"])