module View.File (view) where

import Controller.File (handleSetSort)
import Data.Tuple (Tuple(..))
import qualified Utils as U
import qualified Config as Config
import Model.File (State())
import Model.Sort (Sort(Asc, Desc), notSort)
import Utils.Halide (targetLink')
import View.Common (glyph)
import View.File.Breadcrumb (breadcrumbs)
import View.File.Common (I())
import View.File.Item (items)
import View.File.Modal (modal)
import View.File.Search (search)
import View.File.Toolbar (toolbar)
import View.Common (navbar, icon, logo, content, row)
import qualified Data.StrMap as SM
import qualified Halogen.HTML as H
import qualified Halogen.HTML.Attributes as A
import qualified Halogen.HTML.Events as E
import qualified Halogen.HTML.Events.Forms as E
import qualified Halogen.HTML.Events.Handler as E
import qualified Halogen.HTML.Events.Monad as E
import qualified Halogen.Themes.Bootstrap3 as B
import qualified View.Css as Vc



view :: forall p e. State -> H.HTML p (I e)
view state =
  H.div_ [ navbar [ H.div [ A.classes [Vc.navCont, B.containerFluid] ]
                          [ icon B.glyphiconFolderOpen, logo, search state ]
                  ]
         , content [ H.div [ A.class_ B.clearfix ]
                           [ breadcrumbs state.breadcrumbs
                           , toolbar state
                           ]
                   , row [ sorting state ]
                   , items state
                   ]
         , modal state
         ]



sorting :: forall p e. State -> H.HTML p (I e)
sorting state =
  H.div [ A.classes [B.colXs4, Vc.toolbarSort] ]
        [ H.a (targetLink' $ handleSetSort $ notSort state.sort)
              [ H.text "Name"
              , H.i [ chevron state
                    , A.style (A.styles $ SM.fromList [Tuple "margin-left" "10px"])
                    ]
                    []
              ]
        ]
  where
  chevron { sort: Asc  } = A.classes [B.glyphicon, B.glyphiconChevronUp]
  chevron { sort: Desc } = A.classes [B.glyphicon, B.glyphiconChevronDown]


