--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import Data.Monoid (mappend)
import Hakyll


--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "resources/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "posts/*" $ version "right-panel" $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= relativizeUrls

    match (fromList ["projects.markdown", "wanttoread.markdown"]) $ do
        route   $ setExtension "html"
        compile $ do
            posts <- recentFirst =<< loadAll ("posts/*" .&&. hasVersion "right-panel")
            let pageCtx =
                    listField "posts" sideBarPostCtx (return posts) `mappend`
                    defaultContext
            pandocCompiler
                >>= loadAndApplyTemplate "templates/default.html" pageCtx
                >>= relativizeUrls

    match "posts/*" $ do
        route $ setExtension "html"
        compile $ do
            posts <- recentFirst =<< loadAll ("posts/*" .&&. hasVersion "right-panel")
            let extPostCtx =
                    listField "posts" sideBarPostCtx (return posts) `mappend`
                    sideBarPostCtx
            pandocCompiler
                >>= loadAndApplyTemplate "templates/post.html"    extPostCtx
                >>= loadAndApplyTemplate "templates/default.html" extPostCtx
                >>= relativizeUrls

    create ["archive.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll ("posts/*" .&&. hasNoVersion)
            let archiveCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Archives"            `mappend`
                    constField "author" "Morten Frølich"     `mappend`
                    constField "description" "Archives"      `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls


    match "index.html" $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll ("posts/*" .&&. hasNoVersion)
            let indexCtx =
                    listField "posts" sideBarPostCtx (return posts) `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateCompiler


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext

sideBarPostCtx :: Context String
sideBarPostCtx =
    dateField "date" "%F" `mappend`
    defaultContext
