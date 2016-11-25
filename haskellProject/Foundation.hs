{-# LANGUAGE OverloadedStrings, TypeFamilies, QuasiQuotes,
             TemplateHaskell, GADTs, FlexibleContexts,
             MultiParamTypeClasses, DeriveDataTypeable, EmptyDataDecls,
             GeneralizedNewtypeDeriving, ViewPatterns, FlexibleInstances #-}
module Foundation where

import Yesod
import Data.Text
import Database.Persist.Postgresql
    ( ConnectionPool, SqlBackend, runSqlPool)

data App = App {connPool :: ConnectionPool }


share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Locais               json
    nome             Text
    localizacao      Text
    descricao        Text

Tipos_Usuarios       json
    descricao        Text
    
Usuarios             json
    nome             Text
    rg               Text
    senha            Text
    email            Text
    fk_tipo          Tipos_UsuariosId
    
Produtos             json
    nome             Text
    descricao        Text
    preco            Double
    fk_local         LocaisId
    
Reservas             json
    fk_usuario       UsuariosId
    
Reservas_Produtos    json
    fk_reserva       ReservasId
    fk_produto       ProdutosId

|]

mkYesodData "App" $(parseRoutesFile "routes")

instance Yesod App

instance YesodPersist App where
   type YesodPersistBackend App = SqlBackend
   runDB f = do
       master <- getYesod
       let pool = connPool master
       runSqlPool f pool
       
       
type Form a = Html -> MForm Handler (FormResult a, Widget)

instance RenderMessage App FormMessage where
    renderMessage _ _ = defaultFormMessage