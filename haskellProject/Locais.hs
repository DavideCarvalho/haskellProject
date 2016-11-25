{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Locais where

import Foundation
import Yesod
import Database.Persist.Postgresql
import Data.Text

postLocaisR :: Handler TypedContent
postLocaisR = do 
    locais <- requireJsonBody :: Handler Locais
    uid <- runDB $ insert locais
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey uid))])