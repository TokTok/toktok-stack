{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes        #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# OPTIONS_GHC -Wwarn #-}
module Main where

import qualified Brick.AttrMap          as A
import qualified Brick.Main             as M
import qualified Brick.Types            as T
import           Brick.Util             (on)
import           Brick.Widgets.Core
import qualified Brick.Widgets.Edit     as E
import qualified Brick.Widgets.List     as L
import           Control.Monad          (when)
import qualified Data.ByteString        as BS
import qualified Data.List              as List
import qualified Data.Text.Zipper       as Z
import qualified Data.Vector            as Vec
import qualified Graphics.Vty           as V
import           Lens.Micro
import           Lens.Micro.TH
import           Lens.Micro.Mtl


data ToxxiEvent
    = ToxEvent
    deriving (Show)

data ChatLog
    = LogLine String String String
    | LogQueryStart String String
    | LogSys String String
    deriving (Show, Eq, Ord)

data Name
    = InputLine
    | ChatLog
    | BottomBar

    | CachedLog ChatLog
    deriving (Show, Eq, Ord)

data St = St
    { _inputLine :: E.Editor String Name
    , _chatLog   :: L.List Name ChatLog
    }
    deriving (Show)

makeLenses ''St

drawUI :: St -> [T.Widget Name]
drawUI st = [renderCurrentView st]


renderCurrentView :: St -> T.Widget Name
renderCurrentView st = vBox
    [ padLeft Max $ topBar
    , padBottom Max $ L.renderList listDrawElement True (st^.chatLog)
    , bottomBar
    , input
    ]
  where
    topBar =
        withAttr toxxiBarAttr $ vLimit 1 $
            str " Remember to update your ngc_jf branch every day" <+> fill ' '
    bottomBar = cached BottomBar $
        withAttr toxxiBarAttr $ vLimit 1 $
            withAttr toxxiBracketAttr (str " [")
            <+> str "00:42"
            <+> withAttr toxxiBracketAttr (str "] [")
            <+> str "+iphy"
            <+> withAttr toxxiBracketAttr (str "] [")
            <+> str "2:The Test Chamber"
            <+> withAttr toxxiBracketAttr (str "] [")
            <+> str "Act: "
            <+> withAttr toxxiBracketAttr (str "1")
            <+> withAttr toxxiBracketAttr (str ",")
            <+> withAttr toxxiActAttr     (str "3")
            <+> withAttr toxxiBracketAttr (str ",")
            <+> withAttr toxxiBracketAttr (str "4")
            <+> withAttr toxxiBracketAttr (str ",")
            <+> withAttr toxxiActAttr     (str "6")
            <+> withAttr toxxiBracketAttr (str ",")
            <+> withAttr toxxiActHighAttr (str "7")
            <+> withAttr toxxiBracketAttr (str "]")
            <+> fill ' '
    input = str "[The Test Chamber] " <+> E.renderEditor (str . unlines) True (st^.inputLine)


listDrawElement :: Bool -> ChatLog -> T.Widget Name
listDrawElement _sel elt = cached (CachedLog elt) $ render elt
  where
    render (LogLine time author msg) =
        str time
        <+> withAttr toxxiAngleBracketAttr (str " < ")
        <+> str author
        <+> withAttr toxxiAngleBracketAttr (str "> ")
        <+> strWrap msg
    render (LogQueryStart time friend) =
        str time
        <+> withAttr toxxiSysMinusAttr (str " -")
        <+> str "!"
        <+> withAttr toxxiSysMinusAttr (str "- ")
        <+> withAttr toxxiSysWordAttr (modifyDefAttr (flip V.withURL "https://toktok.ltd") (str "Toxxi"))
        <+> withAttr toxxiSysWordAttr (str ":")
        <+> str " Starting query with "
        <+> withAttr toxxiSysWordAttr (str friend)
    render (LogSys time msg) =
        str time
        <+> withAttr toxxiSysMinusAttr (str " -")
        <+> str "!"
        <+> withAttr toxxiSysMinusAttr (str "- ")
        <+> withAttr toxxiSysWordAttr (str "Toxxi: ")
        <+> str msg


appEvent :: T.BrickEvent Name ToxxiEvent -> T.EventM Name St ()
appEvent bev@(T.VtyEvent ev) = case ev of
    V.EvPaste bs | BS.length bs > 1000 -> do
        let line = LogLine "01:31" "iphy" (show $ BS.length bs)
        oldLog <- use chatLog
        chatLog .= L.listMoveToEnd (L.listInsert (Vec.length $ L.listElements oldLog) line oldLog)
    V.EvKey V.KEsc [] -> M.halt
    V.EvKey V.KEnter [] -> do
        il <- use inputLine
        let line = LogLine "01:31" "iphy" (List.intercalate "\n" $ E.getEditContents $ il)
        inputLine .= E.applyEdit Z.clearZipper il
        oldLog <- use chatLog
        chatLog .= L.listMoveToEnd (L.listInsert (Vec.length $ L.listElements oldLog) line oldLog)

    V.EvResize{} -> do
        M.invalidateCache
        zoom inputLine $ E.handleEditorEvent bev

    _ -> zoom inputLine $ E.handleEditorEvent bev
appEvent _ = return ()


initialState :: St
initialState = St
    (E.editor InputLine (Just 1) "")
    (L.list ChatLog (Vec.fromList [LogQueryStart "01:26" "titbot"]) 1)

toxxiAttr :: A.AttrName
toxxiAttr = A.attrName "toxxi"

toxxiBarAttr :: A.AttrName
toxxiBarAttr = toxxiAttr <> A.attrName "bar"

toxxiBracketAttr :: A.AttrName
toxxiBracketAttr = toxxiAttr <> A.attrName "bracket"

toxxiAngleBracketAttr :: A.AttrName
toxxiAngleBracketAttr = toxxiAttr <> A.attrName "angleBracket"

toxxiSysMinusAttr :: A.AttrName
toxxiSysMinusAttr = toxxiAttr <> A.attrName "sysMinus"

toxxiSysWordAttr :: A.AttrName
toxxiSysWordAttr = toxxiAttr <> A.attrName "sysWord"

toxxiActAttr :: A.AttrName
toxxiActAttr = toxxiAttr <> A.attrName "act"

toxxiActHighAttr :: A.AttrName
toxxiActHighAttr = toxxiAttr <> A.attrName "actHigh"

attrMap :: A.AttrMap
attrMap = A.attrMap V.defAttr
    [ (E.editAttr,                   V.white       `on` V.black)
    , (E.editFocusedAttr,            V.white       `on` V.black)
    , (toxxiBarAttr,                 V.white       `on` V.blue)
    , (toxxiAngleBracketAttr,        V.brightBlack `on` V.black)
    , (toxxiSysMinusAttr,            V.brightBlue  `on` V.black)
    , (toxxiSysWordAttr,             V.brightWhite `on` V.black)
    , (toxxiBracketAttr,             V.cyan        `on` V.blue)
    , (toxxiActAttr,                 V.brightWhite `on` V.blue)
    , (toxxiActHighAttr,             V.brightRed   `on` V.blue)
    ]

toxxiApp :: M.App St ToxxiEvent Name
toxxiApp = M.App
    { M.appDraw = drawUI
    , M.appChooseCursor = M.showFirstCursor
    , M.appHandleEvent = appEvent
    , M.appStartEvent = return ()
    , M.appAttrMap = const attrMap
    }

buildVty :: IO V.Vty
buildVty = do
    v <- V.mkVty =<< V.standardIOConfig
    let output = V.outputIface v
    V.setMode output V.Mouse False
    when (V.supportsMode output V.BracketedPaste) $
        V.setMode output V.BracketedPaste True
    when (V.supportsMode output V.Hyperlink) $
        V.setMode output V.Hyperlink True
    return v

main :: IO ()
main = do
    initialVty <- buildVty
    st <- M.customMain initialVty buildVty Nothing toxxiApp initialState
    print st
